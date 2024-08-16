import 'package:flutter/material.dart';

import '../../../utils.dart';

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
          style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: Utils.isTab ? 24 : 16),
        ),
        Text(
          value,
          style:
              TextStyle(fontSize: Utils.isTab ? 24 : 16, color: Colors.white),
        ),
      ],
    );
  }
}
