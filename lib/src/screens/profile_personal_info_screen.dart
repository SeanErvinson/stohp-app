import 'package:flutter/material.dart';
import 'package:stohp/src/components/profile/personal_info_form.dart';
import 'package:stohp/src/components/profile/profile_screen_argument.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/values/strings.dart';
import 'package:stohp/src/values/values.dart';

class ProfilePersonalInfoScreen extends StatelessWidget {
  static const double appBarHeight = 48.0;
  @override
  Widget build(BuildContext context) {
    final UserArgument args = ModalRoute.of(context).settings.arguments;
    final User user = args.user;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
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
              Strings.personalInfoHeader,
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height -
                    appBarHeight -
                    MediaQuery.of(context).padding.top,
                child: PersonalInfoForm(user: user))),
      ),
    );
  }
}
