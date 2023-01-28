import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_messenger_app/domain/image%20storage/add_to_storage_uc.dart';
import 'package:flutter_messenger_app/domain/image%20storage/get_download_url_uc.dart';

class ImageStorageProvider with ChangeNotifier {
  final AddToStorageUC _addToStorageUC;
  final GetDownloadUrlUC _getDownloadUrlUC;

  ImageStorageProvider(this._addToStorageUC, this._getDownloadUrlUC);

  String _imageUrl = "";
  String _errorMessage = "";

  String get imageUrl => _imageUrl;
  String get errorMessage => _errorMessage;

  Future addToStorage(String uid, File image) async {
    try {
      await _addToStorageUC(uid, image);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future getDownloadUrl() async {
    try {
      _imageUrl = await _getDownloadUrlUC();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
