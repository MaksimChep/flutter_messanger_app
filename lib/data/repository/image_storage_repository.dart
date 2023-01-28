import 'dart:io';

abstract class ImageStorageRepository {
  Future addToStorage(String uid, File image);
  Future<String> getDownloadUrl();
}
