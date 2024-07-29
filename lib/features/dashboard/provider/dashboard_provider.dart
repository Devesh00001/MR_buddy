import 'package:flutter/material.dart';
import 'package:mr_buddy/features/dashboard/service/dashboard_service.dart';

import '../../weekly plan/model/visit.dart';

class DashboardProvider with ChangeNotifier {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  int completedVisits = 70;
  Map<String, Visit> weeklyPlan = {};

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

  Future<Map<String, Visit>> getWeeklyPlan(String username) async {
    DashboardService service = DashboardService();
    weeklyPlan = await service.getWeekVisits(username);
    return weeklyPlan;
  }
}
