import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mr_buddy/features/drugs/model/drug.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

import '../screen/pdf_screen.dart';
import '../service/drug_service.dart';

class DrugsProvider with ChangeNotifier {
  List<Drug> drugs = [];
  List<Drug> displayDrugList = [];
  bool isLoading = false;
  bool dosageInfoFlag = true;
  bool safetyDataFlag = true;
  bool efficacyDataFlag = true;
  bool promotionalDetailFlag = true;
  String? mrName;
  bool isPdfLoading = false;

  changeStatusDosageInfoFlag() {
    dosageInfoFlag = !dosageInfoFlag;
    notifyListeners();
  }

  getdosageInfoFlag() {
    return dosageInfoFlag;
  }

  changeStatusSafetyDataFlag() {
    safetyDataFlag = !safetyDataFlag;
    notifyListeners();
  }

  getSafetyDataFlag() {
    return safetyDataFlag;
  }

  changeStatusEfficacyDataFlag() {
    efficacyDataFlag = !efficacyDataFlag;
    notifyListeners();
  }

  getEfficacyDataFlag() {
    return efficacyDataFlag;
  }

  changeStatusPromotionalDetailFlag() {
    promotionalDetailFlag = !promotionalDetailFlag;
    notifyListeners();
  }

  getPromotionalDetailFlag() {
    return promotionalDetailFlag;
  }

  getMrName() {
    return mrName;
  }

  setMRName(String value) {
    mrName = value;
    notifyListeners();
  }

  resetMRName() {
    mrName = null;
  }

  changeStatusOfPdfButton(bool value) {
    isPdfLoading = value;
    notifyListeners();
  }

  getPdfButtonStatus() {
    return isPdfLoading;
  }

  resetProvider() {
    promotionalDetailFlag = true;
    efficacyDataFlag = true;
    safetyDataFlag = true;
    dosageInfoFlag = true;
    notifyListeners();
  }

  Future<List<Drug>> getDrugName() async {
    setIsLoadingState(true);
    drugs.clear();
    DrugService service = DrugService();
    drugs = await service.getDrugs();
    displayDrugList = [...drugs];
    setIsLoadingState(false);
    return displayDrugList;
  }

  setIsLoadingState(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void getSearchList(String query) {
    if (query.split('').length >= 2) {
      List<Drug> filteredList = drugs
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      displayDrugList = filteredList;
      notifyListeners();
    } else {
      displayDrugList = [...drugs];
      notifyListeners();
    }
  }

  void updateLog(String medicineName, String fieldName, String mrName) async {
    DrugService service = DrugService();
    await service.incrementMedicineLog(medicineName, fieldName, mrName);
  }

  Future<List<StepperItemData>> getLogs(String medicineName) async {
    DrugService service = DrugService();
    final logList = await service.getMedicineLogs(medicineName, mrName ?? '');
    List<StepperItemData> stepperList = [];
    logList.forEach(
      (element) {
        stepperList.add(StepperItemData(content: element));
      },
    );
    return stepperList;
  }

  openPDf(String medicineName, BuildContext context) async {
    changeStatusOfPdfButton(true);
    DrugService service = DrugService();
    String filePath = await service.downloadPdf(medicineName) ?? '';
    changeStatusOfPdfButton(false);
    log(filePath);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PDFScreen(
              filePath: filePath,
            )));
  }
}
