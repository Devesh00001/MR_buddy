import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  int completedVisits = 70;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fromDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != fromDate) {
      fromDate = picked;
      notifyListeners();
    }
  }
}
