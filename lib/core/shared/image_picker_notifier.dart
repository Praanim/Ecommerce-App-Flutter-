import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as developer;

///custom image picker provider
final imagePickerProvider =
    StateNotifierProvider.autoDispose<CustomImagePicker, File?>(
        (ref) => CustomImagePicker());

class CustomImagePicker extends StateNotifier<File?> {
  CustomImagePicker() : super(null);

  final ImagePicker imagePicker = ImagePicker();

  void pickImageFromGallery() async {
    try {
      final xfile = await imagePicker.pickImage(source: ImageSource.gallery);
      if (xfile == null) {
        state = null;
      } else {
        state = File(xfile.path);
        //success case
      }
    } catch (e) {
      developer.log(e.toString());
      state = null;
    }
  }

  void resetState() {
    state = null;
  }
}
