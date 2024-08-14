import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../weekly plan/model/visit.dart';
import '../provider/visitdetail_provider.dart';
import 'visit_status.dart';
import 'visit_text_field.dart';
import '../screen/visit_detail.dart';

class VisitInputs extends StatelessWidget {
  const VisitInputs({super.key, required this.visit});
  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitDetailProvider>(
        builder: (context, visitDetailProvider, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            VisitStatus(visitStatus: visit.status, visitDate: visit.date),
            const SizedBox(height: 20),
            VisitTextField(
              hintText: "Location",
              value: visitDetailProvider.getLocation(),
              validateFunction: visitDetailProvider.validateInput,
              readOnly: true,
            ),
            const SizedBox(height: 10),
            Form(
              key: formKeys[visitDetailProvider.getCurrectStep()],
              child: Column(
                children: [
                  VisitTextField(
                    hintText: "Queries Encountered",
                    setFunction: visitDetailProvider.setQuerieEncountered,
                    validateFunction: visitDetailProvider.validateInput,
                    size: 150,
                    textFieldColor: HexColor("D1E9F6").withOpacity(0.6),
                    value: visitDetailProvider.queriesEncountered ?? '',
                  ),
                  const SizedBox(height: 10),
                  VisitTextField(
                    hintText: "Additional Notes/Feedback",
                    setFunction: visitDetailProvider.setAdditionalNotes,
                    value: visitDetailProvider.additionalNotes ?? "",
                    validateFunction: (value) {},
                    size: 150,
                    textFieldColor: HexColor("D1E9F6").withOpacity(0.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
