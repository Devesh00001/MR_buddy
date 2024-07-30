import 'package:flutter/material.dart';

class VisitStatus extends StatelessWidget {
  const VisitStatus(
      {super.key, required this.visitStatus, required this.visitDate});

  final String visitStatus;
  final String visitDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Text("Status: $visitStatus"),
                const SizedBox(width: 5),
                Icon(
                  visitStatus == 'Approve'
                      ? Icons.done_outline_rounded
                      : Icons.clear_rounded,
                  color: visitStatus == 'Approve' ? Colors.green : Colors.red,
                )
              ],
            )),
        Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Text("Date: $visitDate"),
                const SizedBox(width: 5),
                const Icon(
                  Icons.date_range,
                )
              ],
            ))
      ],
    );
  }
}
