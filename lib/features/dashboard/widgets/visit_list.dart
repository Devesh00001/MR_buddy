import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../visit_detail/screen/summary_page.dart';
import '../../visit_detail/screen/visit_detail.dart';
import '../../weekly plan/model/visit.dart';
import '../../welcome/model/user.dart';
import '../provider/dashboard_provider.dart';

class VisitList extends StatelessWidget {
  const VisitList({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
      return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Your Visits",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500))),
              SizedBox(
                  height: Utils.deviceHeight * 0.4,
                  child: FutureBuilder<Map<String, dynamic>>(
                      future: dashboardProvider.getWeeklyPlan(
                          user.name, dashboardProvider.selectedDate),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: Lottie.asset("assets/lottie/loading.json",
                                  height: 100));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(child: Text('No Visits found'));
                        } else {
                          Map<String, Visit> data =
                              snapshot.data as Map<String, Visit>;

                          DateFormat format = DateFormat('hh:mm a');

                          var sortedEntries = data.entries.toList()
                            ..sort((a, b) {
                              DateTime timeA = format.parse(a.key);
                              DateTime timeB = format.parse(b.key);
                              return timeA.compareTo(timeB);
                            });

                          Map<String, Visit> sortedData = {
                            for (var entry in sortedEntries)
                              entry.key: entry.value
                          };

                          return ListView(
                            children: sortedData.entries.map((entry) {
                              String time = entry.key;
                              Visit visit = entry.value;
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        time,
                                        style: TextStyle(
                                            fontSize: Utils.isTab ? 20 : 14),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (visit.checkOut == false) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        VisitDetail(
                                                            visit: visit)));
                                          } else {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SummaryPage(
                                                            visit: visit,
                                                            showNewVisitBtn:
                                                                false)));
                                          }
                                        },
                                        child: Container(
                                            width: Utils.deviceWidth * 0.7,
                                            padding: const EdgeInsets.all(15),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: ShapeDecoration(
                                                shape: SmoothRectangleBorder(
                                                  borderRadius:
                                                      SmoothBorderRadius(
                                                    cornerRadius: 15,
                                                    cornerSmoothing: 1,
                                                  ),
                                                ),
                                                gradient: visit.checkOut
                                                    ? LinearGradient(colors: [
                                                        HexColor("00AE4D"),
                                                        HexColor("00AE4D")
                                                            .withOpacity(0.5)
                                                      ])
                                                    : LinearGradient(colors: [
                                                        HexColor("1B2E62"),
                                                        HexColor("365FC8")
                                                      ])),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(visit.clientName,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                Utils.isTab
                                                                    ? 18
                                                                    : 14)),
                                                    Text(
                                                      visit.address,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: Utils.isTab
                                                              ? 18
                                                              : 14),
                                                    ),
                                                  ],
                                                ),
                                                Icon(
                                                  visit.placeType ==
                                                          'Private Clinic'
                                                      ? FontAwesomeIcons
                                                          .houseChimneyMedical
                                                      : FontAwesomeIcons
                                                          .solidHospital,
                                                  color: Colors.white,
                                                  size: Utils.isTab ? 30 : 24,
                                                ),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  const Divider()
                                ],
                              );
                            }).toList(),
                          );
                        }
                      }))
            ],
          ));
    });
  }
}
