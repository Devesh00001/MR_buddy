import 'package:flutter/material.dart';
import 'package:mr_buddy/features/welcome/service/welcome_service.dart';

import '../model/user.dart';

class WelcomeProvider with ChangeNotifier {
  String selectedRole = "MR";
  List<String> roles = ["MR", "Manager"];
  bool isLoading = false;
  String? userName;
  String? password;
  bool status = false;
  User? _user;
  

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }


  void setRole(String value) {
    selectedRole = value;
    notifyListeners();
  }

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return "Plase enter Value";
    }
    return null;
  }

  setUserName(String value) {
    userName = value;
  }

  void setPassword(String value){
    password = value;
  }

  void setIsloading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool getIsloading(){
    return isLoading;
  }

  submitUserDetails(BuildContext context) async {
    setIsloading(true);
    WelcomeService service = WelcomeService();
    setUser(await service.authenticateUser(context,userName!,password!));
    status = true;
    setIsloading(false);
  }
}
