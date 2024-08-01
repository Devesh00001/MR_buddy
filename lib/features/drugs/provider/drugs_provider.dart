import 'package:flutter/material.dart';
import 'package:mr_buddy/features/drugs/model/drug.dart';

import '../service/drug_service.dart';

class DrugsProvider with ChangeNotifier {
  List<Drug> drugs = [];
  List<Drug> displayDrugList = [];
  bool isLoading = false;

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
}
