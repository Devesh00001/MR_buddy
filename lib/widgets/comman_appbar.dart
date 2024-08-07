import 'package:flutter/material.dart';
import 'package:mr_buddy/features/welcome/screen/welcome_screen.dart';
import 'package:mr_buddy/utils.dart';

import 'notification.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({super.key, required this.showIcons});
  final bool showIcons;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: HexColor("00AE4D"),
      elevation: 5,
      shadowColor: Colors.grey,
      actions: showIcons
          ? [
              const Notifications(),
              InkWell(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const WelcomeScreen()),
                        (Route<dynamic> route) => false);
                  },
                  child: const Icon(Icons.exit_to_app,
                      color: Colors.white, size: 35))
            ]
          : [],
      title: const Text(
        "MR Buddy",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
