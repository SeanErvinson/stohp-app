import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/login/bloc/bloc.dart';
import 'package:stohp/src/components/login/login_form.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/values/values.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Navigator.of(context).pop(),
                      iconSize: 20,
                      color: Colors.black54,
                    ),
                    Text(
                      'Log In',
                      style: navigationDarkTitle,
                    ),
                  ],
                ),
              ),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
