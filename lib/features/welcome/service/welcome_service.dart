import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';

class WelcomeService {
  Future<User> isUsernamePresent(String username) async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('Users')
          .where('Name', isEqualTo: username)
          .get();
      if (result.docs.isNotEmpty) {
        final DocumentSnapshot document = result.docs[0];
        final Map<String, dynamic> data =
            document.data() as Map<String, dynamic>;
        print("found user");
        return User.fromJson(data);
      }
    } catch (e) {
      print('Error checking username: $e');
    }
    return User(name: "", role: "", mrNames: []);
  }

  Future<User?> uploadUserDeatils(String name, String role) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("Users");
      User user = User(name: name, role: role, mrNames: []);

      await collection.add(user.modelTojson());

      print('Data uploaded successfully');
      return user;
    } catch (e) {
      print('Failed to upload data: $e');
    }
    return null;
  }
}
