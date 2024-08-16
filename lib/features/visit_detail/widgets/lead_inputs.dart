import 'package:flutter/material.dart';
import 'package:mr_buddy/features/weekly%20plan/model/visit.dart';
import 'package:provider/provider.dart';

import '../../weekly plan/widgets/custom_dropdown.dart';
import '../provider/visitdetail_provider.dart';
import 'visit_status.dart';
import 'visit_text_field.dart';
import '../screen/visit_detail.dart';

class LeadInputs extends StatelessWidget {
  const LeadInputs({super.key, required this.visit});
  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return Consumer<VisitDetailProvider>(
        builder: (context, visitDetailProvider, child) {
      return Column(
        children: [
         VisitStatus(
                visit: visit),
          const SizedBox(height: 20),
          VisitTextField(
            hintText: "Location",
            value: visitDetailProvider.getLocation(),
            validateFunction: visitDetailProvider.validateInput,
          ),
          const SizedBox(height: 10),
          Form(
             key: formKeys[visitDetailProvider.getCurrectStep()],
            child: Column(
              children: [
                CustomDropdown(
                  hintText: "Lead score",
                  placeHolder: "Please select lead score",
                  values: visitDetailProvider.scoreList,
                  setFunction: visitDetailProvider.setLeadScore,
                  selectedValue: visitDetailProvider.getLeadScore(),
                  validateFunction: visitDetailProvider.validateInput,
                ),
                const SizedBox(height: 10),
                VisitTextField(
                  hintText: "Lead Suggestion",
                  setFunction: visitDetailProvider.setLeadSuggestion,
                  validateFunction: visitDetailProvider.validateInput,
                  size: 150,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
