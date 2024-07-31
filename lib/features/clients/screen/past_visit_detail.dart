import 'package:flutter/material.dart';
import '../../../utils.dart';
import '../../../widgets/custome_appbar.dart';
import '../../visit_detail/model/past_visit.dart';
import '../../visit_detail/widgets/visit_text_field.dart';

class PastVisitDetail extends StatelessWidget {
  const PastVisitDetail({super.key, required this.pastVisit});
  final PastVisit pastVisit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Client Detail"),
      body: Container(
        height: Utils.deviceHeight * 0.75,
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
        child: Column(
          children: [
            VisitTextField(
              hintText: "MR Name",
              value: pastVisit.mrName,
              validateFunction: (value) {},
            ),
            const SizedBox(height: 10),
            VisitTextField(
              hintText: "Date",
              value: pastVisit.date,
              validateFunction: (value) {},
            ),
            const SizedBox(height: 10),
            VisitTextField(
              hintText: "Drugs Prescribed",
              value: pastVisit.drugsPrescribed,
              validateFunction: (value) {},
            ),
            const SizedBox(height: 10),
            VisitTextField(
              hintText: "Queries Encountered",
              value: pastVisit.queriesEncountered,
              validateFunction: (value) {},
            ),
            const SizedBox(height: 10),
            VisitTextField(
              hintText: "Lead Score",
              value: pastVisit.leadScore,
              validateFunction: (value) {},
            ),
            const SizedBox(height: 10),
            VisitTextField(
              hintText: "Lead suggetion",
              value: pastVisit.leadScore,
              validateFunction: (value) {},
            ),
            const SizedBox(height: 10),
            VisitTextField(
              size: 100,
              hintText: "Feedback",
              value: pastVisit.additionalNotes,
              validateFunction: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
