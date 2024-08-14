import 'package:flutter/material.dart';

import '../../../utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../../visit_detail/model/past_visit.dart';
import '../../visit_detail/screen/summary_page.dart';

class PastVisitDetail extends StatelessWidget {
  const PastVisitDetail({super.key, required this.pastVisit});
  final PastVisit pastVisit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "MR visit detail"),
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
          Container(
            height: Utils.deviceHeight,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10))
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: Utils.deviceHeight * 0.1,
                            width: Utils.deviceHeight * 0.1,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(
                                  begin: 0,
                                  end: int.parse(pastVisit.leadScore) / 100),
                              duration: const Duration(seconds: 1),
                              builder: (context, value, _) =>
                                  CircularProgressIndicator(
                                strokeWidth: 10,
                                strokeCap: StrokeCap.round,
                                backgroundColor:
                                    HexColor("4AB97B").withOpacity(0.5),
                                color: HexColor("4AB97B"),
                                value: value,
                              ),
                            ),
                          ),
                          Text(
                            "${pastVisit.leadScore}%",
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      Text(
                        pastVisit.mrName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      SummaryCardTile(
                          title: "Drugs Prescribed",
                          value: pastVisit.drugsPrescribed.substring(
                              1, pastVisit.drugsPrescribed.length - 1)),
                      const SizedBox(height: 12),
                      SummaryCardTile(
                          title: "Queries Encountered",
                          value: pastVisit.queriesEncountered),
                      const SizedBox(height: 12),
                      SummaryCardTile(
                          title: "Lead Suggestion",
                          value: pastVisit.leadSuggestion),
                      const SizedBox(height: 12),
                      SummaryCardTile(
                          title: "Feedback", value: pastVisit.additionalNotes),
                      const SizedBox(height: 12),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
