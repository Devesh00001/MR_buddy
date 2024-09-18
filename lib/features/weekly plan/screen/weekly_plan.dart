import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custom_appbar.dart';
import '../../welcome/model/user.dart';
import '../../welcome/provider/welcome_provider.dart';
import '../widgets/custom_form_field.dart';
import '../provider/weekly_plan_provider.dart';
import '../widgets/custom_dropdown.dart';
import 'success_screen_weeklplan.dart';

class WeeklyPlan extends StatefulWidget {
  const WeeklyPlan({super.key});

  @override
  State<WeeklyPlan> createState() => _WeeklyPlanState();
}

class _WeeklyPlanState extends State<WeeklyPlan> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool lastDayOfWeek() {
    final provider = Provider.of<WeeklyProviderPlan>(context, listen: false);
    if (DateFormat('dd-MM-yyyy').format(provider.focusDate) ==
        DateFormat('dd-MM-yyyy').format(provider.friday)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> _showPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: const Text("Create a New Visit"),
          content: const Text(
              "Do you want to create a new visit for today's date or the next date? If you want to create a visit for any other date, please click on the date tab above."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                "Today",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                lastDayOfWeek() ? 'Submit' : "Next Date",
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> showSubmitPopup(BuildContext context) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          title: const Text("Submit your added visits"),
          content:
              const Text("Press ok if you wanted to submit your added visit"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Ok',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Provider.of<WeeklyProviderPlan>(context, listen: false).resetProvider();
      },
      child: Consumer<WeeklyProviderPlan>(
          builder: (context, weeklyProvider, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: "Weekly Plan"),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      EasyInfiniteDateTimeLine(
                        showTimelineHeader: false,
                        firstDate: weeklyProvider.monday,
                        focusDate: weeklyProvider.focusDate,
                        lastDate: weeklyProvider.friday,
                        onDateChange: (selectedDate) {
                          weeklyProvider.setFocusDate(selectedDate);
                        },
                        activeColor: HexColor("1A5319"),
                        dayProps: EasyDayProps(
                            height: Utils.isTab ? 70 : 70,
                            width: Utils.isTab ? Utils.deviceWidth / 5 : 70,
                            todayHighlightStyle:
                                TodayHighlightStyle.withBackground,
                            todayHighlightColor: const Color(0xffE1ECC8),
                            activeDayStyle: DayStyle(
                              dayStrStyle: TextStyle(
                                  fontSize: Utils.isTab ? 20 : 12,
                                  color: Colors.white),
                              monthStrStyle: TextStyle(
                                  fontSize: Utils.isTab ? 20 : 12,
                                  color: Colors.white),
                            ),
                            inactiveDayStyle: DayStyle(
                                dayStrStyle:
                                    TextStyle(fontSize: Utils.isTab ? 20 : 12),
                                monthStrStyle:
                                    TextStyle(fontSize: Utils.isTab ? 20 : 12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)))),
                      ),
                      const SizedBox(height: 20),
                      dayForm(weeklyProvider.focusDate)
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

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

  Widget dayForm(DateTime date) {
    bool lastDayOfWeek() {
      final provider = Provider.of<WeeklyProviderPlan>(context, listen: false);
      if (DateFormat('dd-MM-yyyy').format(provider.focusDate) ==
          DateFormat('dd-MM-yyyy').format(provider.friday)) {
        return true;
      } else {
        return false;
      }
    }

    final _formKey = GlobalKey<FormState>();
    User? user = Provider.of<WelcomeProvider>(context).user;
    return Consumer<WeeklyProviderPlan>(
        builder: (context, weeklyProvider, child) {
      return Container(
        constraints: BoxConstraints(
            maxWidth:
                Utils.isTab ? Utils.deviceWidth * 0.7 : Utils.deviceWidth),
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
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Create Visit',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Form(
                key: _formKey,
                child: SizedBox(
                  height: Utils.deviceHeight * 0.6,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            validateFunction: weeklyProvider.validateInput,
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
                          validateFunction: weeklyProvider.validateInput,
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
                                placeHolder: "Select Health Associate",
                                values: weeklyProvider.clientList,
                                setFunction: weeklyProvider.setClient,
                                isRequired: weeklyProvider.clientType ==
                                        "Existing Health Associate"
                                    ? true
                                    : false,
                                validateFunction: weeklyProvider.validateInput,
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
                          validateFunction: weeklyProvider.validateInput,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Time",
                          style: TextStyle(
                              color: HexColor("1F1F1F").withOpacity(0.5),
                              fontSize: Utils.isTab ? 18 : 14),
                        ),
                        Center(
                          child: GestureDetector(
                            onTap: () => selectTime(context),
                            child: Container(
                              padding: const EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    weeklyProvider.time ?? 'Select Time',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Visibility(
                            visible: weeklyProvider.clientType ==
                                "New Health Associate",
                            child: const Column(
                              children: [
                                CustomFormField(hintText: "Name", maxLine: 1),
                                CustomFormField(
                                    hintText: "Specialization", maxLine: 1),
                              ],
                            )),
                        const SizedBox(height: 10),
                        const CustomFormField(hintText: "Address", maxLine: 1),
                        const SizedBox(height: 10),
                        CustomFormField(
                            size: Utils.isTab ? 200 : 100,
                            hintText: "Visit Purpose/Plan",
                            maxLine: Utils.isTab ? 10 : 3),
                        const SizedBox(height: 10),
                        const CustomFormField(
                            hintText: "Point of Contact/Doctor", maxLine: 1),
                        const SizedBox(height: 10),
                        CustomFormField(
                          hintText: "Date",
                          maxLine: 1,
                          value: DateFormat('dd-MM-yyyy')
                              .format(weeklyProvider.focusDate),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Visibility(
                visible: user.role != 'Manager',
                child: Center(
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
                        if (_formKey.currentState!.validate()) {
                          bool? newVisitToday = await _showPopup(context);
                          if (newVisitToday == false) {
                            if (lastDayOfWeek()) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const SuccessScreenWeeklyPlan(
                                        heading:
                                            'Successfully Created Your Visit',
                                        subHeading:
                                            'Send notification to your manager to approve for weekly plan',
                                      )));
                            }
                            weeklyProvider.uploadData(user.name);
                          } else {
                            weeklyProvider.addDataInSingleDayVisit(user.name,
                                reset: true);
                          }
                        }
                      },
                      child: const Text(
                        "Add Visit",
                        style: TextStyle(fontSize: 16),
                      ),
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
                      if (_formKey.currentState!.validate()) {
                        if (user.role == 'Manager') {
                          bool status =
                              await weeklyProvider.uploadWeekDayPlan();
                          if (status == true) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const SuccessScreenWeeklyPlan(
                                      heading: 'Successfully Created Visit',
                                      subHeading:
                                          'Send notification to your MR about visit',
                                    )));
                          }
                        } else {
                          bool? status = await showSubmitPopup(context);
                          if (status == true) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const SuccessScreenWeeklyPlan(
                                      heading:
                                          'Successfully Created Your Visit',
                                      subHeading:
                                          'Send notification to your manager to approve for weekly plan',
                                    )));
                            weeklyProvider.uploadData(user.name,
                                uploaded: true);
                          } else {}
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
      );
    });
  
  }
}
