import 'package:flutter/material.dart';

import '../../../utils.dart';
import '../../welcome/model/user.dart';
import '../screen/mr_info.dart';

class UserInfoCard extends StatelessWidget {
  const UserInfoCard({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 50,
                offset: const Offset(10, 10))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserDetailHeading(user: user),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UserDetailFiled(
                title: 'Name',
                value: user.name,
              ),
              const UserDetailFiled(
                title: 'Location',
                value: 'Noida sector 62',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const UserDetailFiled(
            title: 'Clients',
            value: 'Dr. Reddy, Dr. Trehan',
          ),
        ],
      ),
    );
  }
}

class UserDetailHeading extends StatelessWidget {
  const UserDetailHeading({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "MR Info",
          style: TextStyle(fontSize: 20),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MRInfo(user: user)));
          },
          child: const Text(
            "More Info",
            style:
                TextStyle(fontSize: 20, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}

class UserDetailFiled extends StatelessWidget {
  const UserDetailFiled(
      {super.key,
      required this.title,
      required this.value,
      this.fontSize = 14});
  final String title;
  final String value;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          "$title: ",
          style: TextStyle(
              color: HexColor("1F1F1F").withOpacity(0.5), fontSize: fontSize),
        ),
        Text(
          value,
          style: TextStyle(fontSize: fontSize),
        )
      ],
    );
  }
}
