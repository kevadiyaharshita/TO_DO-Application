import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlatformController extends ChangeNotifier {
  bool _isIOS = Platform.isAndroid;
  late SharedPreferences preferences;

  PlatformController({required this.preferences});

  get getPlatformConverter {
    _isIOS = preferences.getBool('platform') ?? false;
    return _isIOS;
  }

  changePlatform() {
    _isIOS = !_isIOS;
    preferences.setBool('platform', _isIOS);
    notifyListeners();
  }
}
