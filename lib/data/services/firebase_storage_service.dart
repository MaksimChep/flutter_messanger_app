import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference? imageRef;

  Future addToStorage(String uid, File image) async {
    final storageRef = _firebaseStorage.ref();

    imageRef = storageRef.child('$uid/${basename(image.path)}');

    await imageRef!.putFile(image);
  }

  Future<String> getDownloadUrl() async {
    String url = await imageRef!.getDownloadURL();
    return url;
  }
}
