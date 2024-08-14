import 'package:flutter/material.dart';
import 'package:mr_buddy/features/visit_detail/widgets/check_in_screen.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_appbar.dart';
import '../../weekly plan/model/visit.dart';
import '../provider/visitdetail_provider.dart';
import '../widgets/custom_easy_stepper.dart';
import '../widgets/drugs_details.dart';
import '../widgets/lead_inputs.dart';
import 'summary_page.dart';
import '../widgets/visit_inputs.dart';

class VisitDetail extends StatefulWidget {
  const VisitDetail({super.key, required this.visit});
  final Visit visit;

  @override
  State<VisitDetail> createState() => _VisitDetailState();
}

List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>()
];

class _VisitDetailState extends State<VisitDetail> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<VisitDetailProvider>(context, listen: false);
    provider.getDrugName();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Provider.of<VisitDetailProvider>(context, listen: false)
            .resetProvider();
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: "Visit Detail"),
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
            Consumer<VisitDetailProvider>(
                builder: (context, visitDetailProvider, child) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomEasyStepper(
                          activeStep: visitDetailProvider.currentStep),
                      Container(
                        height: Utils.deviceHeight * 0.65,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10))
                            ]),
                        child: getVisitForm(visitDetailProvider.currentStep),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Visibility(
                            visible: visitDetailProvider.getCurrectStep() > 1,
                            child: Expanded(
                              child: InkWell(
                                onTap: () async {
                                  visitDetailProvider.decreaseStep();
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: HexColor("00AE4D"),
                                        borderRadius: BorderRadius.circular(5)),
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    child: const Center(
                                      child: Text(
                                        'back',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (visitDetailProvider.getCurrectStep() == 0) {
                                  visitDetailProvider.increaseStep();
                                } else if (formKeys[
                                        visitDetailProvider.getCurrectStep()]
                                    .currentState!
                                    .validate()) {
                                  if (visitDetailProvider.getCurrectStep() ==
                                      3) {
                                    bool status = await visitDetailProvider
                                        .uploadData(widget.visit);
                                    if (status) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SummaryPage(
                                                  visit: widget.visit,
                                                  showNewVisitBtn: true,
                                                )),
                                      );
                                    }
                                  } else {
                                    visitDetailProvider.increaseStep();
                                  }
                                }
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: HexColor("00AE4D"),
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      visitDetailProvider.currentStep == 0
                                          ? "CHECK IN"
                                          : visitDetailProvider.currentStep == 3
                                              ? 'CHECK OUT'
                                              : 'Next',
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  getVisitForm(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return CheckInScreen(visit: widget.visit);
      case 1:
        return DrugInfo(visit: widget.visit);
      case 2:
        return VisitInputs(visit: widget.visit);
      case 3:
        return LeadInputs(visit: widget.visit);
      default:
        return [];
    }
  }
}
