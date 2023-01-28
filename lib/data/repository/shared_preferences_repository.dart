abstract class SharedPreferencesRepository {
  Future<String> getUid();
  Future setUid(String uid);
}
