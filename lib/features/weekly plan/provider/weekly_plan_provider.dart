import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/features/clients/model/clients.dart';
import 'package:mr_buddy/features/clients/service/client_service.dart';
import 'package:mr_buddy/features/weekly%20plan/service/weekly_plan_service.dart';
import 'package:mr_buddy/notifiction_service.dart';

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
  List<String> typeOfClient = [
    "New Health Associate",
    "Existing Health Associate"
  ];
  String? client;
  String? clientName;
  List<String> clientList = [];
  String? address;
  String? purpose;
  String? contactPoint;
  String? date;
  Map<String, dynamic> weekdayPlans = {};
  String? mrName;
  Map<String, dynamic> dayVisits = {};
  String time = '12:00 PM';
  String? specialization;

  void setSpecialization(String value) {
    specialization = value;
  }

  void setTime(String value) {
    time = value;
    notifyListeners();
  }

  String? getTime() {
    return time;
  }

  void uploadData(String mrName, {bool uploaded = false}) {
    String weekday = getWeekdayName(DateFormat('dd-MM-yyyy').format(focusDate));
    addDataInSingleDayVisit(mrName);

    weekdayPlans[DateFormat('dd-MM-yyyy').format(focusDate)] =
        Map.from(dayVisits);

    if (clientType == 'New Health Associate') {
      ClientService clientService = ClientService();
      Map<String, dynamic> clientMap = {
        'Name': clientName,
        'Address': address,
        'Hospital': '',
        'Specialization': specialization
      };
      Client client = Client.fromJson(clientMap);
      clientService.addClient(client);
    }

    if (weekday == 'Friday' || uploaded == true) {
      WeeklyPlanService service = WeeklyPlanService();
      service.uploadWeeklyPlan(weekdayPlans, mrName);
      NotificationService notificationService = NotificationService();
      notificationService.addNotificationToUser(
          'Himanshu', '$mrName add a weekly plan for your approval');
    }
    focusDate = focusDate.add(const Duration(days: 1));
    resetProvider(allReset: false);
    dayVisits.clear();
    notifyListeners();
  }

  String getRandomTime() {
    Random random = Random();
    int hour = random.nextInt(12) + 1;
    int minute = random.nextInt(60);

    String period = random.nextBool() ? "AM" : "PM";

    String formattedMinute = minute.toString().padLeft(2, '0');
    String formattedTime = "$hour:$formattedMinute $period";

    return formattedTime;
  }

  addDataInSingleDayVisit(String mrName, {bool reset = false}) {
    String weekday = getWeekdayName(DateFormat('dd-MM-yyyy').format(focusDate));
    // String time = getRandomTime();

    Visit visit = Visit(
        clientName: client ?? clientName!,
        mrName: mrName,
        clientType: clientType!,
        placeType: placeType!,
        address: address!,
        contactPoint: contactPoint!,
        purpose: purpose!,
        date: DateFormat('dd-MM-yyyy').format(focusDate),
        day: weekday,
        comments: ' ',
        status: 'Pending',
        startTime: time,
        checkOut: false);
    dayVisits[time] = Map.from(visit.toMap());
    if (reset) {
      resetProvider(allReset: false);
    }
  }

  Future<bool> uploadWeekDayPlan() async {
    String weekday = getWeekdayName(DateFormat('dd-MM-yyyy').format(focusDate));

    Visit visit = Visit(
        clientName: client ?? clientName!,
        mrName: mrName!,
        clientType: clientType!,
        placeType: placeType!,
        address: address!,
        contactPoint: contactPoint!,
        purpose: purpose!,
        date: DateFormat('dd-MM-yyyy').format(focusDate),
        day: weekday,
        comments: ' ',
        status: 'Pending',
        startTime: time,
        checkOut: false);
    if (clientType == 'New Health Associate') {
      ClientService clientService = ClientService();
      Map<String, dynamic> clientMap = {
        'Name': clientName,
        'Address': address,
        'Hospital': '',
        'Specialization': specialization
      };
      Client client = Client.fromJson(clientMap);
      clientService.addClient(client);
    }
    WeeklyPlanService service = WeeklyPlanService();
    bool status = await service.addOrUpdateWeekDayPlan(visit);
    if (status) {
      NotificationService notificationService = NotificationService();
      notificationService.addNotificationToUser(visit.mrName,
          "Add a Visit for ${visit.clientName} at ${visit.date} ${visit.startTime}");
    }

    resetProvider(allReset: false);
    notifyListeners();
    return status;
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

  setMRName(String value) {
    mrName = value;
  }

  setClientName(String value) {
    clientName = value;
  }

  setClient(String value) {
    client = value;
  }

  getClientName() async {
    WeeklyPlanService service = WeeklyPlanService();
    clientList = await service.getClientNames();
    notifyListeners();
  }

  setClientType(String value) {
    clientType = value;
    getClientName();
  }

  setFocusDate(DateTime value) {
    focusDate = value;
    notifyListeners();
  }

  getFocusDate() {
    return focusDate;
  }

  setPlaceType(String value) {
    placeType = value;
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Plase enter Value";
    }
    return null;
  }

  String getWeekdayName(String value) {
    final inputFormat = DateFormat('dd-MM-yyyy');

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
      dayVisits.clear();
    }
    placeType = null;
    clientType = null;
    client = null;
    clientList.clear();
    time = '12:00 PM';
    notifyListeners();
  }
}
