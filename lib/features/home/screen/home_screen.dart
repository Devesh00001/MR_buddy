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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppBar(),
      body: _screens[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 80,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor: HexColor("00AE4D"),
              shape: const CircleBorder(),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const WeeklyPlan()));
              },
              child: const Icon(
                Icons.task_outlined,
                size: 30,
                color: Colors.white,
              )),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        color: HexColor("2F52AC"),
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
                    size: 32,
                    color: _currentIndex == 0 ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "Home",
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentIndex == 0 ? Colors.white : Colors.black,
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
                    size: 32,
                    color: _currentIndex == 1 ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "Client",
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentIndex == 1 ? Colors.white : Colors.black,
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
                    size: 32,
                    color: _currentIndex == 2 ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "Drugs",
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentIndex == 2 ? Colors.white : Colors.black,
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
                    size: 32,
                    color: _currentIndex == 3 ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  "HRMS",
                  style: TextStyle(
                    fontSize: 12,
                    color: _currentIndex == 3 ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
