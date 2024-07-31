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
      print('Error fetching Medicine names: $e');
      return [];
    }
  }

  Future<bool> reomveVisitFromMrDetail(Visit visit) async {
    final firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('WeeklyPlans')
          .where('Name', isEqualTo: visit.mrName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference documentReference =
            querySnapshot.docs.first.reference;

        await documentReference.update({
          'Plan.${visit.day}': FieldValue.delete(),
        });

        print("Key ${visit.day} deleted successfully.");
        return true;
      } else {
        print("No document found with the Name ${visit.mrName}.");
        return false;
      }
    } catch (e) {
      print('error in removing visit details: $e');
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
          'Visits.${pastVisit.date}': pastVisit.toMap(),
        });
        print("Past Visit added to existing document.");
        return true;
      } else {
        await FirebaseFirestore.instance.collection('Past Visits').add({
          'Name': pastVisit.clientName,
          'Visits': {pastVisit.date: pastVisit.toMap()},
        });
        print("New document created with key-value pair.");
        return true;
      }
    } catch (e) {
      print("Error adding or updating document: $e");
      return false;
    }
  }
}
