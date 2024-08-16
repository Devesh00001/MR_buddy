import 'package:flutter/material.dart';
import 'package:mr_buddy/features/welcome/provider/welcome_provider.dart';
import 'package:provider/provider.dart';

import '../../welcome/model/user.dart';
import '../provider/dashboard_provider.dart';
import '../widgets/calendar.dart';
import '../widgets/mr_list.dart';
import '../widgets/visit_list.dart';
import '../widgets/visits_info_card.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<WelcomeProvider>(context).user;
    return Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
      return Column(
          mainAxisAlignment: user!.role == "MR"
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.start,
          children: _getWidgetsForRole(user));
    });
  }
}

List<Widget> _getWidgetsForRole(User user) {
  switch (user.role) {
    case 'Manager':
      return [
        const SizedBox(height: 20),
        const VisitsInfoCard(),
        MRList(user: user)
      ];
    case 'MR':
      return [const VisitsInfoCard(), const Calendar(), VisitList(user: user)];

    default:
      return [];
  }
}
