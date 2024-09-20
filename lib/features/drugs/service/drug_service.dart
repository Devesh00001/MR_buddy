import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/features/drugs/model/drug.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
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
      log('Error fetching Drugs: $e');
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

        log('Field value incremented successfully!');
      } else {
        log('No medicine found with the name: $medicineName');
      }
    } catch (e) {
      log('Error incrementing field: $e');
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
          log('No logs found for MR: $mrName');
        }
      } else {
        log('No medicine found with the name: $medicineName');
      }
    } catch (e) {
      log('Error fetching logs: $e');
    }

    return logsList;
  }

  Future<String?> downloadPdf(String medicineName) async {
    try {
      CollectionReference medicineCollection =
          FirebaseFirestore.instance.collection('Medicine');

      QuerySnapshot querySnapshot =
          await medicineCollection.where('Name', isEqualTo: medicineName).get();

      if (querySnapshot.docs.isEmpty) {
        log('No document found for the given medicine name');
        return null;
      }

      DocumentSnapshot medicineDoc = querySnapshot.docs.first;

      String pdfUrl = medicineDoc['pdf'];

      if (pdfUrl.isEmpty) {
        log('PDF URL is not available');
        return null;
      }

      final response = await http.get(Uri.parse(pdfUrl));

      if (response.statusCode == 200) {
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String filePath = '${appDocDir.path}/$medicineName.pdf';

        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        log('PDF downloaded successfully to $filePath');
        return filePath;
      } else {
        log('Failed to download PDF');
      }
    } catch (e) {
      log('Error downloading PDF: $e');
    }
    return null;
  }
}
