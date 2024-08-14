import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetailHeading(user: user),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UserDetailFiled(
                  icon: FontAwesomeIcons.user,
                  title: 'Name',
                  value: user.name,
                ),
                const UserDetailFiled(
                  icon: Icons.location_on_rounded,
                  title: 'Location',
                  value: 'Noida sector 62',
                ),
              ],
            ),
            const SizedBox(height: 10),
            const UserDetailFiled(
              icon: FontAwesomeIcons.userTie,
              title: 'Clients',
              value: 'Dr. Reddy, Dr. Trehan',
            ),
          ],
        ),
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
      this.fontSize = 14,
      required this.icon});
  final String title;
  final String value;
  final double fontSize;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: HexColor("2F52AC"),
          ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$title: ",
                style: TextStyle(fontSize: fontSize),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: fontSize,
                  color: HexColor("1F1F1F").withOpacity(0.5),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
