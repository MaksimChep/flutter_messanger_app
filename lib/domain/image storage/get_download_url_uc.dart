import 'package:flutter_messenger_app/data/repository/image_storage_repository.dart';

class GetDownloadUrlUC {
  final ImageStorageRepository _imageStorageRepository;

  GetDownloadUrlUC(this._imageStorageRepository);

  Future<String> call() async {
    String url = await _imageStorageRepository.getDownloadUrl();
    return url;
  }
}
