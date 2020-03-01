import 'package:flutter/material.dart';
import 'package:stohp/src/components/profile/edit_profile.dart';
import 'package:stohp/src/components/profile/profile_picture.dart';
import 'package:stohp/src/models/user.dart';

import 'bloc/profile_picture_bloc.dart';

class ProfileHeader extends StatelessWidget {
  final User _user;

  const ProfileHeader({
    Key key,
    @required User user,
  })  : this._user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final _profilePictireBloc = ProfilePictureBloc();
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: ProfilePicture(
                profilePictireBloc: _profilePictireBloc, user: _user),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${_user.firstName} ${_user.lastName}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              EditProfile(profilePictireBloc: _profilePictireBloc),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
      ),
    );
  }
}
