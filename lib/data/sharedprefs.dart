import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

class Sharedprfs {
  static Future<void> init() async {}

  static final email = prefs.getString('email');
  static final password = prefs.getString('password');

  static setemail(String email) async {
    await prefs.setString('email', email);
  }

  static setpassword(String password) {
    prefs.setString('password', password);
  }

 static removeemailAndPassword() {
    prefs.remove('email');
    prefs.remove('password');
  }
}
