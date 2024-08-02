import 'package:flutter/material.dart';
import 'package:mr_buddy/features/dashboard/service/dashboard_service.dart';
import 'package:mr_buddy/features/mr/service/mr_service.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';

import '../../weekly plan/model/visit.dart';
import '../../welcome/service/welcome_service.dart';

class DashboardProvider with ChangeNotifier {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  int completedVisits = 70;
  Map<String, Visit> weeklyPlan = {};
  Map<String, User> mrListMap = {};
  bool approve = false;
  bool isLoading = false;

  void changeStatusOfLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

  isWeeklyPlanStatus(String mrname) async {
    MRService service = MRService();
    approve = await service.isWeeklyPlanStatus(mrname);
    notifyListeners();
  }

  updateStatusOfWeeklyPlan(String mrName) async {
    changeStatusOfLoading();
    MRService service = MRService();
    approve = await service.approveWeeklyPlanStatus(mrName);
    changeStatusOfLoading();
    notifyListeners();
  }

  Future<Map<String, User>> getAllMRDetail(List<String> mrNameList) async {
    WelcomeService service = WelcomeService();
    mrListMap.clear();
    for (int i = 0; i < mrNameList.length; i++) {
      mrListMap[mrNameList[i]] = await service.isUsernamePresent(mrNameList[i]);
    }
    return mrListMap;
  }

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
    weeklyPlan.clear();
    weeklyPlan = await service.getWeekVisits(username);
    return weeklyPlan;
  }
}
