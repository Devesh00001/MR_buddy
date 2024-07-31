import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_buddy/features/clients/model/clients.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';

class ClientService {
  Future<List<Client>> getClientNames() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore.collection('Clients').get();
      if (querySnapshot.docs.isNotEmpty) {
        final client = querySnapshot.docs.map((doc) => doc).toList();
        List<Client> clientList = [];

        client.forEach((client) {
          clientList.add(Client.fromJson(client.data()));
        });
        return clientList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching clients: $e');
      return [];
    }
  }

  Future<Map<String, PastVisit>> getPastVisit(String clientName) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore
          .collection('Past Visits')
          .where('Name', isEqualTo: clientName)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        final DocumentSnapshot document = querySnapshot.docs[0];
        final Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;
        Map<String, PastVisit> pastVisitList = {};

        data['Visits'].forEach((key, value) {
          pastVisitList[key] = PastVisit.fromJson(value);
        });
        return pastVisitList;
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching past Visits: $e');
      return {};
    }
  }
}
