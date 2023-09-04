import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkTheme = false;
  late SharedPreferences preferences;

  ThemeController({required this.preferences});

  get getTheme {
    _isDarkTheme = preferences.getBool('theme') ?? false;
    return _isDarkTheme;
  }

  changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    preferences.setBool('theme', _isDarkTheme);
    notifyListeners();
  }
}
