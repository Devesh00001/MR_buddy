import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';
import '../../../utils.dart';
import '../../../widgets/custom_appbar.dart';
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
      body: Stack(
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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(10, 0))
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Center(
                      child: CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(
                            'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Text(
                      user.name,
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
                const UserDetailFiled(
                    icon: FontAwesomeIcons.user,
                    title: "Manager",
                    value: "Himanshu"),
                const UserDetailFiled(
                    icon: Icons.location_on_rounded,
                    title: "Location",
                    value: "Noida sector 62"),
                const UserDetailFiled(
                    icon: FontAwesomeIcons.userTie,
                    title: "Client",
                    value: 'Dr. Reddy, Dr. Trehan'),
                const UserDetailFiled(
                    icon: Icons.email,
                    title: "Email",
                    value: 'Example@gmail.com'),
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
        ],
      ),
    );
  }
}
