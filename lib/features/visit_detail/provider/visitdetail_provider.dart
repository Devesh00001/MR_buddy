import 'package:flutter/material.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';
import 'package:mr_buddy/features/visit_detail/service/visit_detail_service.dart';

import '../../weekly plan/model/visit.dart';

class VisitDetailProvider with ChangeNotifier {
  String locationMatch = "Match With Client Location";
  String? quantity;
  List<String> medicineName = [];
  String? selectedMedicine;
  String? leadScore;
  List<String> scoreList = ['20', '25', '30', '35', '40', '45', '50'];
  String? physicalVisit;
  String? callSupport;
  String? messageSupport;
  String? drugsPrescribed;
  String? queriesEncountered;
  String? additionalNotes;
  String? leadSuggestion;

  resetProvider() {
    quantity = null;
    selectedMedicine = null;
    leadScore = null;
    physicalVisit = null;
    callSupport = null;
    messageSupport = null;
    drugsPrescribed = null;
    queriesEncountered = null;
    additionalNotes = null;
    leadSuggestion = null;
    medicineName.clear();
  }

  Future<bool> uploadData(Visit visit) async {
    VisitDetailService service = VisitDetailService();
    bool status = await service.reomveVisitFromMrDetail(visit);
    if (status) {
      PastVisit pastVisit = PastVisit(
          mrName: visit.mrName,
          clientName: visit.clientName,
          date: visit.date,
          drugsPrescribed: drugsPrescribed!,
          queriesEncountered: queriesEncountered!,
          additionalNotes: additionalNotes!,
          leadScore: leadScore!,
          leadSuggestion: leadSuggestion!,
          physicalVisit: physicalVisit ?? "",
          callSupport: callSupport ?? "",
          messageSupport: messageSupport ?? "");

      return await service.addPastVisit(pastVisit);
    }
    return false;
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

  setMessageSupport(String value) {
    messageSupport = value;
    notifyListeners();
  }

  String? getMessageSupport() {
    return messageSupport;
  }

  setCallSupport(String value) {
    callSupport = value;
    notifyListeners();
  }

  String? getCallSupport() {
    return callSupport;
  }

  setPhysicalVisit(String value) {
    physicalVisit = value;
    notifyListeners();
  }

  String? getPhysicalVisit() {
    return physicalVisit;
  }

  setLeadScore(String value) {
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
