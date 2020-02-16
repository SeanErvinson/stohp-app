import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/authentication_bloc/authentication_bloc.dart';
import 'package:stohp/src/components/login/bloc/bloc.dart';
import 'package:stohp/src/components/login/login_google_button.dart';
import 'package:stohp/src/repository/user_repository.dart';
import 'package:stohp/src/values/values.dart';

class WelcomeScreen extends StatelessWidget {
  final UserRepository _userRepository;

  WelcomeScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _usableScreenHeight = MediaQuery.of(context).size.height;
    final _usableScreenWidth = MediaQuery.of(context).size.width;
    final _logoSize = 140.0;
    final _loginBloc = LoginBloc(userRepository: _userRepository);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      bloc: _loginBloc,
      child: SafeArea(
        child: Scaffold(
          body: BlocProvider<LoginBloc>(
            create: (context) => _loginBloc,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    child: Image.asset(
                      "assets/icons/logo-banner-foreground.png",
                      width: _logoSize,
                    ),
                    top: _usableScreenHeight * .1,
                    left: (_usableScreenWidth * .5) - (_logoSize * .5)),
                Positioned(
                  width: _usableScreenWidth,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        GoogleLoginButton(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Flexible(flex: 1, child: LoginButton()),
                            SizedBox(
                              width: 32.0,
                            ),
                            Flexible(flex: 1, child: SignUpButton()),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Color.fromRGBO(194, 194, 194, .45),
        child: Text(
          Strings.signup,
          textAlign: TextAlign.center,
          style: navigationTitle,
        ),
        onPressed: () {
          Navigator.pushNamed(context, "registration");
        },
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Color.fromRGBO(194, 194, 194, .45),
        onPressed: () {
          Navigator.pushNamed(context, "login");
        },
        child: Text(
          Strings.login,
          style: navigationTitle,
        ),
      ),
    );
  }
}
