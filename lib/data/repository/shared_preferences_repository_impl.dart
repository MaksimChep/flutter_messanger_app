import 'package:flutter_messenger_app/data/repository/shared_preferences_repository.dart';
import 'package:flutter_messenger_app/data/services/shared_preferences_service.dart';

class SharedPreferencesRepositoryImpl extends SharedPreferencesRepository {
  final SharedPreferencesService _sharedPreferencesService;

  SharedPreferencesRepositoryImpl(this._sharedPreferencesService);

  @override
  Future<String> getUid() async {
    String uid = await _sharedPreferencesService.getUid();
    return uid;
  }

  @override
  Future setUid(String uid) async {
    await _sharedPreferencesService.setUid(uid);
  }
}
