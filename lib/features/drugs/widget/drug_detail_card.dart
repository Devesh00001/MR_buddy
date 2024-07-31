import 'package:flutter/material.dart';

class DrugDetailCard extends StatelessWidget {
  const DrugDetailCard({super.key, required this.heading, required this.value});

  final String heading;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(value),
          )
        ],
      ),
    );
  }
}