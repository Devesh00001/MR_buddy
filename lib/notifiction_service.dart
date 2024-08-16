import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationService {
  Future<void> addNotificationToUser(
      String username, String notification) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');
      QuerySnapshot querySnapshot =
          await usersCollection.where('Name', isEqualTo: username).get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;

        await usersCollection.doc(userId).update({
          'notification': FieldValue.arrayUnion([notification]),
        });

        log('Notification added successfully for $username');
      } else {
        log('No user found with the name $username');
      }
    } catch (e) {
      log('Failed to add notification: $e');
    }
  }

  Future<List<String>?> getNotificationsForUser(String username) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');
      QuerySnapshot querySnapshot =
          await usersCollection.where('Name', isEqualTo: username).get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;
        DocumentSnapshot userDoc = await usersCollection.doc(userId).get();

        List<String>? notifications =
            List<String>.from(userDoc.get('notification'));
        return notifications;
      } else {
        log('No user found with the name $username');
        return null;
      }
    } catch (e) {
      log('Failed to get notifications: $e');
      return null;
    }
  }

  Future<void> deleteNotificationForUser(
      String username, String notification) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');
      QuerySnapshot querySnapshot =
          await usersCollection.where('Name', isEqualTo: username).get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs.first.id;

        await usersCollection.doc(userId).update({
          'notification': FieldValue.arrayRemove([notification]),
        });

        log('Notification removed successfully for $username');
      } else {
        log('No user found with the name $username');
      }
    } catch (e) {
      log('Failed to remove notification: $e');
    }
  }
}
