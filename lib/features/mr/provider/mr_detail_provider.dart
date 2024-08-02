import 'package:flutter/material.dart';

class MRDetailProvider with ChangeNotifier {
  bool approve = false;

  isWeeklyPlanStatus() {
    notifyListeners();
  }
}
