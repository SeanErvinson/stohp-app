part of 'profile_picture_bloc.dart';

@immutable
abstract class ProfilePictureEvent {}

class PickImage extends ProfilePictureEvent {}

class UploadImage extends ProfilePictureEvent {
  final File imageFile;

  UploadImage(this.imageFile);
}
