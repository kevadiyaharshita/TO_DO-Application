import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends ChangeNotifier {
  bool isSplash = true;
  SharedPreferences preferences;

  SplashScreenController({required this.preferences});

  get getSplash {
    isSplash = preferences.getBool('theme') ?? true;
    return isSplash;
  }

  changeSplash() {
    isSplash = false;
    preferences.setBool('theme', isSplash);
    notifyListeners();
  }
}
