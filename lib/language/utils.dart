import 'package:shared_preferences/shared_preferences.dart';

class MiscUtil {
  Future<String> getLocale() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('locale') ?? 'en';
  }

  setLocale(String locale) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale);
  }
}
