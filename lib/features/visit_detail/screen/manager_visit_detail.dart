import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mr_buddy/features/mr/widget/user_info_card.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_appbar.dart';

import '../../weekly plan/model/visit.dart';
import '../provider/visitdetail_provider.dart';
import '../widgets/visit_text_field.dart';
import 'summary_page.dart';

class ManagerVisitDetail extends StatefulWidget {
  const ManagerVisitDetail(
      {super.key, required this.user, required this.visit});
  final User user;
  final Visit visit;

  @override
  State<ManagerVisitDetail> createState() => _ManagerVisitDetailState();
}

class _ManagerVisitDetailState extends State<ManagerVisitDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            height: Utils.deviceHeight,
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Flexible(flex: 2, child: UserInfoCard(user: widget.user)),
                const SizedBox(height: 10),
                Flexible(flex: 5, child: ClientInfoCard(visit: widget.visit)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClientInfoCard extends StatelessWidget {
  const ClientInfoCard({super.key, required this.visit});

  final Visit visit;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Consumer<VisitDetailProvider>(
        builder: (context, visitDetailProvider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Client Info",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserDetailFiled(
                    icon: FontAwesomeIcons.userDoctor,
                    title: "Client Name",
                    value: visit.clientName,
                    fontSize: Utils.isTab ? 20 : 14,
                  ),
                  const Spacer(),
                  UserDetailFiled(
                    icon: FontAwesomeIcons.hospitalUser,
                    title: "Hospital",
                    value: visit.address,
                    fontSize: Utils.isTab ? 20 : 14,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
              const SizedBox(height: 10),
              UserDetailFiled(
                icon: Icons.location_on_rounded,
                title: "Address",
                value: visit.address,
                fontSize: Utils.isTab ? 20 : 14,
              ),
              const SizedBox(height: 10),
              SummaryCardTile(title: "Purpose", value: visit.purpose),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    VisitTextField(
                      hintText: 'Add Comments',
                      size: Utils.isTab ? 200 : 100,
                      setFunction: visitDetailProvider.setManagerComment,
                      validateFunction: (value) {
                        if (value == null || value.isEmpty) {
                          return "Plase enter Value";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          bool status =
                              await visitDetailProvider.addManagerComment(
                                  visit.mrName,
                                  visit.date,
                                  visit.startTime,
                                  visitDetailProvider.getManagerComment()!);
                          if (status) {
                            var snackBar = const SnackBar(
                                content: Text('Your Comment added'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            var snackBar = const SnackBar(
                                content: Text(
                                    'There is some problem in adding comment'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        decoration: BoxDecoration(
                            color: HexColor("2FBD6E"),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
