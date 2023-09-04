import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimeController extends ChangeNotifier {
  DateTime? d = DateTime.now();
  TimeOfDay? t = TimeOfDay.now();

  resetDate() {
    d = DateTime.now();
    t = TimeOfDay.now();
    notifyListeners();
  }

  dateChanged({required DateTime dateTime}) {
    d = dateTime;
    notifyListeners();
  }

  clearDateTime() {
    t = null;
    d = null;
    notifyListeners();
  }

  DateTime dateConverter({required String date}) {
    List<String> dd = date.split("/");
    DateTime d = DateTime(int.parse(dd[2]), int.parse(dd[1]), int.parse(dd[0]));
    notifyListeners();
    return d;
  }

  TimeOfDay timeConvertor({required String time}) {
    List<String> tt = time.split(":");
    TimeOfDay t = TimeOfDay(hour: int.parse(tt[0]), minute: int.parse(tt[1]));
    notifyListeners();
    return t;
  }

  timeChanged({required TimeOfDay time}) {
    t = time;
    notifyListeners();
  }
}
