import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class WeeklyPlanService {
  Future<List<String>> getClientNames() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore.collection('Clients').get();
      final clientNames =
          querySnapshot.docs.map((doc) => doc['Name'] as String).toList();
      return clientNames;
    } catch (e) {
      print('Error fetching client names: $e');
      return [];
    }
  }

  Future<bool> uploadWeeklyPlan(Map<String, dynamic> mapOfVisits,String mrName) async {
    final firestore = FirebaseFirestore.instance;
    try {
      CollectionReference collection =
          await firestore.collection('WeeklyPlans');
      Map<String, dynamic> data = {
        "Approval": "pending",
        "Name": mrName,
        "Plan": mapOfVisits,
      };

      await collection.add(data);
      log("Weekly plan upload succesfully");
      return true;
    } catch (e) {
      return false;
    }
  }
}
