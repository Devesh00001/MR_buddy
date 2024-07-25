import 'package:flutter/material.dart';

import '../service/home_service.dart';

class HomeProvider with ChangeNotifier {
  String placeName = '';
  String address = '';
  String description = '';

  void setPlaceName(String value) {
    placeName = value;
    notifyListeners();
  }

  void setAddress(String value) {
    address = value;
    notifyListeners();
  }

  void setDescription(String value) {
    description = value;
    notifyListeners();
  }

  String? validateInput(String? value) {
    if (value!.isEmpty || value == null) {
      return "Plase enter Value";
    }
    return null;
  }

  uploadData() {
    HomeService service = HomeService();
    Map<String, dynamic> data = {
      "Place name": placeName,
      "Address": address,
      "Description": description
    };

    service.uploadData(data);
  }
}
