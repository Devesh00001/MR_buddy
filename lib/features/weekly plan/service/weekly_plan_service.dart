import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/visit.dart';

class WeeklyPlanService {
  Future<List<String>> getClientNames() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore.collection('Clients').get();
      final clientNames =
          querySnapshot.docs.map((doc) => doc['Name'] as String).toList();
      return clientNames;
    } catch (e) {
      log('Error fetching client names: $e');
      return [];
    }
  }

  Future<bool> uploadWeeklyPlan(
      Map<String, dynamic> mapOfVisits, String mrName) async {
    final firestore = FirebaseFirestore.instance;
    try {
      CollectionReference collection = firestore.collection('WeeklyPlans');
      QuerySnapshot querySnapshot =
          await collection.where('Name', isEqualTo: mrName).get();
      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot existingDoc = querySnapshot.docs.first;
        Map<String, dynamic> existingData =
            existingDoc.data() as Map<String, dynamic>;
        Map<String, dynamic> existingPlan = existingData['Plan'] ?? {};

        mapOfVisits.forEach((date, newVisitMap) {
          if (existingPlan.containsKey(date)) {
            // If the date already exists, get the existing visits for that date
            Map<String, dynamic> existingVisitsForDate =
                Map<String, dynamic>.from(existingPlan[date]);
            // Merge the new visits with the existing visits
            newVisitMap.forEach((time, newVisit) {
              existingVisitsForDate[time] = newVisit;
            });
            existingPlan[date] = existingVisitsForDate;
          } else {
            // If the date does not exist, simply add the new visits
            existingPlan[date] = newVisitMap;
          }
        });

        await collection.doc(existingDoc.id).update({
          "Plan": existingPlan,
          "Approval": "Pending",
        });

        log("Weekly plan updated successfully");
      } else {
        Map<String, dynamic> data = {
          "Approval": "Pending",
          "Name": mrName,
          "Plan": mapOfVisits,
        };

        await collection.add(data);
        log("Weekly plan created successfully");
      }

      return true;
    } catch (e) {
      log("error:$e");
      return false;
    }
  }

  Future<bool> addOrUpdateWeekDayPlan(Visit visit) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final collectionRef = firestore.collection('WeeklyPlans');

      QuerySnapshot querySnapshot =
          await collectionRef.where('Name', isEqualTo: visit.mrName).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        DocumentSnapshot docSnapshot = await docRef.get();
        Map<String, dynamic> existingData =
            docSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> existingPlan = existingData['Plan'] ?? {};

        final date = visit.date;
        final startTime = visit.startTime;
        final visitMap = visit.toMap();

        if (existingPlan.containsKey(date)) {
          Map<String, dynamic> visitsForDate =
              Map<String, dynamic>.from(existingPlan[date]);

          visitsForDate[startTime] = visitMap;
          existingPlan[date] = visitsForDate;
        } else {
          existingPlan[date] = {startTime: visitMap};
        }

        await docRef.update({
          'Plan': existingPlan,
          'Approval': "Pending",
        });

        log('Plan updated successfully.');
        return true;
      } else {
        try {
          await collectionRef.add({
            'Name': visit.mrName,
            'Plan': {
              visit.date: {visit.startTime: visit.toMap()},
            },
          });
          log('New plan created successfully.');
          return true;
        } catch (e) {
          log('Failed to create a new plan: $e');
          return false;
        }
      }
    } catch (e) {
      log('An error occurred: $e');
      return false;
    }
  }
}
