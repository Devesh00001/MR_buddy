import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_buddy/features/clients/model/clients.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';

class ClientService {
  Future<List<Client>> getClientNames() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore.collection('Clients').get();
      if (querySnapshot.docs.isNotEmpty) {
        final clients = querySnapshot.docs.map((doc) => doc).toList();
        List<Client> clientList = [];

        clients.forEach((client) {
          clientList.add(Client.fromJson(client.data()));
        });
        return clientList;
      } else {
        return [];
      }
    } catch (e) {
      log('Error fetching clients: $e');
      return [];
    }
  }

  Future<Map<String, Map<String, PastVisit>>> getPastVisit(
      String clientName) async {
    final firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Past Visits')
          .where('Name', isEqualTo: clientName)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot document = querySnapshot.docs[0];
        final Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;
        Map<String, Map<String, PastVisit>> pastVisitList = {};

        data['Visits'].forEach((date, timeMap) {
          if (timeMap is Map<String, dynamic>) {
            pastVisitList[date] = {};
            timeMap.forEach((time, visitData) {
              pastVisitList[date]![time] = PastVisit.fromJson(visitData);
            });
          }
        });
        return pastVisitList;
      } else {
        return {};
      }
    } catch (e) {
      log('Error fetching past Visits: $e');
      return {};
    }
  }

  Future<void> addClient(Client client) async {
    CollectionReference clientsCollection =
        FirebaseFirestore.instance.collection('Clients');

    try {
      await clientsCollection.add(client.toMap());
      log('Client added successfully!');
    } catch (e) {
      log('Failed to add client: $e');
    }
  }
}
