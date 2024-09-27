import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';
import 'package:mr_buddy/features/visit_detail/service/visit_detail_service.dart';
import 'package:mr_buddy/notifiction_service.dart';

import '../../drugs/model/drug.dart';
import '../../drugs/service/drug_service.dart';
import '../../weekly plan/model/visit.dart';

class VisitDetailProvider with ChangeNotifier {
  String locationMatch = "Match With Client Location";
  String? quantity;
  List<String> medicineName = [];
  String? selectedMedicine;
  String? leadScore;
  List<String> scoreList = [
    '0%',
    '10%',
    '20%',
    '30%',
    '40%',
    '50%',
    '60%',
    '70%',
    '80%',
    '90%',
    '100%'
  ];
  String selectedVisitType = 'Physical visit';
  List<String> visitTypes = [
    'Physical visit',
    'Call Support',
    'Message Support'
  ];
  String? drugsPrescribed;
  String? queriesEncountered;
  String? additionalNotes;
  String? leadSuggestion;
  List<Drug> drugs = [];
  List<Drug> selectedDrugs = [];
  int currentStep = 0;
  final formKey = GlobalKey<FormState>();
  String selctedDateAndTime = 'Select Date and Time';
  String? newVisitPurpose;
  bool isUploaded = true;
  String? managerComment;
  XFile? imagePath;
  bool isImageClick = true;

  void statusChangeOfImageClick(bool value) {
    isImageClick = value;
    notifyListeners();
  }

  bool getImageClickStatus() {
    return isImageClick;
  }

  void setImagePath(XFile value) {
    imagePath = value;
    notifyListeners();
  }

  XFile? getImage() {
    return imagePath;
  }

  void setManagerComment(String value) {
    managerComment = value;
    notifyListeners();
  }

  String? getManagerComment() {
    return managerComment;
  }

  int getCurrectStep() {
    return currentStep;
  }

  setNewVisitPurpose(String value) {
    newVisitPurpose = value;
    notifyListeners();
  }

  getNewVisitPurpose() {
    return newVisitPurpose;
  }

  setSelectDateAndTime(String value) {
    selctedDateAndTime = value;
    notifyListeners();
  }

  getSelectDateAndTime() {
    return selctedDateAndTime;
  }

  increaseStep() {
    currentStep++;
    notifyListeners();
  }

  decreaseStep() {
    currentStep--;
    notifyListeners();
  }

  Future<void> getDrugName() async {
    drugs.clear();
    DrugService service = DrugService();
    drugs = await service.getDrugs();
  }

  void addDrugs(Drug value) {
    selectedDrugs.add(value);
    notifyListeners();
  }

  void removeDrugs(Drug value) {
    selectedDrugs.remove(value);
    notifyListeners();
  }

  // void getSearchList(String query) {
  //   if (query.split('').length >= 2) {
  //     List<Drug> filteredList = drugs
  //         .where(
  //             (item) => item.name.toLowerCase().contains(query.toLowerCase()))
  //         .toList();

  //     displayDrugList = filteredList;
  //     notifyListeners();
  //   } else {
  //     displayDrugList = [...drugs];
  //     notifyListeners();
  //   }
  // }

  resetProvider() {
    selectedVisitType = 'Physical visit';
    quantity = null;
    selectedMedicine = null;
    leadScore = null;
    drugsPrescribed = null;
    queriesEncountered = null;
    additionalNotes = null;
    leadSuggestion = null;
    currentStep = 0;
    selctedDateAndTime = 'Select Date and Time';
    newVisitPurpose = null;
    isUploaded = true;
    medicineName.clear();
    drugs.clear();
    selectedDrugs.clear();
    imagePath = null;
    isImageClick = true;
  }

  Future<PastVisit?> getPastVisitOfVisit(Visit visit) async {
    VisitDetailService service = VisitDetailService();
    Visit? resultVisit = await service.getPastVisitBeforeDate(visit);
    PastVisit? pastVisit = await service.getPastVisitByDateTime(
        resultVisit!.clientName, resultVisit.date, resultVisit.startTime);
    return pastVisit;
  }

