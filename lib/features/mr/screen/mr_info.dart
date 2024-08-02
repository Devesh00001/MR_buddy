import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';

import '../../../widgets/custome_appbar.dart';
import '../../dashboard/widgets/visitL_line_chart.dart';
import '../widget/user_info_card.dart';

class MRInfo extends StatelessWidget {
  const MRInfo({super.key, required this.user});
  final User user;

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
    return Scaffold(
      appBar: const CustomAppBar(title: "MR Info"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 50,
                  offset: const Offset(10, 10))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetailFiled(
              title: "Name",
              value: user.name,
              fontSize: 20,
            ),
            const UserDetailFiled(
              title: "Manager",
              value: "Himanshu",
              fontSize: 20,
            ),
            const UserDetailFiled(
              title: "Location",
              value: "Noida sector 62",
              fontSize: 20,
            ),
            const UserDetailFiled(
              title: "Client",
              value: 'Dr. Reddy, Dr. Trehan',
              fontSize: 20,
            ),
            const UserDetailFiled(
              title: "Total visits in this week",
              value: '30',
              fontSize: 20,
            ),
            const UserDetailFiled(
              title: "Total Visit in this Month: ",
              value: '100',
              fontSize: 20,
            ),
            const UserDetailFiled(
              title: "Total Visit in this Quarter: ",
              value: '300',
              fontSize: 20,
            ),
            const SizedBox(
                child: Text(
              "Sales",
              style: TextStyle(fontSize: 20),
            )),
            VisitLineChart(
              linerChartSpots: linerChartSpots,
              maxYValue: 20,
              intervel: 5,
            ),
          ],
        ),
      ),
    );
  }
}
