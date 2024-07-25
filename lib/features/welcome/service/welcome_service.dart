import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';

class WelcomeService {
  Future<User?> isUsernamePresent(String username) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('User')
          .where('Name', isEqualTo: username)
          .get();

      final DocumentSnapshot document = result.docs[0];
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      User? user;
      user!.fromJson(data);

      return user;
    } catch (e) {
      print('Error checking username: $e');
    }
    return null;
  }

  Future<User?> uploadUserDeatils(String name, String role) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("User");
      User user = User(name: name, role: role);

      await collection.add(user.modelTojson());

      print('Data uploaded successfully');
      return user;
    } catch (e) {
      print('Failed to upload data: $e');

    }
    return null;
  }
}
