import 'package:flutter/material.dart';
import 'package:mr_buddy/features/dashboard/screen/dashboard.dart';
import 'package:mr_buddy/features/home/screen/home.dart';
import 'package:mr_buddy/utils.dart';
import 'package:mr_buddy/widgets/comman_appbar.dart';

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
    const HomeScreen(),
    const DashBoardScreen(),
    const DashBoardScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(),
      body: _screens[_currentIndex],
      bottomNavigationBar: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 70,
            decoration: BoxDecoration(
                color: HexColor("2F52AC"),
                borderRadius: BorderRadius.circular(30)),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
          Container(
            height: 90,
            width: 90,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: HexColor("00AE4D")),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WeeklyPlan()));
                },
                icon: const Icon(
                  Icons.task_outlined,
                  size: 40,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }
}
