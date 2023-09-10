import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends ChangeNotifier {
  bool _isSplash = true;
  // SharedPreferences preferences;

  // SplashScreenController({required this.preferences});

  get getSplash {
    // isSplash = preferences.getBool('theme') ?? true;
    return _isSplash;
  }

  changeSplash() {
    _isSplash = false;
    // preferences.setBool('theme', isSplash);
    notifyListeners();
  }
}
