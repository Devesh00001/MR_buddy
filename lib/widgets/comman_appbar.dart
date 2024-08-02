import 'package:flutter/material.dart';
import 'package:mr_buddy/utils.dart';

import 'notification.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: HexColor("00AE4D"),
      elevation: 5,
      shadowColor: Colors.grey,
      actions: const [Notifications()],
      title: const Text(
        "MR Buddy",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
