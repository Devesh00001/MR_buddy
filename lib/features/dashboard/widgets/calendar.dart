import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils.dart';
import '../provider/dashboard_provider.dart';

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
        builder: (context, dashboardProvider, child) {
      return Container(
          width: Utils.deviceWidth * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
              shape: SmoothRectangleBorder(
                  borderRadius:
                      SmoothBorderRadius(cornerRadius: 15, cornerSmoothing: 1)),
              color: Colors.white,
              shadows: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3))
              ]),
          child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              rowHeight: Utils.isTab ? 50 : 30,
              focusedDay: dashboardProvider.focusDate,
              headerVisible: false,
              daysOfWeekHeight: Utils.isTab ? 50 : 30,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontSize: Utils.isTab ? 20.0 : 12),
                weekendStyle: TextStyle(
                    fontSize: Utils.isTab ? 20.0 : 12,
                    color: Colors.grey.shade400),
              ),
              calendarStyle: CalendarStyle(
                  outsideTextStyle: TextStyle(
                      fontSize: Utils.isTab ? 20 : 12,
                      color: Colors.grey.shade400),
                  weekendTextStyle: TextStyle(
                      fontSize: Utils.isTab ? 20 : 12,
                      color: Colors.grey.shade400),
                  defaultTextStyle: TextStyle(fontSize: Utils.isTab ? 20 : 12),
                  disabledTextStyle: TextStyle(fontSize: Utils.isTab ? 20 : 12),
                  todayTextStyle: TextStyle(fontSize: Utils.isTab ? 20 : 12),
                  selectedTextStyle: TextStyle(
                      fontSize: Utils.isTab ? 20 : 12, color: Colors.white)),
              selectedDayPredicate: (day) {
                return isSameDay(dashboardProvider.selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(dashboardProvider.selectedDate, selectedDay)) {
                  dashboardProvider.setSelectedDate(selectedDay);
                  dashboardProvider.setFocusDate(focusedDay);
                }
              }));
    });
  }
}
