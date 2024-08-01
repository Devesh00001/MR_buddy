import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/dashboard_provider.dart';

class DateTile extends StatelessWidget {
  const DateTile({super.key, required this.date});
  final DateTime date;
  String formatDate(DateTime _date) {
    String formattedDate = DateFormat('dd-MM').format(_date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
      return Row(
        children: [
          Text(
            "From : ${formatDate(date)}",
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(width: 5),
          InkWell(
            onTap: () {
              dashboardProvider.selectDate(context);
            },
            child: const Icon(
              Icons.calendar_month,
              size: 16,
              color: Colors.white,
            ),
          ),
        ],
      );
    });
  }
}