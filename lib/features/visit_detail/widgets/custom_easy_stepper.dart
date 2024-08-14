import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/utils.dart';

class CustomEasyStepper extends StatelessWidget {
  final int activeStep;
  const CustomEasyStepper({super.key, required this.activeStep});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: EasyStepper(
        activeStep: activeStep,
        activeStepTextColor: Colors.black,
        finishedStepTextColor: Colors.black87,
        internalPadding: 0,
        showLoadingAnimation: false,
        stepRadius: 15,
        showStepBorder: false,
        fitWidth: false,
        stepAnimationCurve: Curves.easeInOut,
        lineStyle: LineStyle(
            lineThickness: 3,
            lineLength: Utils.deviceWidth * 0.16,
            lineType: LineType.normal,
            defaultLineColor: Colors.grey.shade300,
            unreachedLineColor: Colors.grey.shade300,
            finishedLineColor: HexColor("1A5319")),

        steps: [
          EasyStep(
              customStep: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey.shade300,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      activeStep >= 0 ? HexColor("1A5319") : Colors.white,
                  child: activeStep > 0
                      ? Icon(Icons.check,
                          color: activeStep >= 0 ? Colors.white : Colors.black)
                      : Text("1",
                          style: TextStyle(
                              color: activeStep >= 0
                                  ? Colors.white
                                  : Colors.black)),
                ),
              ),
              customTitle: Center(
                child: SizedBox(
                  width: 80,
                  child: Text(
                    "Visit Info",
                    style: TextStyle(
                        color: activeStep >= 0 ? Colors.black : Colors.white),
                  ),
                ),
              )),
          EasyStep(
              customStep: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey.shade300,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      activeStep >= 1 ? HexColor("1A5319") : Colors.white,
                  child: activeStep > 1
                      ? Icon(Icons.check,
                          color: activeStep >= 1 ? Colors.white : Colors.black)
                      : Text("2",
                          style: TextStyle(
                              color: activeStep >= 1
                                  ? Colors.white
                                  : Colors.black)),
                ),
              ),
              customTitle: Center(
                child: SizedBox(
                  width: 80,
                  child: Center(
                      child: Text(
                    "Drugs",
                    style: TextStyle(
                        color: activeStep >= 1 ? Colors.black : Colors.white),
                  )),
                ),
              )),
          EasyStep(
              customStep: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey.shade300,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      activeStep >= 2 ? HexColor("1A5319") : Colors.white,
                  child: activeStep > 2
                      ? Icon(Icons.check,
                          color: activeStep >= 2 ? Colors.white : Colors.black)
                      : Text(
                          "3",
                          style: TextStyle(
                              color: activeStep >= 2
                                  ? Colors.white
                                  : Colors.black),
                        ),
                ),
              ),
              customTitle: Center(
                child: SizedBox(
                  width: 80,
                  child: Text(
                    "Visit Input",
                    style: TextStyle(
                        color: activeStep >= 2 ? Colors.black : Colors.white),
                  ),
                ),
              )),
          EasyStep(
              customStep: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey.shade300,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor:
                      activeStep >= 3 ? HexColor("1A5319") : Colors.white,
                  child: activeStep > 3
                      ? Icon(Icons.check,
                          color: activeStep >= 3 ? Colors.white : Colors.black)
                      : Text("4",
                          style: TextStyle(
                              color: activeStep >= 3
                                  ? Colors.white
                                  : Colors.black)),
                ),
              ),
              customTitle: Center(
                child: SizedBox(
                  width: 80,
                  child: Text(
                    "Lead Info",
                    style: TextStyle(
                        color: activeStep >= 3 ? Colors.black : Colors.white),
                  ),
                ),
              )),
        ],
        // onStepReached: (index) =>
        //     setState(() => activeStep = index),
      ),
    );
  }
}
