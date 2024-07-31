import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_buddy/features/drugs/model/drug.dart';

class DrugService {
  Future<List<Drug>> getDrugs() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore.collection('Medicine').get();
      if (querySnapshot.docs.isNotEmpty) {
        final drugs = querySnapshot.docs.map((doc) => doc).toList();
        List<Drug> drugsList = [];

        drugs.forEach((drug) {
          drugsList.add(Drug.fromJson(drug.data()));
        });
        return drugsList;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching Drugs: $e');
      return [];
    }
  }
}
