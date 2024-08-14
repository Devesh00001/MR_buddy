import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VisitStatus extends StatelessWidget {
  const VisitStatus(
      {super.key, required this.visitStatus, required this.visitDate});

  final String visitStatus;
  final String visitDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            child: Icon(
              visitStatus == 'Approve'
                  ? Icons.check_circle_outline_outlined
                  : FontAwesomeIcons.circleExclamation,
              size: 40,
              color: visitStatus == 'Approve' ? Colors.green : Colors.yellow,
            )),
        Container(
            padding: const EdgeInsets.all(4),
            child: Row(
              children: [
                Text(
                  visitStatus == 'Approve' ? "Approve" : "Pending for approvel",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ))
      ],
    );
  }
}
