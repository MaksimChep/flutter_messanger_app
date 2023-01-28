import 'dart:io';

import 'package:flutter_messenger_app/data/repository/image_storage_repository.dart';

class AddToStorageUC {
  final ImageStorageRepository _imageStorageRepository;

  AddToStorageUC(this._imageStorageRepository);

  Future call(String uid, File image) async {
    await _imageStorageRepository.addToStorage(uid, image);
  }
}
