import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/DefaultBlocDelegate.dart';
import 'package:stohp/src/components/common/bloc/authentication_bloc.dart';
import 'package:stohp/src/components/common/bloc/greet_bloc.dart';
import 'package:stohp/src/repository/activity_repository.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/screens/screens.dart';
import 'package:bloc/bloc.dart';
import 'package:stohp/src/values/values.dart';

import 'components/common/bloc/dialog_bloc.dart';
import 'components/common/wake_dialog.dart';
import 'components/home/services/bloc/wake_bloc.dart';
import 'components/home/services/bloc/stop_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = DefaultBlocDelegate();
  final UserRepository userRepository = UserRepository();
  final ActivityRepository activityRepository =
      ActivityRepository(userRepository: userRepository);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(userRepository: userRepository)
                  ..add(AppStarted())),
        BlocProvider<DialogBloc>(
          create: (context) => DialogBloc(),
        ),
        BlocProvider<WakeBloc>(
          create: (context) => WakeBloc(
              activityRepository: activityRepository,
              dialogBloc: BlocProvider.of<DialogBloc>(context)),
        ),
        BlocProvider<StopBloc>(
          create: (context) => StopBloc(userRepository),
        ),
      ],
      child: StohpApp(
        userRepository: userRepository,
      ),
    ),
  );
}

class StohpApp extends StatelessWidget {
  final UserRepository _userRepository;

  const StohpApp({Key key, UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stohp',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          button: button,
          title: title,
          subtitle: subtitle,
          subhead: subHead,
        ),
      ),
      routes: {
        "welcome": (context) => WelcomeScreen(),
        "login": (context) => LoginScreen(
              userRepository: _userRepository,
            ),
        "registration": (context) => RegistrationScreen(
              userRepository: _userRepository,
            ),
        "profile": (context) => ProfileScreen(),
        "home": (context) => HomeScreen(),
        "personal-info": (context) => ProfilePersonalInfoScreen(),
        "view-finder": (context) => ViewFinderScreen(),
        "location-destination": (context) => LocationDestinationScreen(),
        "privacy-policy": (context) => PrivacyPolicyScreen(),
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return WelcomeScreen();
          }
          if (state is Unauthenticated) {
            return WelcomeScreen();
          }
          if (state is Authenticated) {
            return BlocBuilder<DialogBloc, DialogState>(
              condition: (previousState, state) {
                if (previousState is DialogVisible && state is DialogVisible) {
                  return false;
                }
                return true;
              },
              bloc: BlocProvider.of<DialogBloc>(context),
              builder: (context, dialogState) {
                if (dialogState is DialogVisible) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return WakeDialog();
                      },
                    );
                  });
                }
                return BlocProvider<GreetBloc>(
                  create: (context) => GreetBloc()..add(GetGreetings()),
                  child: HomeScreen(user: state.user),
                );
              },
            );
          }
        },
      ),
    );
  }
}
