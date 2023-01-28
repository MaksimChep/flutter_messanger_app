import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<String> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    String? uid = prefs.getString('userId');
    return uid ?? '';
  }

  Future setUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', uid);
  }
}
