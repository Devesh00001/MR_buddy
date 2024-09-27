import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../provider/dashboard_provider.dart';
import 'date_tile.dart';

class VisitsInfoCard extends StatefulWidget {
  const VisitsInfoCard({super.key});

  @override
  State<VisitsInfoCard> createState() => _VisitsInfoCardState();
}

class _VisitsInfoCardState extends State<VisitsInfoCard> {
  bool isFold = Utils.deviceHeight < 600;
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
      return Container(
        height: Utils.deviceHeight * 0.15,
        width: Utils.deviceWidth * 0.90,
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 10),
        constraints: BoxConstraints(minHeight: 120),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [HexColor("1B2E62"), HexColor("365FC8")])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      DateTile(date: dashboardProvider.fromDate),
                      const SizedBox(width: 5),
                      DateTile(date: dashboardProvider.fromDate),
                    ],
                  ),
                  // const SizedBox(height: 30),
                  SizedBox(
                    width: Utils.deviceWidth * 0.4,
                    child: Text(
                      "Completed Visits",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 20 * Utils.fontSizeModifer,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: Utils.deviceHeight * 0.1,
                      width: Utils.deviceHeight * 0.1,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(
                            begin: 0,
                            end: dashboardProvider.completedVisits / 100),
                        duration: const Duration(seconds: 1),
                        builder: (context, value, _) =>
                            CircularProgressIndicator(
                          strokeWidth: 10,
                          strokeCap: StrokeCap.round,
                          backgroundColor: HexColor("4AB97B").withOpacity(0.5),
                          color: HexColor("4AB97B"),
                          value: value,
                        ),
                      ),
                    ),
                    Text(
                      "${dashboardProvider.completedVisits.toString()}%",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20 * Utils.fontSizeModifer),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
