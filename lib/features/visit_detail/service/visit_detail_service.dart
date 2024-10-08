import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
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

  Future<bool> addPastVisit(PastVisit pastVisit, XFile image) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child(
          'past_visits_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final file = File(image.path);

      final uploadTask = imageRef.putFile(file);
      uploadTask.snapshotEvents.listen((taskSnapshot) {
        log('Upload progress: ${taskSnapshot.bytesTransferred / taskSnapshot.totalBytes * 100}%');
      }).onError((error) {
        log('Upload error: $error');
      });

      final snapshot = await uploadTask;

      final imageUrl = await snapshot.ref.getDownloadURL();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Past Visits')
          .where('Name', isEqualTo: pastVisit.clientName)
          .get();
      pastVisit.imageUrl = imageUrl;

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
          'Visits': {
            pastVisit.date: {pastVisit.time: pastVisit.toMap()}
          },
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

      final docSnapshot = await docRef.get();
      final existingData = docSnapshot.data() as Map<String, dynamic>;
      final existingPlan = existingData['Plan'] ?? {};

      final visitMap = visit.toMap();
      final date = visit.date;
      final startTime = visit.startTime;

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

      log('Plan data added successfully.');
      return true;
    } catch (e) {
      log('Error adding plan data: $e');
      return false;
    }
  }

  Future<bool> addManagerComment(
      String username, String date, String time, String comment) async {
    CollectionReference weeklyPlans =
        FirebaseFirestore.instance.collection('WeeklyPlans');

    QuerySnapshot querySnapshot =
        await weeklyPlans.where('Name', isEqualTo: username).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;

      Map<String, dynamic> plan = querySnapshot.docs.first.get('Plan');

      if (plan[date] != null && plan[date][time] != null) {
        plan[date][time]['Manager Comments'] = comment;

        await docRef.update({'Plan': plan});
        log('Manager comment added successfully');
        return true;
      } else {
        log('No visit detail found for the specified date and time');
        return false;
      }
    } else {
      log('No document found for the specified username');
      return false;
    }
  }

  Future<bool> deleteVisit(String username, String date, String time) async {
    CollectionReference weeklyPlans =
        FirebaseFirestore.instance.collection('WeeklyPlans');
    QuerySnapshot querySnapshot =
        await weeklyPlans.where('Name', isEqualTo: username).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      Map<String, dynamic> plan = querySnapshot.docs.first.get('Plan');

      if (plan[date] != null && plan[date][time] != null) {
        plan[date].remove(time);

        if (plan[date].isEmpty) {
          plan.remove(date);
        }

        await docRef.update({'Plan': plan});
        log("cancel the visit for $date $time");
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<Visit?> getPastVisitBeforeDate(Visit visit) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('WeeklyPlans')
          .where('Name', isEqualTo: visit.mrName)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        Map<String, dynamic> docData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        Map<String, dynamic> plans = docData['Plan'] as Map<String, dynamic>;
        List<String> sortedDates = plans.keys.toList()
          ..sort((a, b) => DateFormat('dd-MM-yyyy')
              .parse(b)
              .compareTo(DateFormat('dd-MM-yyyy').parse(a)));
        Map<String, dynamic>? pastVisit;

        for (String visitDate in sortedDates) {
          if (DateFormat('dd-MM-yyyy')
                  .parse(visitDate)
                  .compareTo(DateFormat('dd-MM-yyyy').parse(visit.date)) <
              0) {
            Map<String, dynamic> times =
                plans[visitDate] as Map<String, dynamic>;

            for (String time in times.keys) {
              Map<String, dynamic> visitDetail =
                  times[time] as Map<String, dynamic>;

              // Check if the client name matches and 'check Out' is true
              if (visitDetail['Client'] == visit.clientName &&
                  visitDetail['Check Out'] == true) {
                pastVisit = visitDetail;
                break;
              }
            }

            if (pastVisit != null) {
              break;
            }
          }
        }

        return Visit.fromJson(pastVisit!);
      }
    } catch (e) {
      log("Error getting past visit: $e");
    }

    return null;
  }
}
