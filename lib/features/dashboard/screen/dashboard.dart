import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../../welcome/model/user.dart';
import '../../welcome/provider/welcome_provider.dart';
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
      const FlSpot(1, 10),
      const FlSpot(2, 15),
      const FlSpot(3, 8),
      const FlSpot(4, 12),
      const FlSpot(5, 13),
      const FlSpot(6, 7),
    ];
    User? user = Provider.of<WelcomeProvider>(context).user;
    return Column(
      children: [
        UserInfoTile(user: user),
        const VisitsInfoCard(),
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: Utils.deviceHeight * 0.23,
                  child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (ctx, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                HexColor("00AE4D"),
                                HexColor("00AE4D").withOpacity(0.5)
                              ])),
                          child: const ListTile(
                            title: Text(
                              "Fortis Hospital",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Noida Sector 62",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ))
      ],
    );
  }
}
