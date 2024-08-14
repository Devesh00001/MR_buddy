import 'package:flutter/material.dart';
import 'package:mr_buddy/features/dashboard/screen/dashboard.dart';
import 'package:mr_buddy/utils.dart';
import 'package:mr_buddy/widgets/comman_appbar.dart';

import '../../clients/screen/all_client.dart';
import '../../drugs/screen/drugs_list.dart';
import '../../weekly plan/screen/weekly_plan.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const DashBoardScreen(),
    const AllClientScreen(),
    const DrugsList(),
    const DashBoardScreen(),
  ];

  final List<String> titleList = [
    'DashBoard',
    'Clients',
    'Drugs',
    'Past Visits'
  ];
  @override
  Widget build(BuildContext context) {
    bool isTab = Utils.deviceWidth > 600 ? true : false;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar(showIcons: true, title: titleList[_currentIndex]),
      body: _screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: HexColor("2F52AC"),
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WeeklyPlan()));
              },
              child: const Icon(
                Icons.add_rounded,
                size: 30,
                color: Colors.white,
              )),
        ),
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
          height: isTab ? 60 : 60,
          color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Icon(
                      Icons.home,
                      size: isTab ? 32 : 32,
                      color: _currentIndex == 0
                          ? HexColor("2F52AC")
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: isTab ? 12 : 12,
                      color: _currentIndex == 0
                          ? HexColor("2F52AC")
                          : Colors.black,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Icon(
                      Icons.people,
                      size: isTab ? 32 : 32,
                      color: _currentIndex == 1
                          ? HexColor("2F52AC")
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "Client",
                    style: TextStyle(
                      fontSize: isTab ? 12 : 12,
                      color: _currentIndex == 1
                          ? HexColor("2F52AC")
                          : Colors.black,
                    ),
                  )
                ],
              ),
              const SizedBox(width: 20),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Icon(
                      Icons.medication,
                      size: isTab ? 32 : 32,
                      color: _currentIndex == 2
                          ? HexColor("2F52AC")
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "Drugs",
                    style: TextStyle(
                      fontSize: isTab ? 12 : 12,
                      color: _currentIndex == 2
                          ? HexColor("2F52AC")
                          : Colors.black,
                    ),
                  )
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    child: Icon(
                      Icons.calendar_month,
                      size: isTab ? 32 : 32,
                      color: _currentIndex == 3
                          ? HexColor("2F52AC")
                          : Colors.black,
                    ),
                  ),
                  Text(
                    "HRMS",
                    style: TextStyle(
                      fontSize: isTab ? 12 : 12,
                      color: _currentIndex == 3
                          ? HexColor("2F52AC")
                          : Colors.black,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
