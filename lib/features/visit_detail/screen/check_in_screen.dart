import 'package:flutter/material.dart';
import 'package:mr_buddy/utils.dart';

import '../../../widgets/custome_appbar.dart';
import '../../weekly plan/model/visit.dart';
import '../widgets/visit_status.dart';
import '../widgets/visit_text_field.dart';
import 'check_out_screen.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key, required this.visit});
  final Visit visit;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Visit Detail"),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: Utils.deviceHeight,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              VisitStatus(
                  visitStatus: widget.visit.status,
                  visitDate: widget.visit.date),
              const SizedBox(height: 20),
              SizedBox(
                width: Utils.deviceWidth * 0.8,
                child: Column(
                  children: [
                    VisitTextField(
                      hintText: "Client",
                      value: widget.visit.clientName,
                      validateFunction: (value) {},
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Place Type",
                      value: widget.visit.placeType,
                      validateFunction: (value) {},
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Address",
                      value: widget.visit.address,
                      validateFunction: (value) {},
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Visit Purpose/Plan",
                      value: widget.visit.address,
                      validateFunction: (value) {},
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Contact Point/Doctor",
                      value: widget.visit.address,
                      validateFunction: (value) {},
                    ),
                    const SizedBox(height: 50),
                    VisitTextField(
                        hintText: "Manager Comments",
                        value: widget.visit.comments,
                        validateFunction: (value) {},
                        size: 100),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          CheckOutScreen(visit: widget.visit)));
                },
                child: Container(
                    width: Utils.deviceWidth * 0.4,
                    decoration: BoxDecoration(
                        color: HexColor("00AE4D"),
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.all(10),
                    child: const Center(
                      child: Text(
                        "CHECK IN",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
