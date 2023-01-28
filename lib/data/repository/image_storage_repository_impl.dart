import 'dart:io';

import 'package:flutter_messenger_app/data/repository/image_storage_repository.dart';
import 'package:flutter_messenger_app/data/services/firebase_storage_service.dart';

class ImageStorageRepositoryImpl extends ImageStorageRepository {
  final FirebaseStorageService _firebaseStorageService;

  ImageStorageRepositoryImpl(this._firebaseStorageService);

  @override
  Future addToStorage(String uid, File image) async {
    await _firebaseStorageService.addToStorage(uid, image);
  }

  @override
  Future<String> getDownloadUrl() async {
    String url = await _firebaseStorageService.getDownloadUrl();
    return url;
  }
}
