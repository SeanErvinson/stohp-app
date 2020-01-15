import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/bloc/DefaultBlocDelegate.dart';
import 'package:stohp/src/bloc/authentication_bloc/bloc.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/screens/screens.dart';
import 'package:bloc/bloc.dart';
import './values/styles.dart';

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
          "login": (context) => LoginScreen(),
          "registration": (context) => RegistrationScreen(),
          "setting": (context) => SettingScreen(),
          "navigation": (context) => NavigationScreen(),
          "home": (context) => HomeScreen(),
          "splash": (context) => SplashScreen(),
        },
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          } else if (state is Authenticated) {
            return HomeScreen(
              // Change to user model
              name: state.displayName,
            );
          }

          return Container();
        }));
  }
}
