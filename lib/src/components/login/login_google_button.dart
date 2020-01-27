import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/login/bloc/bloc.dart';
import 'package:stohp/src/values/values.dart';

class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton.icon(
        icon: Image.asset(
          "assets/icons/google-logo.png",
          height: 32.0,
        ),
        onPressed: () {
          BlocProvider.of<LoginBloc>(context).add(
            LoginWithGooglePressed(),
          );
        },
        label: Text(Strings.googleLogin,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
            )),
        color: Color.fromRGBO(66, 133, 244, 1),
      ),
    );
  }
}
