import 'package:flutter/material.dart';

import '../../../utils.dart';

class HrmsScreen extends StatelessWidget {
  const HrmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "Coming Soon",
        style:
            TextStyle(fontSize: 20 * Utils.fontSizeModifer, color: Colors.grey),
      ),
    );
  }
}
