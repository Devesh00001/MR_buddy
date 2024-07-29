import 'package:flutter/material.dart';

import '../../welcome/model/user.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Image.network(
              "https://images.squarespace-cdn.com/content/v1/5446f93de4b0a3452dfaf5b0/1626904421257-T6I5V5IQ4GI2SJ8EU82M/Above+Avalon+Neil+Cybart"),
        ),
        Text(
          "Hello, ${user!.name}",
          style: const TextStyle(fontSize: 20),
        )
      ],
    );
  }
}
