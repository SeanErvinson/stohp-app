import 'package:flutter/material.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/values/values.dart';

class PersonalInfoForm extends StatefulWidget {
  final User _user;

  const PersonalInfoForm({Key key, User user})
      : this._user = user,
        super(key: key);

  @override
  _PersonalInfoFormState createState() => _PersonalInfoFormState(_user);
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final User user;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  _PersonalInfoFormState(this.user);

  @override
  void initState() {
    _firstNameController.text = user.firstName != null ? user.firstName : "";
    _lastNameController.text = user.lastName != null ? user.lastName : "";
    _emailController.text = user.email != null ? user.email : "";
    // _firstNameController.addListener(listener);
    // _lastNameController.addListener(listener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _firstNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: Strings.firstName,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, size: 14.0),
                  onPressed: () => _firstNameController.clear(),
                ),
              ),
            ),
            TextFormField(
              controller: _lastNameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: Strings.lastName,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, size: 14.0),
                  onPressed: () => _lastNameController.clear(),
                ),
              ),
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: Strings.email,
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear, size: 14.0),
                  onPressed: () => _lastNameController.clear(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }
}
