import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/DefaultBlocDelegate.dart';
import 'package:stohp/src/components/common/authentication_bloc/bloc.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/screens/screens.dart';
import 'package:bloc/bloc.dart';
import 'package:stohp/src/values/values.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = DefaultBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
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
          "welcome": (context) => WelcomeScreen(
                userRepository: _userRepository,
              ),
          "login": (context) => LoginScreen(
                userRepository: _userRepository,
              ),
          "registration": (context) => RegistrationScreen(
                userRepository: _userRepository,
              ),
          "setting": (context) => SettingScreen(),
          "home": (context) => HomeScreen(),
          "splash": (context) => SplashScreen(),
          "location-destination": (context) => LocationDestinationScreen(),
        },
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is Uninitialized) {
            return HomeScreen();
          }
          if (state is Unauthenticated) {
            return WelcomeScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.displayName);
          }
        }));
  }
}
