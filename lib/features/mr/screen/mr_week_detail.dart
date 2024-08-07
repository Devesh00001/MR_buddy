import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';
import 'package:provider/provider.dart';
import '../../../utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../../dashboard/provider/dashboard_provider.dart';
import '../../visit_detail/screen/manager_visit_detail.dart';
import '../../weekly plan/model/visit.dart';
import '../widget/button_click.dart';
import '../widget/user_info_card.dart';

class MRWeekDetails extends StatefulWidget {
  const MRWeekDetails({super.key, required this.user});
  final User user;

  @override
  State<MRWeekDetails> createState() => _MRWeekDetailsState();
}

class _MRWeekDetailsState extends State<MRWeekDetails> {
  getStatusOfApprovel() async {}

  @override
  void initState() {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.isWeeklyPlanStatus(widget.user.name);
    super.initState();
  }

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
                                    children: dashboardProvider
                                        .weeklyPlan.entries
                                        .map((entry) {
                                      String day = entry.key;
                                      Visit visit = entry.value;

                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ManagerVisitDetail(
                                                        visit: visit,
                                                        user: widget.user,
                                                      )));
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
        floatingActionButton:
            Consumer<DashboardProvider>(builder: (context, mrProvider, child) {
          return FloatingActionButton.extended(
            backgroundColor:
                mrProvider.approve ? HexColor("00AE4D") : HexColor("2F52AC"),
            onPressed: () async {
              if (mrProvider.approve == false) {
                final screenSize = MediaQuery.of(context).size;
                final position =
                    Offset(screenSize.width / 2, screenSize.height / 1.2);
                const size = Size(100, 100);
                late final OverlayEntry entry;

                entry = OverlayEntry(
                  builder: (context) {
                    return Positioned(
                      top: position.dy - size.height / 2.0,
                      left: position.dx - size.width / 2.0,
                      child: ButtonClick(
                        size: size,
                        position: position,
                        overlayEntry: entry,
                      ),
                    );
                  },
                );

                Overlay.of(context).insert(entry);

                mrProvider.updateStatusOfWeeklyPlan(widget.user.name);
              }
            },
            label: Center(
                child: mrProvider.isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        mrProvider.approve
                            ? "Already Approve"
                            : "Approve Weekly Plan",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      )),
          );
        }));
  }
}
