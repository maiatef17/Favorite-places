import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  Future<File?> pickImage(ImageSource source);
}

class ImagePickerHelperImpl extends ImagePickerHelper {
  @override
  Future<File?> pickImage(ImageSource source) => ImagePicker()
      .pickImage(source: source)
      .then((file) => file == null ? null : File(file.path));
}
