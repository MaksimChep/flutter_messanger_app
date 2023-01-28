import 'package:flutter_messenger_app/data/repository/shared_preferences_repository.dart';

class SetUidUC {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  SetUidUC(this._sharedPreferencesRepository);

  Future call(String uid) async {
    await _sharedPreferencesRepository.setUid(uid);
  }
}
