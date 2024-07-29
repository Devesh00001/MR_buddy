import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/features/weekly%20plan/model/visit.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../../welcome/model/user.dart';
import '../../welcome/provider/welcome_provider.dart';
import '../provider/dashboard_provider.dart';
import '../widgets/user_info_tile.dart';
import '../widgets/visitL_line_chart.dart';
import '../widgets/visits_info_card.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    List<FlSpot> linerChartSpots = [
      const FlSpot(1, 5),
      const FlSpot(2, 20),
      const FlSpot(3, 5),
      const FlSpot(4, 15),
      const FlSpot(5, 6),
      const FlSpot(6, 18),
    ];
    User? user = Provider.of<WelcomeProvider>(context).user;
    return Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
      return Column(
        children: [
          UserInfoTile(user: user),
          const VisitsInfoCard(),
          const SizedBox(height: 20),
          VisitLineChart(
            linerChartSpots: linerChartSpots,
            maxYValue: 20,
            intervel: 5,
          ),
          Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Your Today's Visit",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                      height: Utils.deviceHeight * 0.21,
                      child: FutureBuilder<Map<String, Visit>>(
                          future: dashboardProvider.getWeeklyPlan(user!.name),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('No Visits found'));
                            } else {
                              return ListView(
                                children: dashboardProvider.weeklyPlan.entries
                                    .map((entry) {
                                  String day = entry.key;
                                  Visit visit = entry.value;

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(colors: [
                                          HexColor("00AE4D"),
                                          HexColor("00AE4D").withOpacity(0.5)
                                        ])),
                                    child: ListTile(
                                      title: Text(
                                        day,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        visit.address,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                          }))
                ],
              ))
        ],
      );
    });
  }
}
