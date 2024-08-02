import 'package:cloud_firestore/cloud_firestore.dart';

class MRService {
  Future<bool> isWeeklyPlanStatus(String mrName) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot result = await firestore
          .collection('WeeklyPlans')
          .where('Name', isEqualTo: mrName)
          .get();
      if (result.docs.isNotEmpty) {
        final DocumentSnapshot document = result.docs[0];
        final Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;

        if (data['Approval'] == 'Approve') {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking approval field: $e');
      return false;
    }
  }

  Future<bool> approveWeeklyPlanStatus(String mrName) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('WeeklyPlans')
          .where('Name', isEqualTo: mrName)
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        Map<String, dynamic>? plan = data['Plan'] as Map<String, dynamic>?;

        Map<String, dynamic> headApprovel = {};

        data.forEach((key, value) {
          headApprovel['Approval'] = 'Approve';
        });

        if (plan != null) {
          Map<String, dynamic> updates = {};

          plan.forEach((weekday, visitData) {
            updates['Plan.$weekday.Approval'] = 'Approve';
          });
          await firestore
              .collection('WeeklyPlans')
              .doc(doc.id)
              .update(headApprovel);
          await firestore.collection('WeeklyPlans').doc(doc.id).update(updates);
          print('Approval field updated successfully for matching documents!');
          return true;
        } else {
          print('Plan field is null in document ${doc.id}');
          return false;
        }
      }
      return true;
    } catch (e) {
      print('Error updating approval field: $e');
      return false;
    }
  }
}
