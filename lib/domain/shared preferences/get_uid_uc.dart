import 'package:flutter_messenger_app/data/repository/shared_preferences_repository.dart';

class GetUidUC {
  final SharedPreferencesRepository _sharedPreferencesRepository;

  GetUidUC(this._sharedPreferencesRepository);

  Future<String> call() async {
    String uid = await _sharedPreferencesRepository.getUid();
    return uid;
  }
}
