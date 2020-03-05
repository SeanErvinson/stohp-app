import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/bloc/authentication_bloc.dart';
import 'package:stohp/src/components/register/bloc/bloc.dart';
import 'package:stohp/src/models/register_info.dart';
import 'package:stohp/src/values/values.dart';

class RegisterForm extends StatefulWidget {
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated =>
      _usernameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _firstNameController.text.isNotEmpty &&
      _lastNameController.text.isNotEmpty &&
      _emailController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _usernameController.addListener(_onUsernameChanged);
    _passwordController.addListener(_onPasswordChanged);
    _firstNameController.addListener(_onFirstNameChanged);
    _lastNameController.addListener(_onLastNameChanged);
    _emailController.addListener(_onEmailChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.registerLoading,
                      style: TextStyle(fontSize: 14.0),
                    ),
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
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.registerFailed,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Icon(Icons.error, size: 20.0),
                  ],
                ),
                backgroundColor: redPrimary,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            maxLines: 1,
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              hintText: Strings.firstNameHint,
                              hintStyle: TextStyle(fontSize: 14.0),
                              errorStyle: TextStyle(fontSize: 12.0),
                            ),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autovalidate: true,
                            validator: (_) {
                              return !state.isFirstNameValid
                                  ? Strings.firstNameWarning
                                  : null;
                            },
                          ),
                        ),
                        VerticalDivider(
                          width: 16,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            maxLines: 1,
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8.0),
                              hintText: Strings.lastNameHint,
                              hintStyle: TextStyle(fontSize: 14.0),
                              errorStyle: TextStyle(fontSize: 12.0),
                            ),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autovalidate: true,
                            validator: (_) {
                              return !state.isLastNameValid
                                  ? Strings.lastNameWarning
                                  : null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        hintText: Strings.emailHint,
                        hintStyle: TextStyle(fontSize: 14.0),
                        errorStyle: TextStyle(fontSize: 12.0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autovalidate: true,
                      validator: (_) {
                        return !state.isEmailValid
                            ? Strings.emailWarning
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
                    child: RegisterButton(
                      onPressed: isRegisterButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onUsernameChanged() {
    _registerBloc.add(
      OnUsernameChanged(username: _usernameController.text),
    );
  }

  void _onFirstNameChanged() {
    _registerBloc.add(
      OnFirstNameChanged(firstName: _firstNameController.text),
    );
  }

  void _onLastNameChanged() {
    _registerBloc.add(
      OnLastNameChanged(lastName: _lastNameController.text),
    );
  }

  void _onEmailChanged() {
    _registerBloc.add(
      OnEmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _registerBloc.add(
      OnPasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    RegisterInfo registerInfo = RegisterInfo();
    registerInfo.username = _usernameController.text;
    registerInfo.password = _passwordController.text;
    registerInfo.firstName = _firstNameController.text;
    registerInfo.lastName = _lastNameController.text;
    registerInfo.email = _emailController.text;
    _registerBloc.add(
      OnSubmitted(userInfo: registerInfo),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
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
          Strings.signup,
          style: navigationTitle,
        ),
      ),
    );
  }
}
