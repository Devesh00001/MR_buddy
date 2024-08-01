import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../../home/screen/home_screen.dart';
import '../provider/visitdetail_provider.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
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
            const Text(
              "Check Out From Visit",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: Utils.deviceHeight * 0.05),
            const Text(
              "Send Notification To your reporting Manager",
              style: TextStyle(fontSize: 16),
            ),
            InkWell(
              onTap: () {
                Provider.of<VisitDetailProvider>(context, listen: false)
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
