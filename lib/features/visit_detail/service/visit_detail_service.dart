import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';

import '../../weekly plan/model/visit.dart';

class VisitDetailService {
  Future<List<String>> getMedicineName() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore.collection('Medicine').get();
      List<String> medicineName =
          querySnapshot.docs.map((doc) => doc['Name'].toString()).toList();
      return medicineName;
    } catch (e) {
      log('Error fetching Medicine names: $e');
      return [];
    }
  }

  Future<bool> updateVisitFromMrDetail(Visit visit) async {
    final firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('WeeklyPlans')
          .where('Name', isEqualTo: visit.mrName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;

        DocumentSnapshot docSnapshot = await documentReference.get();
        Map<String, dynamic> existingData =
            docSnapshot.data() as Map<String, dynamic>;
        Map<String, dynamic> existingPlan = existingData['Plan'] ?? {};

        final date = visit.date;
        final startTime = visit.startTime;

        if (existingPlan.containsKey(date)) {
          Map<String, dynamic> visitsForDate =
              Map<String, dynamic>.from(existingPlan[date]);

          if (visitsForDate.containsKey(startTime)) {
            visitsForDate[startTime] = {
              ...visitsForDate[startTime],
              'Check Out': true,
            };
            existingPlan[date] = visitsForDate;
          } else {
            log('Visit at $startTime on $date not found.');
            return false;
          }
        } else {
          log('Date $date not found in the plan.');
          return false;
        }

        await documentReference.update({
          'Plan': existingPlan,
          'Approval': "Pending",
        });

        log("Visit on $date at $startTime updated successfully.");
        return true;
      } else {
        log("No document found with the Name ${visit.mrName}.");
        return false;
      }
    } catch (e) {
      log('Error in updating visit details: $e');
      return false;
    }
  }

  Future<bool> addPastVisit(PastVisit pastVisit) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Past Visits')
          .where('Name', isEqualTo: pastVisit.clientName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;
        await documentReference.update({
          'Visits.${pastVisit.date}.${pastVisit.time}': pastVisit.toMap(),
        });
        log("Past Visit added to existing document.");
        return true;
      } else {
        await FirebaseFirestore.instance.collection('Past Visits').add({
          'Name': pastVisit.clientName,
          'Visits': {pastVisit.date: pastVisit.toMap()},
        });
        log("New document created with key-value pair.");
        return true;
      }
    } catch (e) {
      log("Error adding or updating document: $e");
      return false;
    }
  }

  Future<PastVisit?> getPastVisitByDateTime(
      String clientName, String date, String time) async {
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

        if (data['Visits'] != null &&
            data['Visits'][date] != null &&
            data['Visits'][date][time] != null) {
          return PastVisit.fromJson(data['Visits'][date][time]);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      log('Error fetching past visit: $e');
      return null;
    }
  }

  Future<bool> addPlanData(Visit visit) async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore
          .collection('WeeklyPlans')
          .where('Name', isEqualTo: visit.mrName)
          .get();

      if (querySnapshot.docs.isEmpty) {
        log('Document with name ${visit.mrName} not found.');
        return false;
      }

      final docId = querySnapshot.docs.first.id;
      final docRef = firestore.collection('WeeklyPlans').doc(docId);

      // Fetch the current plan
      final docSnapshot = await docRef.get();
      final existingData = docSnapshot.data() as Map<String, dynamic>;
      final existingPlan = existingData['Plan'] ?? {};

      final visitMap = visit.toMap();
      final date = visit.date;
      final startTime = visit.startTime;

      if (existingPlan.containsKey(date)) {
        // If the date exists, update or add the visit for the specific start time
        Map<String, dynamic> visitsForDate =
            Map<String, dynamic>.from(existingPlan[date]);

        visitsForDate[startTime] = visitMap;
        existingPlan[date] = visitsForDate;
      } else {
        // If the date does not exist, create a new entry with the visit
        existingPlan[date] = {startTime: visitMap};
      }

      // Update the plan in Firestore
      await docRef.update({
        'Plan': existingPlan,
        'Approval': "Pending",
      });

      log('Plan data added successfully.');
      return true;
    } catch (e) {
      log('Error adding plan data: $e');
      return false;
    }
  }
}
