import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../../widgets/custome_appbar.dart';
import '../../dashboard/provider/dashboard_provider.dart';
import '../../weekly plan/model/visit.dart';
import '../widget/user_info_card.dart';

class MRWeekDetails extends StatefulWidget {
  const MRWeekDetails({super.key, required this.user});
  final User user;

  @override
  State<MRWeekDetails> createState() => _MRWeekDetailsState();
}

class _MRWeekDetailsState extends State<MRWeekDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "MR Week Detail"),
      body: Column(
        children: [
          UserInfoCard(user: widget.user),
          Consumer<DashboardProvider>(
              builder: (context, dashboardProvider, child) {
            return Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Your MR Visits",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                        height: Utils.deviceHeight * 0.61,
                        child: FutureBuilder<Map<String, Visit>>(
                            future: dashboardProvider
                                .getWeeklyPlan(widget.user.name),
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
                                return ListView(
                                  children: dashboardProvider.weeklyPlan.entries
                                      .map((entry) {
                                    String day = entry.key;
                                    Visit visit = entry.value;

                                    return InkWell(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             CheckInScreen(
                                        //                 visit: visit)));
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
                              }
                            }))
                  ],
                ));
          })
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 60,
        width: 200,
        decoration: BoxDecoration(
            color: HexColor("2F52AC"), borderRadius: BorderRadius.circular(5)),
        child: const Center(
            child: Text(
          "Approve Weekly Plan",
          style: TextStyle(color: Colors.white, fontSize: 16),
        )),
      ),
    );
  }
}
