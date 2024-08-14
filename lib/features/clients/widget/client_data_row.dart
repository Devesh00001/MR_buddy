import 'package:flutter/material.dart';

class CilentDataRow extends StatelessWidget {
  const CilentDataRow({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title: ",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ],
    );
  }
}
