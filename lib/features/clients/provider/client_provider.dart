import 'package:flutter/material.dart';
import 'package:mr_buddy/features/clients/model/clients.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';

import '../service/client_service.dart';

class ClinetProvider with ChangeNotifier {
  List<Client> clients = [];
  List<Client> displayClientList = [];
 Map<String, PastVisit> pastVisit = {};

  getClientName() async {
    ClientService service = ClientService();
    clients = await service.getClientNames();
    displayClientList = [...clients];
    notifyListeners();
  }

  void filterItems(String query) {
    if (query.split('').length >= 2) {
      List<Client> filteredList = clients
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      displayClientList = filteredList;
      notifyListeners();
    } else {
      displayClientList = [...clients];
      notifyListeners();
    }
  }

  Future<Map<String, PastVisit>> getPastVisits(String clientName) async {
    ClientService service = ClientService();
    pastVisit = await service.getPastVisit(clientName);
    return pastVisit;
  }
}
