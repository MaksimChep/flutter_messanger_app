import 'package:flutter/cupertino.dart';
import 'package:flutter_messenger_app/domain/shared%20preferences/get_uid_uc.dart';
import 'package:flutter_messenger_app/domain/shared%20preferences/set_uid_uc.dart';

class SharedPreferencesProvider with ChangeNotifier {
  final GetUidUC _getUidUC;
  final SetUidUC _setUidUC;

  SharedPreferencesProvider(this._getUidUC, this._setUidUC);

  String _uid = "";
  String _errorMessage = "";

  String get uid => _uid;
  String get errorMessage => _errorMessage;

  Future getUid() async {
    try {
      _uid = await _getUidUC();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void setUid(String uid) async {
    try {
      await _setUidUC(uid);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
