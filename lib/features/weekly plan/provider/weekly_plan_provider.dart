import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/features/weekly%20plan/service/weekly_plan_service.dart';

import '../model/visit.dart';

class WeeklyProviderPlan with ChangeNotifier {
  DateTime focusDate = DateTime.now();

  DateTime monday = DateTime.now()
      .subtract(Duration(days: DateTime.now().weekday - DateTime.monday));
  DateTime friday = DateTime.now()
      .add(Duration(days: (DateTime.friday - DateTime.now().weekday)));
  String? placeType;
  List<String> typeOfPlace = ["Private Clinic", "Hospital"];
  String? clientType;
  List<String> typeOfClient = ["New Client", "Existing Client"];
  String? client;
  List<String> clientList = [];
  String? address;
  String? purpose;
  String? contactPoint;
  String? date;
  Map<String, dynamic> weekdayPlans = {};

  void uploadData(String mrName) {
    String weekday = getWeekdayName(DateFormat('dd/MM/yyyy').format(focusDate));

    Visit visit = Visit(
        clientName: client!,
        mrName: mrName,
        clientType: clientType!,
        placeType: placeType!,
        address: address!,
        contactPoint: contactPoint!,
        purpose: purpose!,
        date: DateFormat('dd/MM/yyyy').format(focusDate),
        day: weekday,
        comments: '',
        status: 'Pending');

    weekdayPlans[visit.day] = visit.toMap();

    if (weekday == 'Friday') {
      WeeklyPlanService service = WeeklyPlanService();
      service.uploadWeeklyPlan(weekdayPlans, mrName);
    }
    focusDate = focusDate.add(const Duration(days: 1));
    resetProvider(allReset: false);
    notifyListeners();
  }

  setAddress(String value) {
    address = value;
  }

  setPurpose(String value) {
    purpose = value;
  }

  setContactPoint(String value) {
    contactPoint = value;
  }

  setDate(String value) {
    date = value;
  }

  setClient(String value) {
    client = value;
    notifyListeners();
  }

  getClientName() async {
    WeeklyPlanService service = WeeklyPlanService();
    clientList = await service.getClientNames();
    notifyListeners();
  }

  setClientType(String value) {
    clientType = value;
    getClientName();
    notifyListeners();
  }

  setFocusDate(DateTime value) {
    focusDate = value;
    notifyListeners();
  }

  setPlaceType(String value) {
    placeType = value;
    notifyListeners();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Plase enter Value";
    }
    return null;
  }

  String getWeekdayName(String value) {
    final inputFormat = DateFormat('dd/MM/yyyy');

    DateTime dateTime;
    try {
      dateTime = inputFormat.parse(value);
    } catch (e) {
      return 'Invalid date format';
    }

    final outputFormat = DateFormat('EEEE');

    String weekdayName = outputFormat.format(dateTime);

    return weekdayName;
  }

  void resetProvider({bool allReset = true}) {
    if (allReset) {
      focusDate = DateTime.now();
      weekdayPlans.clear();
    }
    placeType = null;
    clientType = null;
    client = null;

    clientList.clear();
    notifyListeners();
  }
}
