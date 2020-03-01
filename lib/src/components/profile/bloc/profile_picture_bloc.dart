import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:stohp/src/repository/user_repository.dart';

part 'profile_picture_event.dart';
part 'profile_picture_state.dart';

class ProfilePictureBloc
    extends Bloc<ProfilePictureEvent, ProfilePictureState> {
  @override
  ProfilePictureState get initialState => ProfilePictureInitial();

  @override
  Stream<ProfilePictureState> mapEventToState(
    ProfilePictureEvent event,
  ) async* {
    if (event is PickImage) {
      yield* _mapPickImage();
    } else if (event is UploadImage) {
      yield* _mapUploadImage(event.imageFile);
    }
  }

  Stream<ProfilePictureState> _mapPickImage() async* {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      yield ProfilePictureUploading();
      add(UploadImage(image));
    } else {
      yield ProfilePictureFailed();
    }
  }

  Stream<ProfilePictureState> _mapUploadImage(File imageFile) async* {
    var filename = path.basename(imageFile.path);
    var base64Image = base64Encode(await imageFile.readAsBytes());
    UserRepository _userRepository = UserRepository();
    String avatarUrl =
        await _userRepository.uploadAvatar(filename, base64Image);
    if (avatarUrl != null)
      yield ProfilePictureSuccess(avatarUrl);
    else
      yield ProfilePictureFailed();
  }
}
