import 'package:flutter/cupertino.dart';

class StatusController extends ChangeNotifier {
  String Status = "";
  String Important = "";

  resetDate() {
    Status = "";
    Important = "";
    notifyListeners();
  }

  StatusChanged({required String s}) {
    Status = s;
    notifyListeners();
  }

  ImportantChanged({required String i}) {
    Important = i;
    notifyListeners();
  }
}
