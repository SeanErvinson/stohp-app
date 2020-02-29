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
            title: Text(
              Strings.login,
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository: _userRepository),
          child: Column(
            children: <Widget>[
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