  Future<bool> createVisitOfClient(Visit visit) async {
    DateFormat inputFormat = DateFormat('hh:mm a dd:MM:yyyy');

    DateTime dateTime = inputFormat.parse(selctedDateAndTime);

    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    DateFormat timeFormat = DateFormat('hh:mm a');

    String dateValue = dateFormat.format(dateTime);
    String timeValue = timeFormat.format(dateTime);
    Visit newVisit = Visit(
        clientName: visit.clientName,
        mrName: visit.mrName,
        clientType: visit.clientType,
        placeType: visit.placeType,
        address: visit.address,
        contactPoint: visit.contactPoint,
        purpose: newVisitPurpose!,
        date: dateValue,
        day: 'day',
        comments: '',
        status: 'Pending',
        startTime: timeValue,
        checkOut: false);
    VisitDetailService service = VisitDetailService();
    isUploaded = await service.addPlanData(newVisit);
    if (isUploaded) {
      NotificationService notificationService = NotificationService();
      notificationService.addNotificationToUser('Himanshu',
          '${newVisit.mrName} add a visit to ${newVisit.clientName} on date ${newVisit.date}${newVisit.startTime}');
    }
    return isUploaded;
  }

  Future<bool> deleteVisit(Visit visit) async {
    VisitDetailService service = VisitDetailService();
    bool status =
        await service.deleteVisit(visit.mrName, visit.date, visit.startTime);
    if (status) {
      NotificationService notificationService = NotificationService();
      notificationService.addNotificationToUser('Himanshu',
          '${visit.mrName} cancel a visit of ${visit.clientName} on ${visit.date} ${visit.startTime}');
    }
    return status;
  }

  Future<bool> uploadData(Visit visit) async {
    VisitDetailService service = VisitDetailService();
    bool status = await service.updateVisitFromMrDetail(visit);

    String finalLeadScore = leadScore!.substring(0, leadScore!.length - 1);
    if (status) {
      PastVisit pastVisit = PastVisit(
          mrName: visit.mrName,
          clientName: visit.clientName,
          date: visit.date,
          drugsPrescribed:
              selectedDrugs.map((drug) => drug.name).toList().toString(),
          queriesEncountered: queriesEncountered!,
          additionalNotes: additionalNotes!,
          leadScore: finalLeadScore,
          leadSuggestion: leadSuggestion!,
          visitType: selectedVisitType,
          time: visit.startTime,
          imageUrl: '');

      NotificationService notificationService = NotificationService();
      notificationService.addNotificationToUser('Himanshu',
          '${visit.mrName} check out from ${visit.clientName} give lead score $finalLeadScore%');

      return await service.addPastVisit(pastVisit, imagePath!);
    }
    return false;
  }

  Future<PastVisit?> getPastVisit(Visit visit) {
    VisitDetailService service = VisitDetailService();
    return service.getPastVisitByDateTime(
        visit.clientName, visit.date, visit.startTime);
  }

  Future<bool> addManagerComment(
      String mrName, String date, String time, String comment) {
    VisitDetailService service = VisitDetailService();
    return service.addManagerComment(mrName, date, time, comment);
  }

  setLeadSuggestion(String value) {
    leadSuggestion = value;
    notifyListeners();
  }

  String? getLeadSuggestion() {
    return leadSuggestion;
  }

  setAdditionalNotes(String value) {
    additionalNotes = value;
    notifyListeners();
  }

  String? getAdditionalNotes() {
    return additionalNotes;
  }

  setQuerieEncountered(String value) {
    queriesEncountered = value;
    notifyListeners();
  }

  String? getQuerieEncuntered() {
    return queriesEncountered;
  }

  setDrugsPrescribed(String value) {
    drugsPrescribed = value;
    notifyListeners();
  }

  String? getDrugsPrescribed() {
    return drugsPrescribed;
  }

  setVisitType(String value) {
    selectedVisitType = value;
    notifyListeners();
  }

  setLeadScore(String value) {
    // value = value.substring(0, value.length - 1);
    leadScore = value;
    notifyListeners();
  }

  String? getLeadScore() {
    return leadScore;
  }

  List<String> getScoreList() {
    return scoreList;
  }

  setMedicineName(String value) {
    selectedMedicine = value;
    notifyListeners();
  }

  String? getSelectedValue() {
    return selectedMedicine;
  }

  Future<List<String>> getMedicineName() async {
    VisitDetailService service = VisitDetailService();
    medicineName = await service.getMedicineName();
    notifyListeners();
    return medicineName;
  }

  void setQuantity(String value) {
    quantity = value;
    notifyListeners();
  }

  String? getQuantity() {
    return quantity;
  }

  void setLocation(String value) {
    locationMatch = value;
    notifyListeners();
  }

  String getLocation() {
    return locationMatch;
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Plase enter Value";
    }
    return null;
  }
}
