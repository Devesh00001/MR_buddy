import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/features/visit_detail/model/past_visit.dart';
import 'package:mr_buddy/features/visit_detail/widgets/visit_text_field.dart';
import 'package:mr_buddy/features/weekly%20plan/model/visit.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../../home/screen/home_screen.dart';
import '../provider/visitdetail_provider.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage(
      {super.key, required this.visit, required this.showNewVisitBtn});
  final Visit visit;
  final bool showNewVisitBtn;

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDialog<DateTime>(
      context: context,
      builder: (context) {
        DateTime tempSelectedDate = DateTime.now();

        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: Utils.deviceWidth * 0.67,
              height: Utils.deviceHeight * 0.46,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        inputDecorationTheme: const InputDecorationTheme(
                          contentPadding: EdgeInsets.zero,
                        ),
                        dialogBackgroundColor: Colors.white,
                        textTheme: const TextTheme(
                          headlineLarge: TextStyle(fontSize: 20),
                          bodyLarge: TextStyle(fontSize: 12),
                        ),
                        dialogTheme: const DialogTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        colorScheme: ColorScheme.light(
                          primary: HexColor("96C9F4"),
                          onPrimary: Colors.black,
                          onSurface: Colors.black,
                          surfaceTint: Colors.transparent,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: HexColor("4AB97B"),
                          ),
                        ),
                      ),
                      child: CalendarDatePicker(
                        initialDate: tempSelectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                        onDateChanged: (date) {
                          tempSelectedDate = date;
                        },
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(tempSelectedDate);
                    },
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            HexColor("4AB97B"))),
                    child: const Text(
                      "Submit",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.inputOnly,
        builder: (context, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  timePickerTheme: TimePickerThemeData(
                      dayPeriodColor: HexColor("2F52AC"),
                      dayPeriodTextStyle: const TextStyle(fontSize: 16),
                      hourMinuteTextStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  colorScheme: ColorScheme.light(
                      primary: HexColor("96C9F4"),
                      onPrimary: Colors.black,
                      onSurface: Colors.black,
                      surfaceTint: Colors.transparent),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: HexColor("4AB97B"),
                    ),
                  ),
                ),
                child: child!,
              ),
            ],
          );
        },
      );

      if (selectedTime != null) {
        final DateTime finalDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        final String formattedDateTime =
            DateFormat('hh:mm a dd:MM:yyyy').format(finalDateTime);
        log("Selected DateTime: $formattedDateTime");
        // ignore: use_build_context_synchronously
        Provider.of<VisitDetailProvider>(context, listen: false)
            .setSelectDateAndTime(formattedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Home()),
              (r) => false);
          Provider.of<VisitDetailProvider>(context, listen: false)
              .resetProvider();
        });
      },
      child: Scaffold(
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
            SizedBox(
              height: Utils.deviceHeight,
              child: Column(
                children: [
                  Expanded(
                    flex: 12,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 10))
                          ]),
                      child: FutureBuilder<PastVisit?>(
                        future: Provider.of<VisitDetailProvider>(context,
                                listen: false)
                            .getPastVisit(widget.visit),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data == null) {
                            return const Center(
                                child: Text('No data available'));
                          }

                          final pastVisit = snapshot.data!;

                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          height: Utils.deviceHeight * 0.1,
                                          width: Utils.deviceHeight * 0.1,
                                          child: TweenAnimationBuilder<double>(
                                            tween: Tween(
                                                begin: 0,
                                                end: int.parse(
                                                        pastVisit.leadScore) /
                                                    100),
                                            duration:
                                                const Duration(seconds: 1),
                                            builder: (context, value, _) =>
                                                CircularProgressIndicator(
                                              strokeWidth: 10,
                                              strokeCap: StrokeCap.round,
                                              backgroundColor:
                                                  HexColor("4AB97B")
                                                      .withOpacity(0.5),
                                              color: HexColor("4AB97B"),
                                              value: value,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${pastVisit.leadScore}%",
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      pastVisit.mrName,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    SummaryCardTile(
                                        title: "Drugs Prescribed",
                                        value: pastVisit.drugsPrescribed
                                            .substring(
                                                1,
                                                pastVisit.drugsPrescribed
                                                        .length -
                                                    1)),
                                    const SizedBox(height: 12),
                                    SummaryCardTile(
                                        title: "Queries Encountered",
                                        value: pastVisit.queriesEncountered),
                                    const SizedBox(height: 12),
                                    SummaryCardTile(
                                        title: "Lead Suggestion",
                                        value: pastVisit.leadSuggestion),
                                    const SizedBox(height: 12),
                                    SummaryCardTile(
                                        title: "Feedback",
                                        value: pastVisit.additionalNotes),
                                    const SizedBox(height: 12),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.showNewVisitBtn,
                    child: Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const Home()),
                                    (r) => false);
                                Provider.of<VisitDetailProvider>(context,
                                        listen: false)
                                    .resetProvider();
                              });
                            },
                            child: Container(
                                width: Utils.deviceWidth * 0.35,
                                decoration: BoxDecoration(
                                    color: HexColor("00AE4D"),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: const Center(
                                  child: Text(
                                    'Home',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                )),
                          ),
                          InkWell(
                            onTap: () async {
                              final _formKey = GlobalKey<FormState>();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Consumer<VisitDetailProvider>(
                                        builder: (context, visitDetailProvider,
                                            child) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.white,
                                        surfaceTintColor: Colors.transparent,
                                        scrollable: true,
                                        title: Text(
                                          'Create Visit for ${widget.visit.clientName}',
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              children: <Widget>[
                                                VisitTextField(
                                                  hintText: 'Purpose/ Plan',
                                                  validateFunction:
                                                      visitDetailProvider
                                                          .validateInput,
                                                  size: 150,
                                                  setFunction:
                                                      visitDetailProvider
                                                          .setNewVisitPurpose,
                                                ),
                                                const SizedBox(height: 5),
                                                Center(
                                                  child: GestureDetector(
                                                    onTap: () =>
                                                        _selectDateTime(
                                                            context),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.grey),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4.0),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .calendar_today,
                                                            color: Colors.black,
                                                          ),
                                                          const SizedBox(
                                                              width: 8.0),
                                                          Text(
                                                            visitDetailProvider
                                                                .selctedDateAndTime,
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: !visitDetailProvider
                                                      .isUploaded,
                                                  child: const Text(
                                                    "Error while creating Visit",
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              child: Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    color: HexColor("4AB97B")),
                                              ),
                                              onPressed: () {
                                                visitDetailProvider
                                                    .setSelectDateAndTime(
                                                        'Select Date and Time');
                                                Navigator.of(context).pop();
                                              }),
                                          TextButton(
                                              child: Text(
                                                "Submit",
                                                style: TextStyle(
                                                    color: HexColor("4AB97B")),
                                              ),
                                              onPressed: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  visitDetailProvider
                                                      .createVisitOfClient(
                                                          widget.visit);

                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                }
                                              })
                                        ],
                                      );
                                    });
                                  });
                            },
                            child: Container(
                                width: Utils.deviceWidth * 0.35,
                                decoration: BoxDecoration(
                                    color: HexColor("00AE4D"),
                                    borderRadius: BorderRadius.circular(5)),
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: const Center(
                                  child: Text(
                                    'Plan next visit',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SummaryCardTile extends StatelessWidget {
  const SummaryCardTile({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Utils.deviceWidth,
        constraints:
            BoxConstraints(maxHeight: Utils.deviceHeight * 0.3, minHeight: 50),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: HexColor("D1E9F6").withOpacity(0.6)),
        child: Wrap(
          direction: Axis.vertical,
          spacing: 5,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: Utils.deviceWidth * 0.75,
              child: Text(
                value,
                style: const TextStyle(overflow: TextOverflow.clip),
              ),
            )
          ],
        ));
  }
}