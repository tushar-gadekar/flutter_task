import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositry {
  static const _sessionKey = 'is_logged_in';
  static const _emailKey = 'user_email';

  static const _mockEmail = 'investor@demo.com';
  static const _mockPass = 'demo123';

  Future<bool> login(String email, String pass) async {
    await Future.delayed(const Duration(milliseconds: 900));
    if (email.trim() == _mockEmail && pass == _mockPass) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_sessionKey, true);
      await prefs.setString(_emailKey, email);
      return true;
    }
    return false;
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_sessionKey) ?? false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
    await prefs.remove(_emailKey);
  }

  Future<String> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey) ?? '';
  }
}