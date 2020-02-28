import 'package:flutter/material.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/services/api_service.dart';
import 'package:stohp/src/values/values.dart';

class ProfileHeader extends StatelessWidget {
  static const String _defaultProfilePic =
      "assets/images/default-profile-pic.png";
  final User _user;

  const ProfileHeader({
    Key key,
    @required User user,
  })  : this._user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: CircleAvatar(
              maxRadius: 28,
              backgroundImage: _user.profile.avatar != null
                  ? NetworkImage(ApiService.baseUrl + _user.profile.avatar)
                  : AssetImage(_defaultProfilePic),
            ),
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
              GestureDetector(
                onTap: () {},
                child: Text(
                  Strings.editProfile,
                  style: TextStyle(
                    color: bluePrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
          boxShadow: []),
    );
  }
}
