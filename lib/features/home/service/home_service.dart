import 'package:cloud_firestore/cloud_firestore.dart';

class HomeService {
  Future<void> uploadData(Map<String, dynamic> data) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection("MR Visits");

      // Add a new document with the data
      await collection.add(data);

      print('Data uploaded successfully');
    } catch (e) {
      print('Failed to upload data: $e');
    }
  }
}
