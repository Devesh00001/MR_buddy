import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';

class VisitLineChart extends StatelessWidget {
  const VisitLineChart(
      {super.key,
      required this.linerChartSpots,
      required this.maxYValue,
      required this.intervel});

  final List<FlSpot> linerChartSpots;
  final double maxYValue;
  final double intervel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.deviceHeight * 0.20,
      margin: const EdgeInsets.fromLTRB(0, 20, 20, 0),
      color: Colors.white,
      child: LineChart(
        LineChartData(
          minY: 0,
          maxY: maxYValue,
          minX: 1,
          // maxX: 7,

          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: intervel,
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: linerChartSpots,
              barWidth: 2,
              color: Colors.green.shade500,
              isCurved: true,
              preventCurveOverShooting: true,
              isStrokeCapRound: true,
              isStrokeJoinRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(colors: [
                  Colors.green.shade100.withOpacity(0.1),
                  Colors.green.shade300.withOpacity(0.5),
                ], begin: Alignment.bottomCenter, end: Alignment.center),
              ),
              dotData: const FlDotData(show: false),
            )
          ],
          titlesData: FlTitlesData(
              rightTitles: const AxisTitles(
                drawBelowEverything: false,
              ),
              topTitles: const AxisTitles(drawBelowEverything: false),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                    showTitles: true, reservedSize: 35, interval: intervel),
              ),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt() % 7) {
                    case 1:
                      return const Text("Mon");
                    case 2:
                      return const Text("Tue");
                    case 3:
                      return const Text("Wed");
                    case 4:
                      return const Text("Thu");
                    case 5:
                      return const Text("Fir");
                    case 6:
                      return const Text("Sat");
                    case 0:
                      return const Text("Sun");
                  }
                  return const Text("");
                },
              ))),
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      ),
    );
  }
}