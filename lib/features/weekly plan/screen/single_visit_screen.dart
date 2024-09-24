import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/features/weekly%20plan/screen/success_screen_weeklplan.dart';
import 'package:provider/provider.dart';

import '../../../utils.dart';
import '../../../widgets/custom_appbar.dart';
import '../../welcome/model/user.dart';
import '../../welcome/provider/welcome_provider.dart';
import '../provider/weekly_plan_provider.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/custom_form_field.dart';

class SingleVisitScreen extends StatefulWidget {
  const SingleVisitScreen({super.key});

  @override
  State<SingleVisitScreen> createState() => _SingleVisitScreenState();
}

class _SingleVisitScreenState extends State<SingleVisitScreen> {
  TimeOfDay? selectDate;

  Future<void> selectTime(BuildContext context) async {
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
                    dayPeriodTextStyle: const TextStyle(fontSize: 20),
                    hourMinuteTextStyle: const TextStyle(fontSize: 50),
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
      final now = DateTime.now();
      final formattedTime = DateFormat('hh:mm a').format(DateTime(now.year,
          now.month, now.day, selectedTime.hour, selectedTime.minute));
      final provider = Provider.of<WeeklyProviderPlan>(context, listen: false);

      provider.setTime(formattedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
        final provider =
            Provider.of<WeeklyProviderPlan>(context, listen: false);
        provider.setFocusDate(selectedDate);
      }
    }

    Future<void> selectTime(BuildContext context) async {
      TimeOfDay? selectedTime = await showTimePicker(
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
        final now = DateTime.now();
        final formattedTime = DateFormat('hh:mm a').format(DateTime(now.year,
            now.month, now.day, selectedTime.hour, selectedTime.minute));
        final provider =
            Provider.of<WeeklyProviderPlan>(context, listen: false);

        provider.setTime(formattedTime);
      }
    }

    final formKey = GlobalKey<FormState>();
    User? user = Provider.of<WelcomeProvider>(context).user;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Provider.of<WeeklyProviderPlan>(context, listen: false).resetProvider();
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: "Create Visit"),
        body: Consumer<WeeklyProviderPlan>(
            builder: (context, weeklyProvider, child) {
          return Stack(
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
              Center(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  constraints: BoxConstraints(
                      maxHeight: Utils.deviceHeight,
                      maxWidth: Utils.isTab
                          ? Utils.deviceWidth * 0.7
                          : Utils.deviceWidth),
                  decoration: BoxDecoration(
                      color: HexColor("FFFFFF"),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ]),
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    // physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Form(
                          key: formKey,
                          child: SizedBox(
                            height: Utils.deviceHeight * 0.78,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                    visible: user!.role == 'Manager',
                                    child: CustomDropdown(
                                      selectedValue: weeklyProvider.mrName,
                                      hintText: "MR",
                                      placeHolder: "Select MR",
                                      values: user.mrNames,
                                      setFunction: weeklyProvider.setMRName,
                                      isRequired: true,
                                      validateFunction:
                                          weeklyProvider.validateInput,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomDropdown(
                                    selectedValue: weeklyProvider.clientType,
                                    hintText: "Health Associate type",
                                    placeHolder: "Select Health Associate type",
                                    values: weeklyProvider.typeOfClient,
                                    setFunction: weeklyProvider.setClientType,
                                    isRequired: true,
                                    validateFunction:
                                        weeklyProvider.validateInput,
                                  ),
                                  const SizedBox(height: 20),
                                  Visibility(
                                    visible: weeklyProvider.clientType ==
                                        "Existing Health Associate",
                                    child: Column(
                                      children: [
                                        CustomDropdown(
                                          selectedValue: weeklyProvider.client,
                                          hintText: "Health Associate",
                                          placeHolder:
                                              "Select Health Associate",
                                          values: weeklyProvider.clientList,
                                          setFunction: weeklyProvider.setClient,
                                          isRequired: weeklyProvider
                                                      .clientType ==
                                                  "Existing Health Associate"
                                              ? true
                                              : false,
                                          validateFunction:
                                              weeklyProvider.validateInput,
                                        ),
                                        const SizedBox(height: 20),
                                      ],
                                    ),
                                  ),
                                  CustomDropdown(
                                    selectedValue: weeklyProvider.placeType,
                                    hintText: "Clinic Type",
                                    placeHolder: "Select clinic type",
                                    values: weeklyProvider.typeOfPlace,
                                    isRequired: true,
                                    setFunction: weeklyProvider.setPlaceType,
                                    validateFunction:
                                        weeklyProvider.validateInput,
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Date",
                                            style: TextStyle(
                                                color: HexColor("1F1F1F")
                                                    .withOpacity(0.5),
                                                fontSize:
                                                    Utils.isTab ? 18 : 14),
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () => selectDate(context),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.black,
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    Text(
                                                      weeklyProvider
                                                                  .getFocusDate() !=
                                                              null
                                                          ? DateFormat(
                                                                  'dd-MM-yyyy')
                                                              .format(weeklyProvider
                                                                  .getFocusDate())
                                                          : "Select Date",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Time",
                                            style: TextStyle(
                                                color: HexColor("1F1F1F")
                                                    .withOpacity(0.5),
                                                fontSize:
                                                    Utils.isTab ? 18 : 14),
                                          ),
                                          Center(
                                            child: GestureDetector(
                                              onTap: () => selectTime(context),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                ),
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .access_time_filled_rounded,
                                                      color: Colors.black,
                                                    ),
                                                    const SizedBox(width: 8.0),
                                                    Text(
                                                      weeklyProvider
                                                                  .getTime() !=
                                                              null
                                                          ? "${weeklyProvider.getTime()}"
                                                          : "Select Time",
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Visibility(
                                      visible: weeklyProvider.clientType ==
                                          "New Health Associate",
                                      child: const Column(
                                        children: [
                                          CustomFormField(
                                              hintText: "Name", maxLine: 1),
                                          CustomFormField(
                                              hintText: "Specialization",
                                              maxLine: 1),
                                        ],
                                      )),
                                  const SizedBox(height: 10),
                                  const CustomFormField(
                                      hintText: "Address", maxLine: 1),
                                  const SizedBox(height: 10),
                                  CustomFormField(
                                      size: Utils.isTab ? 200 : 100,
                                      hintText: "Visit Purpose/Plan",
                                      maxLine: Utils.isTab ? 10 : 3),
                                  const SizedBox(height: 10),
                                  const CustomFormField(
                                      hintText: "Point of Contact/Doctor",
                                      maxLine: 1),
                                  const SizedBox(height: 10),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: Utils.deviceWidth,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: HexColor("39C075"),
                                  foregroundColor: Colors.white,
                                  elevation: 5,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  if (user.role == 'Manager') {
                                    bool status = await weeklyProvider
                                        .uploadWeekDayPlan();
                                    if (status == true) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SuccessScreenWeeklyPlan(
                                                    heading:
                                                        'Successfully Created Visit',
                                                    subHeading:
                                                        'Send notification to your MR about visit',
                                                  )));
                                    }
                                  } else {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SuccessScreenWeeklyPlan(
                                                  heading:
                                                      'Successfully Created Your Visit',
                                                  subHeading:
                                                      'Send notification to your manager to approve for weekly plan',
                                                )));
                                    weeklyProvider.uploadData(user.name,
                                        uploaded: true);
                                  }
                                }
                              },
                              child: const Text(
                                'Submit',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
