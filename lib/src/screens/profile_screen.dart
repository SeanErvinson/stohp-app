import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/common/bloc/authentication_bloc.dart';
import 'package:stohp/src/components/common/stohp_icons.dart';
import 'package:stohp/src/components/profile/profile_header.dart';
import 'package:stohp/src/components/profile/profile_screen_argument.dart';
import 'package:stohp/src/components/profile/profile_tile.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/values/values.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserArgument args = ModalRoute.of(context).settings.arguments;
    final User user = args.user;
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
              Strings.profile,
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            ProfileHeader(
              user: user,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Strings.accountSettings,
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                    ProfileListTile(
                      title: Strings.personalInfo,
                      icon: Stohp.user,
                      onPressed: () => Navigator.of(context).pushNamed(
                          "personal-info",
                          arguments: UserArgument(user: user)),
                    ),
                    Divider(height: 1),
                    Spacer(),
                    ProfileListTile(
                      title: Strings.privacyPolicy,
                      icon: Icons.lock,
                      onPressed: () =>
                          Navigator.of(context).pushNamed("privacy-policy"),
                    ),
                    Divider(height: 1),
                    ProfileListTile(
                      title: Strings.logout,
                      icon: Icons.exit_to_app,
                      iconColor: colorSecondary,
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return _buildLogoutConfirmationDialog(context);
                        },
                      ),
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: Strings.appName,
                          style:
                              TextStyle(fontSize: 10.0, color: Colors.black87),
                          children: [
                            TextSpan(text: "\n"),
                            TextSpan(text: Strings.version),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AlertDialog _buildLogoutConfirmationDialog(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentTextStyle: primaryBaseText.copyWith(fontSize: 14.0),
      content: Text(
        Strings.logoutConfirmation,
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            Strings.cancel,
            style: secondaryBaseText.copyWith(fontSize: 12),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text(
            Strings.logout,
            style: secondaryAppText.copyWith(fontSize: 12),
          ),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
          },
        ),
      ],
    );
  }
}
