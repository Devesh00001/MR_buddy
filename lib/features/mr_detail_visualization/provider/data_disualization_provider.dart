import 'package:flutter/widgets.dart';

class DataVisualizationProvider with ChangeNotifier {
  String? region;
  String? period;
  List<String> regionList = [
    'Noida Sector 62',
    'Delhi Saket',
    'Gurugram cyber hub'
  ];
  List<String> periodList = ['Last 1 week', 'Last 1 month', 'Last 6 month'];
  String? mrName;
  Map<String, Map<String, int>> dataMap = {
    'Devesh': {'Total Visit': 20, 'Checkin': 15, 'New Clients': 5},
    'Rohit': {'Total Visit': 40, 'Checkin': 37, 'New Clients': 3},
    'Aditya': {'Total Visit': 37, 'Checkin': 32, 'New Clients': 5},
    'Eve': {'Total Visit': 10, 'Checkin': 20, 'New Clients': 30},
    'Charlie': {'Total Visit': 10, 'Checkin': 20, 'New Clients': 30}
  };

  Map<String, Map<String, int>> getMrData() {
    return dataMap;
  }

  String? getMrName() {
    return mrName;
  }

  setMrName(String value) {
    mrName = value;
    notifyListeners();
  }

  String getRegion() {
    return region!;
  }

  setRegion(value) {
    region = value;
    notifyListeners();
  }

  String getPreiod() {
    return period!;
  }

  setPreiod(value) {
    period = value;
    notifyListeners();
  }

  List<String> getRegionList() {
    return regionList;
  }

  setRegionList(value) {
    regionList.clear();
    regionList = value;
    notifyListeners();
  }

  List<String> getPreiodList() {
    return periodList;
  }

  setPreiodList(value) {
    periodList.clear();
    periodList = value;
    notifyListeners();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Plase enter Value";
    }
    return null;
  }
}
