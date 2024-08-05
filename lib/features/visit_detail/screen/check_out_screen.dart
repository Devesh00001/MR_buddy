import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/features/visit_detail/widgets/visit_text_field.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../../widgets/custome_appbar.dart';
import '../../weekly plan/model/visit.dart';
import '../../weekly plan/widgets/custom_dropdown.dart';
import '../provider/visitdetail_provider.dart';
import '../widgets/visit_status.dart';
import 'success_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key, required this.visit});
  final Visit visit;

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Provider.of<VisitDetailProvider>(context, listen: false)
            .resetProvider();
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: "Visit Detail"),
        body: Consumer<VisitDetailProvider>(
            builder: (context, visitDetailProvider, child) {
          visitDetailProvider.getMedicineName();
          return Container(
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
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    VisitStatus(
                        visitStatus: widget.visit.status,
                        visitDate: widget.visit.date),
                    const SizedBox(height: 20),
                    VisitTextField(
                      hintText: "Location",
                      value: visitDetailProvider.getLocation(),
                      validateFunction: visitDetailProvider.validateInput,
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Physical visit",
                      setFunction: visitDetailProvider.setPhysicalVisit,
                      validateFunction: visitDetailProvider.validateInput,
                      isRequired: false,
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Call Support",
                      setFunction: visitDetailProvider.setCallSupport,
                      validateFunction: visitDetailProvider.validateInput,
                      isRequired: false,
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Message Support",
                      setFunction: visitDetailProvider.setMessageSupport,
                      validateFunction: visitDetailProvider.validateInput,
                      isRequired: false,
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Drugs Prescribed",
                      setFunction: visitDetailProvider.setDrugsPrescribed,
                      validateFunction: visitDetailProvider.validateInput,
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Queries Encountered",
                      setFunction: visitDetailProvider.setQuerieEncountered,
                      validateFunction: visitDetailProvider.validateInput,
                    ),
                    const SizedBox(height: 10),
                    VisitTextField(
                      hintText: "Additional Notes/Feedback",
                      setFunction: visitDetailProvider.setAdditionalNotes,
                      validateFunction: visitDetailProvider.validateInput,
                    ),
                    const SizedBox(height: 10),
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
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          bool status = await visitDetailProvider
                              .uploadData(widget.visit);
                          if (status) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const SuccessScreen()));
                          }
                        }
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) =>
                        //         CheckOutScreen(visit: widget.visit)));
                      },
                      child: Container(
                          width: Utils.deviceWidth * 0.4,
                          decoration: BoxDecoration(
                              color: HexColor("2F52AC"),
                              borderRadius: BorderRadius.circular(5)),
                          padding: const EdgeInsets.all(10),
                          child: const Center(
                            child: Text(
                              "CHECK OUT",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
