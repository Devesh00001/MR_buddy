import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../weekly plan/model/visit.dart';
import '../provider/visitdetail_provider.dart';
import 'visit_status.dart';
import '../screen/summary_page.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key, required this.visit});
  final Visit visit;

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VisitDetailProvider>(
        builder: (context, visitDetailProvider, child) {
      // bool isTab = Utils.deviceWidth > 600 ? true : false;
      return SingleChildScrollView(
        child: Column(
          children: [
            VisitStatus(
                visitStatus: widget.visit.status, visitDate: widget.visit.date),
            const SizedBox(height: 20),
            Column(
              children: [
                SummaryCardTile(
                  title: "Client",
                  value: widget.visit.clientName,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Place Type",
                  value: widget.visit.placeType,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Address",
                  value: widget.visit.address,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Visit Purpose/Plan",
                  value: widget.visit.purpose,
                ),
                const SizedBox(height: 12),
                SummaryCardTile(
                  title: "Contact Point/Doctor",
                  value: widget.visit.contactPoint,
                ),
                const SizedBox(height: 12),
                 SummaryCardTile(
                  title: "Manager Comments",
                  value:
                      widget.visit.comments,
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
