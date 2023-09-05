import 'package:flutter/material.dart';

class BGController extends ChangeNotifier {
  List<String> _bgimage = [
    'assets/images/theme/theme1.jpg',
    'assets/images/theme/theme2.jpg',
    'assets/images/theme/theme4.jpg'
  ];

  get getBgImage {
    return _bgimage;
  }

  void SetBgImage({required String path, required int index}) {
    _bgimage[index] = path;
    notifyListeners();
  }
}
