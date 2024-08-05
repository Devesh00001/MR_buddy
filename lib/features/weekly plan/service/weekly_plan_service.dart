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

  Future<bool> uploadWeeklyPlan(
      Map<String, dynamic> mapOfVisits, String mrName) async {
    final firestore = FirebaseFirestore.instance;
    try {
      CollectionReference collection =
          await firestore.collection('WeeklyPlans');
      Map<String, dynamic> data = {
        "Approval": "Pending",
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

  Future<bool> addOrUpdateWeekDayPlan(
      String userName, String weekDay, Map<String, dynamic> plan) async {
    try {
      final collectionRef =
          FirebaseFirestore.instance.collection('WeeklyPlans');

      QuerySnapshot querySnapshot =
          await collectionRef.where('Name', isEqualTo: userName).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;

        try {
          await docRef.update({
            'Plan.$weekDay': plan,
          });
          print('Plan updated successfully.');
          return true;
        } catch (e) {
          print('Failed to update the plan: $e');
          return false;
        }
      } else {
        try {
          await collectionRef.add({
            'Name': userName,
            'Plan': {
              weekDay: plan,
            },
          });
          print('New plan created successfully.');
          return true;
        } catch (e) {
          print('Failed to create a new plan: $e');
          return false;
        }
      }
    } catch (e) {
      print('An error occurred while fetching the document: $e');
      return false;
    }
  }
}
