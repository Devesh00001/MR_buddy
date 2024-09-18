import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mr_buddy/features/weekly%20plan/widgets/custom_dropdown.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../provider/data_disualization_provider.dart';

class MrDetailVisualization extends StatefulWidget {
  const MrDetailVisualization({super.key});

  @override
  State<MrDetailVisualization> createState() => _MrDetailVisualizationState();
}

class _MrDetailVisualizationState extends State<MrDetailVisualization> {
  Map<int, String> namesMap = {
    0: 'Devesh',
    1: 'Rohit',
    2: 'Aditya',
    3: 'Darshan',
    4: 'Asim',
  };
  @override
  Widget build(BuildContext context) {
    return Consumer<DataVisualizationProvider>(
        builder: (context, dataProvider, child) {
      return ListView(children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Flexible(
                    child: CustomDropdown(
                      selectedValue: dataProvider.region,
                      hintText: "Region",
                      placeHolder: "Select Region",
                      textStyle: const TextStyle(fontSize: 12),
                      values: dataProvider.regionList,
                      setFunction: dataProvider.setRegion,
                      isRequired: true,
                      validateFunction: dataProvider.validateInput,
                    ),
                  ),
                  const SizedBox(width: 100),
                  Flexible(
                    child: CustomDropdown(
                      selectedValue: dataProvider.period,
                      hintText: "Period",
                      placeHolder: "Select Period",
                      values: dataProvider.periodList,
                      setFunction: dataProvider.setPreiod,
                      textStyle: const TextStyle(fontSize: 12),
                      isRequired: true,
                      validateFunction: dataProvider.validateInput,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  HexColor("5B99C2"),
                                  HexColor("1F316F")
                                ])),
                          ),
                          const Text(
                            "Plan Visits",
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  HexColor("9CDBA6"),
                                  HexColor("508D4E")
                                ])),
                          ),
                          const Text(
                            "Check In visit",
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(colors: [
                                  HexColor("FF8A8A"),
                                  HexColor("800000")
                                ])),
                          ),
                          const Text(
                            "New Clients",
                            style: TextStyle(fontSize: 12),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              height: Utils.deviceHeight * 0.5,
              margin: const EdgeInsets.all(10),
              child: BarChart(BarChartData(
                  borderData: FlBorderData(
                      border: const Border(
                          bottom: BorderSide(), left: BorderSide())),
                  gridData: const FlGridData(
                      show: false,
                      drawVerticalLine: false,
                      drawHorizontalLine: true),
                  barGroups: [
                    BarChartGroupData(x: 0, barsSpace: 5, barRods: [
                      BarChartRodData(
                          toY: 20,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [HexColor("5B99C2"), HexColor("1F316F")]),
                          borderRadius: BorderRadius.zero,
                          width: 20),
                      BarChartRodData(
                          toY: 15,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [HexColor("9CDBA6"), HexColor("508D4E")]),
                          borderRadius: BorderRadius.zero,
                          width: 20),
                      BarChartRodData(
                          toY: 5,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [HexColor("FF8A8A"), HexColor("800000")]),
                          borderRadius: BorderRadius.zero,
                          width: 20)
                    ]),
                    BarChartGroupData(x: 1, barsSpace: 5, barRods: [
                      BarChartRodData(
                          toY: 40,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [HexColor("5B99C2"), HexColor("1F316F")]),
                          borderRadius: BorderRadius.zero,
                          width: 20),
                      BarChartRodData(
                          toY: 37,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [HexColor("9CDBA6"), HexColor("508D4E")]),
                          borderRadius: BorderRadius.zero,
                          width: 20),
                      BarChartRodData(
                          toY: 3,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [HexColor("FF8A8A"), HexColor("800000")]),
                          borderRadius: BorderRadius.zero,
                          width: 20)
                    ]),
                    BarChartGroupData(x: 2, barsSpace: 5, barRods: [
                      BarChartRodData(
                          toY: 37,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              colors: [HexColor("5B99C2"), HexColor("1F316F")]),
                          borderRadius: BorderRadius.zero,
                          width: 20),
                      BarChartRodData(
                          toY: 32,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [HexColor("9CDBA6"), HexColor("508D4E")]),
                          borderRadius: BorderRadius.zero,
                          width: 20),
                      BarChartRodData(
                          toY: 5,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [HexColor("FF8A8A"), HexColor("800000")]),
                          borderRadius: BorderRadius.zero,
                          width: 20)
                    ]),
                  ],
                  alignment: BarChartAlignment.spaceAround,
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      axisNameWidget: const Text(
                        "Medical Representatives",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          const style = TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          );
                          String text;
                          switch (value.toInt()) {
                            case 0:
                              text = namesMap[value.toInt()]!;
                              break;
                            case 1:
                              text = namesMap[value.toInt()]!;
                              break;
                            case 2:
                              text = namesMap[value.toInt()]!;
                              break;
                            case 3:
                              text = namesMap[value.toInt()]!;
                              break;
                            default:
                              text = '';
                              break;
                          }
                          return TextButton(
                            style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0)),
                            onPressed: () {
                              log(text);
                              dataProvider.setMrName(text);
                            },
                            child: SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 0,
                              child:
                                  Text(namesMap[value.toInt()]!, style: style),
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipRoundedRadius: 10,
                        getTooltipColor: (group) {
                          return Colors.black;
                        },
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                              rodIndex != 2
                                  ? "${rod.toY.round().toString()} Visits"
                                  : "${rod.toY.round().toString()} Clients",
                              const TextStyle(color: Colors.white));
                        },
                      ),
                      mouseCursorResolver:
                          (FlTouchEvent event, BarTouchResponse? result) {
                        if (result == null || result.spot == null) {
                          return SystemMouseCursors.basic;
                        }
                        return SystemMouseCursors.click;
                      }))),
            ),
            Visibility(
                visible: dataProvider.getMrName() == null,
                child: const Text(
                    "Please Select any mr Name to see data in table")),
            Visibility(
              visible: dataProvider.getMrName() != null,
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(100),
                border: TableBorder.symmetric(inside: const BorderSide()),
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(),
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10))),
                      children: const [
                        TableCell(
                          text: "Mr Name",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          aligment: TextAlign.center,
                        ),
                        TableCell(
                          text: "Total Plan Visits",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          aligment: TextAlign.center,
                        ),
                        TableCell(
                          text: "Check In Visit",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          aligment: TextAlign.center,
                        ),
                        TableCell(
                          text: "New Clients Add",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          aligment: TextAlign.center,
                        ),
                      ]),
                  TableRow(
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(10))),
                      children: [
                        TableCell(
                          text: dataProvider.getMrName() ?? "",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          aligment: TextAlign.center,
                        ),
                        TableCell(
                          text: dataProvider
                                  .getMrData()[dataProvider.getMrName() ?? ""]
                                      ?['Total Visit']
                                  .toString() ??
                              '',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          aligment: TextAlign.center,
                        ),
                        TableCell(
                          text: dataProvider
                                  .getMrData()[dataProvider.getMrName() ?? ""]
                                      ?['Checkin']
                                  .toString() ??
                              "",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          aligment: TextAlign.center,
                        ),
                        TableCell(
                          text: dataProvider
                                  .getMrData()[dataProvider.getMrName() ?? ""]
                                      ?['New Clients']
                                  .toString() ??
                              '',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          aligment: TextAlign.center,
                        ),
                      ]),
                ],
              ),
            )
          ],
        ),
      ]);
    });
  }
}

class TableCell extends StatelessWidget {
  const TableCell(
      {super.key,
      required this.text,
      required this.aligment,
      required this.style});
  final String text;
  final TextStyle style;
  final TextAlign aligment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: style,
        textAlign: aligment,
        textScaler: TextScaler.noScaling,
      ),
    );
  }
}
