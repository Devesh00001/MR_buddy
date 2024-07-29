import 'package:cloud_firestore/cloud_firestore.dart';

import '../../weekly plan/model/visit.dart';

class DashboardService {
  Future<Map<String, Visit>> getWeekVisits(String username) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('WeeklyPlans')
          .where('Name', isEqualTo: username)
          .get();
      Map<String, Visit> mappedData = {};
      if (result.docs.isNotEmpty) {
        final DocumentSnapshot document = result.docs[0];
        final Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;

        data['Plan'].forEach((key, value) {
          mappedData[key] = Visit.fromJson(value);
        });
      }
      return mappedData;
    } catch (e) {
      print('Error checking weekly plans: $e');
    }
    return {};
  }
}
