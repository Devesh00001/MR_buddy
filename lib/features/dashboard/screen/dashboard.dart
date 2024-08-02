import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_buddy/features/weekly%20plan/model/visit.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../../mr/screen/mr_week_detail.dart';
import '../../visit_detail/screen/check_in_screen.dart';
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
      return SingleChildScrollView(
        child: Column(
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user!.role == 'Manager'
                            ? "Your MR"
                            : "Your Today's Visit",
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                        height: Utils.deviceHeight * 0.3,
                        child: FutureBuilder<Map<String, dynamic>>(
                            future: user.role == 'MR'
                                ? dashboardProvider.getWeeklyPlan(user.name)
                                : dashboardProvider
                                    .getAllMRDetail(user.mrNames),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: Lottie.asset(
                                        "assets/lottie/loading.json",
                                        height: 100));
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No Visits found'));
                              } else {
                                if (user.role == 'MR') {
                                  Map<String, Visit> data =
                                      snapshot.data as Map<String, Visit>;
                                  return ListView(
                                    children: data.entries.map((entry) {
                                      String day = entry.key;
                                      Visit visit = entry.value;

                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CheckInScreen(
                                                          visit: visit)));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(colors: [
                                                HexColor("00AE4D"),
                                                HexColor("00AE4D")
                                                    .withOpacity(0.5)
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
                                        ),
                                      );
                                    }).toList(),
                                  );
                                } else {
                                  Map<String, User> data =
                                      snapshot.data as Map<String, User>;
                                  return ListView(
                                    children: data.entries.map((entry) {
                                      String name = entry.key;
                                      User user0 = entry.value;

                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MRWeekDetails(
                                                          user: user0)));
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: LinearGradient(colors: [
                                                HexColor("00AE4D"),
                                                HexColor("00AE4D")
                                                    .withOpacity(0.5)
                                              ])),
                                          child: ListTile(
                                            title: Text(
                                              name,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: const Text(
                                              "Noida sector 62",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }
                              }
                            }))
                  ],
                ))
          ],
        ),
      );
    });
  }
}
