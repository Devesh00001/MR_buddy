import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/features/drugs/model/drug.dart';

import '../model/logs.dart';

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

  Future<void> incrementMedicineLog(
      String medicineName, String fieldName, String mrName) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Medicine')
          .where('Name', isEqualTo: medicineName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot medicineDoc = querySnapshot.docs.first;

        String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

        String logPath = 'logs.$mrName.$currentDate';

        await firestore.collection('Medicine').doc(medicineDoc.id).update({
          '$logPath.$fieldName': FieldValue.increment(1),
        });

        print('Field value incremented successfully!');
      } else {
        print('No medicine found with the name: $medicineName');
      }
    } catch (e) {
      print('Error incrementing field: $e');
    }
  }

  Future<List<Logs>> getMedicineLogs(String medicineName, String mrName) async {
    List<Logs> logsList = [];

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Medicine')
          .where('Name', isEqualTo: medicineName)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot medicineDoc = querySnapshot.docs.first;

        Map<String, dynamic>? logsData = medicineDoc.get('logs.$mrName');
        if (logsData != null) {
          logsData.forEach((date, data) {
            if (data is Map<String, dynamic>) {
              Logs log = Logs.fromMap(date, data);
              logsList.add(log);
            }
          });
        } else {
          print('No logs found for MR: $mrName');
        }
      } else {
        print('No medicine found with the name: $medicineName');
      }
    } catch (e) {
      print('Error fetching logs: $e');
    }

    return logsList;
  }
}
