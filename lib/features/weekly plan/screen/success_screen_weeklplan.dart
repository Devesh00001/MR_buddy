import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';

import '../../home/screen/home_screen.dart';
import '../provider/weekly_plan_provider.dart';

class SuccessScreenWeeklyPlan extends StatelessWidget {
  const SuccessScreenWeeklyPlan(
      {super.key, required this.heading, required this.subHeading});
  final String heading;
  final String subHeading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Utils.deviceHeight,
        width: Utils.deviceWidth,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset("assets/lottie/CompleteLottie.json",
                repeat: false, height: Utils.deviceHeight * 0.4),
            Text(
              heading,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Utils.deviceHeight * 0.05),
            SizedBox(
              width: Utils.deviceWidth * 0.9,
              child: Text(
                subHeading,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            InkWell(
              onTap: () {
                Provider.of<WeeklyProviderPlan>(context, listen: false)
                    .resetProvider();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Home()),
                    (r) => false);
              },
              child: Container(
                margin: const EdgeInsets.all(20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: HexColor("2F52AC"),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
