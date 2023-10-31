import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  Future<File?> pickImageFromGallery();
}

class ImagePickerHelperImpl extends ImagePickerHelper {
  @override
  Future<File?> pickImageFromGallery() => ImagePicker()
      .pickImage(source: ImageSource.camera)
      .then((file) => file == null ? null : File(file.path));
}
