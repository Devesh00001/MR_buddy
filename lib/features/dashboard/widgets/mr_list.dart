import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../mr/screen/mr_week_detail.dart';
import '../../welcome/model/user.dart';
import '../provider/dashboard_provider.dart';

class MRList extends StatelessWidget {
  const MRList({super.key, required this.user});
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
                  child: Text("Your MR",
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w500))),
              SizedBox(
                  height: Utils.deviceHeight * 0.4,
                  child: FutureBuilder<Map<String, dynamic>>(
                      future: dashboardProvider.getAllMRDetail(user.mrNames),
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
                          return const Center(child: Text('No MR found'));
                        } else {
                          Map<String, User> data =
                              snapshot.data as Map<String, User>;
                          return ListView(
                            children: data.entries.map((entry) {
                              String name = entry.key;
                              User user0 = entry.value;

                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          MRWeekDetails(user: user0)));
                                },
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: ShapeDecoration(
                                      shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                          cornerRadius: 15,
                                          cornerSmoothing: 1,
                                        ),
                                      ),
                                      gradient: LinearGradient(colors: [
                                        HexColor("00AE4D"),
                                        HexColor("00AE4D").withOpacity(0.5)
                                      ])),
                                  child: ListTile(
                                    title: Text(
                                      name,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    subtitle: const Text(
                                      "Noida sector 62",
                                      style: TextStyle(color: Colors.white),
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
    });
  }
}
