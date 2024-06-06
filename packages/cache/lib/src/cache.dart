import 'package:shared_preferences/shared_preferences.dart';

abstract class TokenStorage {
  Future<String?> readToken();

  Future<void> writeToken(String token);

  Future<String?> readRefreshToken();

  Future<void> writeRefreshToken(String refreshToken);

  Future<void> deleteToken();
}

// dark mode
abstract class ThemeStorage {
  Future<bool> readDarkMode();

  Future<void> writeDarkMode(bool isDarkMode);
}

class Cache implements TokenStorage, ThemeStorage {
  @override
  Future<String?> readToken() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('token');
    });
  }

  @override
  Future<void> writeToken(String token) {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setString('token', token);
    });
  }

  @override
  Future<String?> readRefreshToken() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getString('refreshToken');
    });
  }

  @override
  Future<void> writeRefreshToken(String refreshToken) {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setString('refreshToken', refreshToken);
    });
  }

  @override
  Future<void> deleteToken() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.remove('token');
    }).then((_) {
      SharedPreferences.getInstance().then((prefs) {
        return prefs.remove('refreshToken');
      });
    });
  }

  @override
  Future<bool> readDarkMode() {
    return SharedPreferences.getInstance().then((prefs) {
      return prefs.getBool('isDarkMode') ?? false;
    });
  }

  @override
  Future<void> writeDarkMode(bool isDarkMode) {
    return SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDarkMode', isDarkMode);
    });
  }
}
