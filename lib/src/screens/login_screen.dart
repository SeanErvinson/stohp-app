import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/login/bloc/bloc.dart';
import 'package:stohp/src/components/login/login_form.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/values/values.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;
  static const double appBarHeight = 48.0;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: AppBar(
            titleSpacing: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
              color: Colors.black87,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height -
                appBarHeight -
                MediaQuery.of(context).padding.top,
            child: BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(userRepository: _userRepository),
              child: Column(
                children: <Widget>[
                  Container(
                    height: _usableScreenHeight * .15,
                    alignment: Alignment.topCenter,
                    child: Text(
                      Strings.loginHeader.toUpperCase(),
                      style: TextStyle(
                          color: colorSecondary,
                          fontSize: 24.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  LoginForm()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
