import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageHelper {
  Future<String?> uploadImageFromFile(File file);
}

class StorageHelperImp extends StorageHelper {
  @override
  Future<String?> uploadImageFromFile(File file) async {
    String? imgUrl;
    final storageRef = FirebaseStorage.instance.ref();
    final uploadTask = storageRef
        .child('PlacesImages/${file.path.split('/').last}')
        .putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
    if (taskSnapshot.state == TaskState.running) {
      print(
          'progress: ${100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes)}');
    } else if (taskSnapshot.state == TaskState.error) {
      throw Exception("failed");
    } else if (taskSnapshot.state == TaskState.success) {
      imgUrl = await taskSnapshot.ref.getDownloadURL();
    }
    print(imgUrl);
    return imgUrl;
  }
}
