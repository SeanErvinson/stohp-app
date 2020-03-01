import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stohp/src/components/profile/bloc/profile_picture_bloc.dart';
import 'package:stohp/src/values/values.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    Key key,
    @required ProfilePictureBloc profilePictireBloc,
  })  : _profilePictireBloc = profilePictireBloc,
        super(key: key);

  final ProfilePictureBloc _profilePictireBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilePictureBloc, ProfilePictureState>(
      bloc: _profilePictireBloc,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => _profilePictireBloc.add(PickImage()),
          child: Text(
            Strings.editProfile,
            style: TextStyle(
              color: bluePrimary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              decoration: TextDecoration.underline,
            ),
          ),
        );
      },
    );
  }
}
