import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mr_buddy/features/drugs/model/logs.dart';
import 'package:provider/provider.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

import '../../../widgets/custom_appbar.dart';
import '../../weekly plan/widgets/custom_dropdown.dart';
import '../../welcome/model/user.dart';
import '../../welcome/provider/welcome_provider.dart';
import '../provider/drugs_provider.dart';

class DrugLogScreen extends StatefulWidget {
  const DrugLogScreen({super.key});

  @override
  State<DrugLogScreen> createState() => _DrugLogScreenState();
}

class _DrugLogScreenState extends State<DrugLogScreen> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<WelcomeProvider>(context, listen: false).user;

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        final provider = Provider.of<DrugsProvider>(context, listen: false);
        provider.resetMRName();
      },
      child: Scaffold(
          appBar: const CustomAppBar(title: "Logs"),
          body:
              Consumer<DrugsProvider>(builder: (context, drugProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomDropdown(
                      selectedValue: drugProvider.mrName,
                      hintText: "MR",
                      placeHolder: "Select MR",
                      values: user!.mrNames,
                      setFunction: drugProvider.setMRName,
                      isRequired: true,
                      validateFunction: (value) {},
                    ),
                  ),
                  Expanded(
                    flex: 18,
                    child: FutureBuilder<List<StepperItemData>>(
                        future: drugProvider.getLogs('Pregabalin'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: Lottie.asset(
                                    "assets/lottie/loading.json",
                                    height: 100));
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(child: Text('No logs found'));
                          } else {
                            return StepperListView(
                              showStepperInLast: true,
                              stepperData: snapshot.data ?? [],
                              stepAvatar: (_, data) {
                                return PreferredSize(
                                    preferredSize: const Size.fromRadius(20),
                                    child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green),
                                        child: const Icon(
                                          Icons.calendar_month,
                                          color: Colors.white,
                                        )));
                              },
                              stepContentWidget: (_, data) {
                                final stepData = data as StepperItemData;
                                final logData = stepData.content as Logs;
                                return Container(
                                  margin: const EdgeInsets.only(
                                    top: 20,
                                  ),
                                  padding: const EdgeInsets.all(
                                    15,
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(7),
                                    visualDensity: const VisualDensity(
                                      vertical: -4,
                                      horizontal: -4,
                                    ),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                                text: 'Total View(s) : ',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                                children: [
                                              TextSpan(
                                                  text:
                                                      logData.total.toString())
                                            ])),
                                        Text(
                                          logData.date,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    subtitle: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                              flex: 2,
                                              child: Icon(
                                                Icons.percent_rounded,
                                                color: Colors.green,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text:
                                                          'Promotional Detail View(s) : ',
                                                      style: const TextStyle(color: Colors.black, fontSize: 16),
                                                      children: [
                                                    TextSpan(
                                                        text: logData
                                                            .promotionalDetail
                                                            .toString())
                                                  ])),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                              flex: 2,
                                              child: Icon(
                                                Icons.insert_chart,
                                                color: Colors.blue,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text:
                                                          'Efficacy Data View(s) : ',
                                                      style: const TextStyle(color: Colors.black, fontSize: 16),
                                                      children: [
                                                    TextSpan(
                                                        text: logData
                                                            .efficacyData
                                                            .toString())
                                                  ])),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                              flex: 2,
                                              child: Icon(
                                                Icons.health_and_safety_rounded,
                                                color: Colors.red,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text:
                                                          'Safety Data View(s) : ',
                                                      style: const TextStyle(color: Colors.black, fontSize: 16),
                                                      children: [
                                                    TextSpan(
                                                        text: logData.safetyData
                                                            .toString())
                                                  ])),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            const Expanded(
                                              flex: 2,
                                              child: Icon(
                                                FontAwesomeIcons.pills,
                                                color: Colors.yellow,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 8,
                                              child: RichText(
                                                  text: TextSpan(
                                                      text:
                                                          'Dosage Info View(s) : ',
                                                      style: const TextStyle(color: Colors.black, fontSize: 16),
                                                      children: [
                                                    TextSpan(
                                                        text: logData.dosageInfo
                                                            .toString())
                                                  ])),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      side: const BorderSide(
                                        // color: theme.dividerColor,
                                        width: 0.8,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              stepperThemeData: const StepperThemeData(
                                lineColor: Colors.blueAccent,
                                lineWidth: 3,
                              ),
                              physics: const BouncingScrollPhysics(),
                            );
                          }
                        }),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
