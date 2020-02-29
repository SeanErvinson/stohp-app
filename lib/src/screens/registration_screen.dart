import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/register/bloc/bloc.dart';
import 'package:stohp/src/components/register/register_form.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/values/values.dart';

class RegistrationScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegistrationScreen({Key key, @required UserRepository userRepository})
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
              Strings.register,
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ),
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: Column(
            children: <Widget>[
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
