import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/navigation_appbar.dart';
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
        body: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: Column(
            children: <Widget>[
              NavigationAppbar(
                title: Strings.register,
              ),
              RegisterForm(),
            ],
          ),
        ),
      ),
    );
  }
}
