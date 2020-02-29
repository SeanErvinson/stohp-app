part of 'profile_picture_bloc.dart';

@immutable
abstract class ProfilePictureState {}

class ProfilePictureInitial extends ProfilePictureState {}

class ProfilePictureSuccess extends ProfilePictureState {
  final String avatarUrl;

  ProfilePictureSuccess(this.avatarUrl);
}

class ProfilePictureFailed extends ProfilePictureState {}

class ProfilePictureUploading extends ProfilePictureState {}
