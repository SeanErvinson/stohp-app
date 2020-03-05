import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/bloc/authentication_bloc.dart';
import 'package:stohp/src/components/login/bloc/bloc.dart';
import 'package:stohp/src/values/values.dart';

class LoginForm extends StatefulWidget {
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.loginFailed,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Icon(Icons.error, size: 20.0)
                  ],
                ),
                backgroundColor: redPrimary,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(Strings.loginLoading,
                        style: TextStyle(fontSize: 14.0)),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      maxLines: 1,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        hintText: Strings.usernameHint,
                        hintStyle: TextStyle(fontSize: 14.0),
                        errorStyle: TextStyle(fontSize: 12.0),
                      ),
                      keyboardType: TextInputType.text,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isUsernameValid
                            ? Strings.usernameWarning
                            : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      maxLines: 1,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        hintText: Strings.passwordHint,
                        hintStyle: TextStyle(fontSize: 14.0),
                        errorStyle: TextStyle(fontSize: 12.0),
                      ),
                      obscureText: true,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isPasswordValid
                            ? Strings.passwordWarning
                            : null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: LogInButton(
                      onPressed:
                          isLoginButtonEnabled(state) ? _onFormSubmitted : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    _loginBloc.add(
      OnUsernameChanged(username: _usernameController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      OnPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        username: _usernameController.text,
        password: _passwordController.text,
      ),
    );
  }
}

class LogInButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LogInButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
        disabledColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: colorSecondary,
        onPressed: _onPressed,
        child: Text(
          Strings.login,
          style: navigationTitle,
        ),
      ),
    );
  }
}
