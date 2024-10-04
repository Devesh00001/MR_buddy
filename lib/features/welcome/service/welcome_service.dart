import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';

import '../../home/screen/home_screen.dart';

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
    return User(name: "", role: "",password: '', mrNames: []);
  }

Future<User?> authenticateUser(BuildContext context, String username, String password) async {
  try {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Users')
        .where('Name', isEqualTo: username)
        .get();
        
    if (result.docs.isNotEmpty) {
      final DocumentSnapshot document = result.docs[0];
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      
      if (data['Password'] == password) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!'), backgroundColor: Colors.green),
          
        );
            Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => const Home()));
        
        return User.fromJson(data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username or password is incorrect.'), backgroundColor: Colors.red),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username or password is incorrect.'), backgroundColor: Colors.red),
      );
    }
  } catch (e) {
    print('Error checking username: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred. Please try again.'), backgroundColor: Colors.red),
    );
  }
  
  return null;
}

  Future<User?> uploadUserDeatils(String name, String role) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("Users");
      User user = User(name: name, role: role,password: 'password', mrNames: []);

      await collection.add(user.modelTojson());

      print('Data uploaded successfully');
      return user;
    } catch (e) {
      print('Failed to upload data: $e');
    }
    return null;
  }
}
