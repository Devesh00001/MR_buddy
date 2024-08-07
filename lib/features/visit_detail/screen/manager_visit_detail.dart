import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/features/mr/widget/user_info_card.dart';
import 'package:mr_buddy/features/welcome/model/user.dart';
import 'package:mr_buddy/utils.dart';

import '../../../widgets/custom_appbar.dart';
import '../../weekly plan/model/visit.dart';
import '../widgets/visit_text_field.dart';

class ManagerVisitDetail extends StatefulWidget {
  const ManagerVisitDetail(
      {super.key, required this.user, required this.visit});
  final User user;
  final Visit visit;

  @override
  State<ManagerVisitDetail> createState() => _ManagerVisitDetailState();
}

class _ManagerVisitDetailState extends State<ManagerVisitDetail> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Visit Detail"),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: Utils.deviceWidth,
            minHeight: Utils.deviceHeight * 0.87,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                UserInfoCard(user: widget.user),
                ClientInfoCard(visit: widget.visit),
                VisitPurposeCard(visit: widget.visit),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 50,
                            offset: const Offset(10, 10))
                      ]),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        VisitTextField(
                          hintText: 'Add Comments',
                          validateFunction: (value) {
                            if (value == null || value.isEmpty) {
                              return "Plase enter Value";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 10),
                            decoration: BoxDecoration(
                                color: HexColor("2FBD6E"),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "Submit",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VisitPurposeCard extends StatelessWidget {
  const VisitPurposeCard({
    super.key,
    required this.visit,
  });

  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Client Info",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          VisitTextField(
            hintText: "Purpose",
            value: visit.purpose,
            size: 100,
            validateFunction: (value) {},
          )
        ],
      ),
    );
  }
}

class ClientInfoCard extends StatelessWidget {
  const ClientInfoCard({
    super.key,
    required this.visit,
  });

  final Visit visit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Client Info",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Wrap(
            direction: Axis.vertical,
            children: [
              UserDetailFiled(
                title: "Client Name",
                value: visit.clientName,
                fontSize: 16,
              ),
              const SizedBox(height: 10),
              UserDetailFiled(
                title: "Hospital",
                value: visit.address,
                fontSize: 16,
              ),
              const SizedBox(height: 10),
              UserDetailFiled(
                title: "Address",
                value: visit.address,
                fontSize: 16,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
