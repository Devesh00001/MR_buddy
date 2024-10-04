import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../../dashboard/provider/dashboard_provider.dart';
import '../../visit_detail/screen/manager_visit_detail.dart';
import '../../visit_detail/screen/summary_page.dart';
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
        appBar: const CustomAppBar(title: "MR Visit's Detail"),
        body: Consumer<DashboardProvider>(
            builder: (context, dashboardProvider, child) {
          return Stack(
            children: [
              Positioned(
                  child: Container(
                height: Utils.deviceHeight * 0.3,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      HexColor("00AE4D"),
                      HexColor("00AE4D").withOpacity(0.5)
                    ])),
              )),
              Container(
                  height: Utils.deviceHeight,
                  margin: const EdgeInsets.all(10),
                  child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shrinkWrap: true,
                      children: [
                        Column(
                          children: [
                            UserInfoCard(user: widget.user),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                shape: SmoothRectangleBorder(
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: 15,
                                    cornerSmoothing: 1,
                                  ),
                                ),
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: TableCalendar(
                                firstDay: DateTime.utc(2010, 10, 16),
                                lastDay: DateTime.utc(2030, 3, 14),
                                rowHeight: Utils.isTab ? 50 : 30,
                                focusedDay: dashboardProvider.focusDate,
                                headerVisible: true,
                                headerStyle: const HeaderStyle(
                                    titleCentered: true,
                                    headerPadding: EdgeInsets.zero,
                                    formatButtonVisible: false),
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                      fontSize: Utils.isTab
                                          ? 20.0
                                          : 12 * Utils.fontSizeModifer),
                                  weekendStyle: TextStyle(
                                      fontSize: Utils.isTab
                                          ? 20.0
                                          : 12 * Utils.fontSizeModifer,
                                      color: Colors.grey.shade400),
                                ),
                                calendarStyle: CalendarStyle(
                                    outsideTextStyle: TextStyle(
                                        fontSize: Utils.isTab
                                            ? 20
                                            : 12 * Utils.fontSizeModifer,
                                        color: Colors.grey.shade400),
                                    weekendTextStyle: TextStyle(
                                        fontSize: Utils.isTab
                                            ? 20
                                            : 12 * Utils.fontSizeModifer,
                                        color: Colors.grey.shade400),
                                    defaultTextStyle: TextStyle(
                                        fontSize: Utils.isTab
                                            ? 20
                                            : 12 * Utils.fontSizeModifer),
                                    disabledTextStyle: TextStyle(
                                        fontSize: Utils.isTab
                                            ? 20
                                            : 12 * Utils.fontSizeModifer),
                                    todayTextStyle: TextStyle(
                                        fontSize: Utils.isTab
                                            ? 20
                                            : 12 * Utils.fontSizeModifer),
                                    selectedTextStyle: TextStyle(
                                        fontSize: Utils.isTab
                                            ? 20
                                            : 12 * Utils.fontSizeModifer,
                                        color: Colors.white)),
                                selectedDayPredicate: (day) {
                                  return isSameDay(
                                      dashboardProvider.selectedDate, day);
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  if (!isSameDay(dashboardProvider.selectedDate,
                                      selectedDay)) {
                                    dashboardProvider
                                        .setSelectedDate(selectedDay);
                                    dashboardProvider.setFocusDate(focusedDay);
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Your MR Visits",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                            ),
                            FutureBuilder<Map<String, Visit>>(
                                future: dashboardProvider.getWeeklyPlan(
                                    widget.user.name,
                                    dashboardProvider.selectedDate),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: Lottie.asset(
                                            "assets/lottie/loading.json",
                                            height: 100));
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                            Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Center(
                                        child: Text('No Visits found'));
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      children: sortedData.entries.map((entry) {
                                        String time = entry.key;
                                        Visit visit = entry.value;
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  time,
                                                  style: TextStyle(
                                                      fontSize: Utils.isTab
                                                          ? 20
                                                          : 12 *
                                                              Utils
                                                                  .fontSizeModifer),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    if (visit.checkOut ==
                                                        false) {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  ManagerVisitDetail(
                                                                      visit:
                                                                          visit,
                                                                      user: widget
                                                                          .user)));
                                                    } else {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SummaryPage(
                                                                      visit:
                                                                          visit,
                                                                      showNewVisitBtn:
                                                                          false)));
                                                    }
                                                  },
                                                  child: Container(
                                                      width: Utils.deviceWidth *
                                                          0.6,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10),
                                                      decoration:
                                                          ShapeDecoration(
                                                              shape:
                                                                  SmoothRectangleBorder(
                                                                borderRadius:
                                                                    SmoothBorderRadius(
                                                                  cornerRadius:
                                                                      15,
                                                                  cornerSmoothing:
                                                                      1,
                                                                ),
                                                              ),
                                                              gradient: visit
                                                                          .status ==
                                                                      'Approve'
                                                                  ? LinearGradient(
                                                                      colors: [
                                                                          HexColor(
                                                                              "00AE4D"),
                                                                          HexColor("00AE4D")
                                                                              .withOpacity(0.5)
                                                                        ])
                                                                  : LinearGradient(
                                                                      colors: [
                                                                          HexColor(
                                                                              "1B2E62"),
                                                                          HexColor(
                                                                              "365FC8")
                                                                        ])),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            flex: 8,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    visit
                                                                        .clientName,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: Utils.isTab
                                                                            ? 18
                                                                            : 12 *
                                                                                Utils.fontSizeModifer)),
                                                                Text(
                                                                  visit.address,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize: Utils
                                                                              .isTab
                                                                          ? 18
                                                                          : 12 *
                                                                              Utils.fontSizeModifer),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Icon(
                                                                visit.checkOut ==
                                                                        true
                                                                    ? Icons
                                                                        .location_on
                                                                    : Icons
                                                                        .location_off,
                                                                color: Colors
                                                                    .white,
                                                                size:
                                                                    Utils.isTab
                                                                        ? 30
                                                                        : 24),
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
                                })
                          ],
                        ),
                      ])),
            ],
          );
        }),
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
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        mrProvider.approve
                            ? "Already Approve"
                            : "Approve Weekly Plan",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Utils.isTab ? 20 : 16),
                      )),
          );
        }));
  }
}

class BottomCurveClipper extends CustomClipper<Path> {
  final double curveHeight;

  BottomCurveClipper({this.curveHeight = 30.0});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - curveHeight);

    var firstControlPoint = Offset(size.width / 4, size.height + curveHeight);
    var firstEndPoint = Offset(size.width / 2, size.height);

    var secondControlPoint =
        Offset(size.width * 3 / 4, size.height + curveHeight);
    var secondEndPoint = Offset(size.width, size.height - curveHeight);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
