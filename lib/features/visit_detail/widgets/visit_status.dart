import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';
import 'package:mr_buddy/features/weekly%20plan/model/visit.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';

import '../../weekly plan/screen/success_screen_weeklplan.dart';
import '../provider/visitdetail_provider.dart';

class VisitStatus extends StatelessWidget {
  const VisitStatus({super.key, required this.visit});

  final Visit visit;

  Future<bool?> showSubmitPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: const Text("Do you want to cancel this visit"),
          content: const Text("Press yes if you want cancel this visit"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "No",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> showPastVisitPopup(
      BuildContext context, PastVisit pastVisit) async {
    return await showDialog(
      context: context,
      // barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: Text("Last visit ${pastVisit.clientName} details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: 'Date: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  TextSpan(
                      text: pastVisit.date,
                      style: const TextStyle(color: Colors.black))
                ]),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: 'Queries Encountered: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  TextSpan(
                      text: pastVisit.queriesEncountered,
                      style: const TextStyle(color: Colors.black))
                ]),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: 'Lead Suggestion: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  TextSpan(
                      text: pastVisit.leadSuggestion,
                      style: const TextStyle(color: Colors.black))
                ]),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitDetailProvider>(
        builder: (context, visitDetailProvider, child) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    visit.status == 'Approve'
                        ? Icons.check_circle_outline_outlined
                        : FontAwesomeIcons.circleExclamation,
                    size: 40,
                    color: visit.status == 'Approve'
                        ? Colors.green
                        : Colors.yellow,
                  )),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      Text(
                        visit.status == 'Approve'
                            ? "Approve"
                            : "Pending for approval",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ))
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.mapLocationDot,
                  color: HexColor("3572EF"),
                ),
                onPressed: () async {
                  PastVisit? pastVisit =
                      await visitDetailProvider.getPastVisitOfVisit(visit);
                  if (pastVisit != null) {
                    showPastVisitPopup(context, pastVisit);
                  }
                },
              ),
              IconButton(
                onPressed: () async {
                  bool? status = await showSubmitPopup(context);
                  if (status == true) {
                    bool goToSuccessScreen =
                        await visitDetailProvider.deleteVisit(visit);
                    if (goToSuccessScreen) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SuccessScreenWeeklyPlan(
                                heading: 'Successfully Cancel Your Visit',
                                subHeading: 'Send notification to your manager',
                              )));
                    }
                  }
                },
                icon: const Icon(Icons.delete),
                color: Colors.redAccent,
              ),
            ],
          ),
        ],
      );
    });
  }
}
