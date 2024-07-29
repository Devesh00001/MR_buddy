import 'package:flutter/material.dart';
import 'package:mr_buddy/features/welcome/service/welcome_service.dart';

import '../model/user.dart';

class WelcomeProvider with ChangeNotifier {
  String selectedRole = "MR";
  List<String> roles = ["MR", "Manager"];
  String? userName;
  bool status = false;
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  submitUserDetails() async {
    WelcomeService service = WelcomeService();
    if (await service.isUsernamePresent(userName!) != null) {
      setUser(await service.isUsernamePresent(userName!));
      status = true;
    } else {
      setUser(await service.uploadUserDeatils(userName!, selectedRole));
      status = true;
    }
  }
}
