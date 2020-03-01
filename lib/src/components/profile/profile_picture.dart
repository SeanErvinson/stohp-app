import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/profile/bloc/profile_picture_bloc.dart';
import 'package:stohp/src/models/user.dart';
import 'package:stohp/src/services/api_service.dart';

class ProfilePicture extends StatelessWidget {
  static const String _defaultProfilePic =
      "assets/images/default-profile-pic.png";
  const ProfilePicture({
    Key key,
    @required ProfilePictureBloc profilePictireBloc,
    @required User user,
  })  : _profilePictireBloc = profilePictireBloc,
        _user = user,
        super(key: key);

  final ProfilePictureBloc _profilePictireBloc;
  final User _user;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePictureBloc, ProfilePictureState>(
      bloc: _profilePictireBloc,
      builder: (context, state) {
        String avatarUrl = _user.profile.avatar;
        Widget child;
        if (state is ProfilePictureUploading) {
          child = CircularProgressIndicator();
        }
        if (state is ProfilePictureSuccess) {
          avatarUrl = state.avatarUrl;
          _user.profile.avatar = state.avatarUrl;
        }
        return CircleAvatar(
          backgroundColor: Colors.black12,
          child: child,
          maxRadius: 28,
          backgroundImage: avatarUrl != null
              ? NetworkImage(ApiService.baseUrl + avatarUrl)
              : AssetImage(_defaultProfilePic),
        );
      },
    );
  }
}
