import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mr_buddy/features/dashboard/screen/dashboard.dart';
import 'package:mr_buddy/utils.dart';
import 'package:mr_buddy/widgets/comman_appbar.dart';
import 'package:provider/provider.dart';

import '../../clients/screen/all_client.dart';
import '../../drugs/screen/drugs_list.dart';
import '../../hrms/screen/hrms_screen.dart';
import '../../mr_detail_visualization/screen/mr_detail_visualization.dart';
import '../../weekly plan/screen/single_visit_screen.dart';
import '../../weekly plan/screen/weekly_plan.dart';
import '../../welcome/model/user.dart';
import '../../welcome/provider/welcome_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  double _scaleFactor = 1.0;

  void _onTap(int index) {
    setState(() {
      _scaleFactor = 1.3;
      _currentIndex = index;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _scaleFactor = 1.0;
      });
    });
  }

  final List<Widget> _mrScreens = [
    const DashBoardScreen(),
    const AllClientScreen(),
    const DrugsList(),
    const HrmsScreen(),
  ];

  final List<Widget> _supervisorScreens = [
    const DashBoardScreen(),
    const AllClientScreen(),
    const DrugsList(),
    const MrDetailVisualization(),
  ];

  final List<String> supervisorTitleList = [
    'DashBoard',
    'Clients',
    'Drugs',
    'Analytics'
  ];

  final List<String> mrTitleList = ['DashBoard', 'Clients', 'Drugs', 'HRMS'];
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<WelcomeProvider>(context).user;
    List<SpeedDialChild> mrWidget = [
      SpeedDialChild(
        child: const Icon(Icons.assignment_rounded),
        label: 'Create Weekly Plan',
        labelStyle: TextStyle(fontSize: 12 * Utils.fontSizeModifer),
        shape: const CircleBorder(),
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const WeeklyPlan()));
        },
      ),
      SpeedDialChild(
        child: const Icon(FontAwesomeIcons.userDoctor),
        label: 'Add a single visit',
        labelStyle: TextStyle(fontSize: 12 * Utils.fontSizeModifer),
        shape: const CircleBorder(),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SingleVisitScreen()));
        },
      )
    ];
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(
          showIcons: _currentIndex == 0 ? true : false,
          title: user!.role == 'MR'
              ? mrTitleList[_currentIndex]
              : supervisorTitleList[_currentIndex]),
      body: user.role == 'MR'
          ? _mrScreens[_currentIndex]
          : _supervisorScreens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.clear_outlined,
        iconTheme: const IconThemeData(color: Colors.white),
        overlayColor: Colors.black,
        backgroundColor: HexColor("2F52AC"),
        overlayOpacity: 0.4,
        spaceBetweenChildren: 8,
        onOpen: () {
          if (user.role != 'MR') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const SingleVisitScreen()));
          }
        },
        children: user.role == 'MR' ? mrWidget : [],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 15,
              blurRadius: 20,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomAppBar(
          surfaceTintColor: Colors.white,
          elevation: 20,
          shadowColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: Utils.isTab ? 80 : 60,
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildIconColumn(Icons.home, "Home", 0),
              buildIconColumn(Icons.people, "Client", 1),
              const SizedBox(width: 20),
              buildIconColumn(Icons.medication, "Drugs", 2),
              user.role == 'MR'
                  ? buildIconColumn(Icons.calendar_month, "HRMS", 3)
                  : buildIconColumn(Icons.bar_chart, "Analytics", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIconColumn(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        _onTap(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedScale(
            scale: _currentIndex == index ? _scaleFactor : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.bounceIn,
            child: Icon(
              icon,
              size: Utils.isTab ? 40 : 32,
              color: _currentIndex == index ? HexColor("2F52AC") : Colors.black,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: Utils.isTab ? 18 : 12,
              color: _currentIndex == index ? HexColor("2F52AC") : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
