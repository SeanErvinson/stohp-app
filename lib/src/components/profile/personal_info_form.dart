import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/profile/bloc/personal_info_bloc.dart';
import 'package:stohp/src/models/gender_type.dart';
import 'package:stohp/src/models/personal_info.dart';
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
  User user;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final PersonalInfoBloc _bloc = PersonalInfoBloc();
  _PersonalInfoFormState(this.user);
  String _dropDownValue;

  @override
  void initState() {
    _firstNameController.text = user.firstName != null ? user.firstName : "";
    _lastNameController.text = user.lastName != null ? user.lastName : "";
    _emailController.text = user.email != null ? user.email : "";
    _dropDownValue = GenderType.parseGender(user.profile.gender).code;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoBloc, PersonalInfoState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is PersonalInfoSuccess) {
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
                      Strings.updateSuccess,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Icon(Icons.error, size: 20.0)
                  ],
                ),
                backgroundColor: greenPrimary,
              ),
            );
        } else if (state is PersonalInfoFailed) {
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
                      Strings.updateFailed,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Icon(Icons.error, size: 20.0)
                  ],
                ),
                backgroundColor: redPrimary,
              ),
            );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Form(
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
                DropdownButtonFormField(
                  isDense: true,
                  isExpanded: true,
                  decoration: InputDecoration(
                    labelText: Strings.gender,
                  ),
                  value: _dropDownValue,
                  onChanged: (val) {
                    setState(
                      () {
                        _dropDownValue = val;
                      },
                    );
                  },
                  items: GenderType.getGenders()
                      .map((GenderType gender) {
                        return DropdownMenuItem(
                            child: Text(gender.name),
                            value: gender.code,
                          );
                      })
                      .toList(),
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
                ),
              ],
            ),
          ),
          Expanded(child: SizedBox()),
          Container(
            width: double.infinity,
            child: BlocBuilder<PersonalInfoBloc, PersonalInfoState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is PersonalInfoSuccess) {
                  user.firstName = state.user.firstName;
                  user.lastName = state.user.lastName;
                  user.email = state.user.email;
                  user.profile = state.user.profile;
                }
                return FlatButton(
                  child: Text(
                    Strings.save,
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  color: colorSecondary,
                  onPressed: () {
                    PersonalInfo personalInfo = PersonalInfo();
                    personalInfo.id = user.id;
                    personalInfo.username = user.username;
                    personalInfo.email = _emailController.text.length != 0
                        ? _emailController.text
                        : user.email;
                    personalInfo.firstName =
                        _firstNameController.text.length != 0
                            ? _firstNameController.text
                            : user.firstName;
                    personalInfo.lastName = _lastNameController.text.length != 0
                        ? _lastNameController.text
                        : user.lastName;
                    personalInfo.gender = _dropDownValue != null
                        ? _dropDownValue
                        : user.profile.gender;
                    _bloc.add(SavePersonalInfo(personalInfo));
                  },
                );
              },
            ),
          ),
        ]),
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
