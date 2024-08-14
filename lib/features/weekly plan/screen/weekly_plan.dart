import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
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
              "Do you want to create a new visit for today's date or the next date?"),
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
    double width = MediaQuery.sizeOf(context).width;
    bool bigScreen = width >= 600 ? true : false;
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
                            height: 70,
                            width: bigScreen ? 120 : 70,
                            todayHighlightStyle:
                                TodayHighlightStyle.withBackground,
                            todayHighlightColor: const Color(0xffE1ECC8),
                            inactiveDayStyle: DayStyle(
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
                          hintText: "Client type",
                          placeHolder: "Select client type",
                          values: weeklyProvider.typeOfClient,
                          setFunction: weeklyProvider.setClientType,
                          isRequired: true,
                          validateFunction: weeklyProvider.validateInput,
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible:
                              weeklyProvider.clientType == "Existing Client",
                          child: Column(
                            children: [
                              CustomDropdown(
                                selectedValue: weeklyProvider.client,
                                hintText: "Client",
                                placeHolder: "Select client",
                                values: weeklyProvider.clientList,
                                setFunction: weeklyProvider.setClient,
                                isRequired: weeklyProvider.clientType ==
                                        "Existing Client"
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
                        Visibility(
                            visible: weeklyProvider.clientType == "New Client",
                            child: const Column(
                              children: [
                                CustomFormField(hintText: "Name", maxLine: 1),
                                SizedBox(height: 10),
                              ],
                            )),
                        const CustomFormField(hintText: "Address", maxLine: 1),
                        const SizedBox(height: 10),
                        const CustomFormField(
                            hintText: "Visit Purpose/Plan", maxLine: 1),
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
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
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
                            weeklyProvider.uploadData('Devesh');
                          } else {
                            weeklyProvider.addDataInSingleDayVisit(user.name,
                                reset: true);
                          }
                        }
                      }
                    },
                    child: Text(
                      user.role == 'Manager'
                          ? 'Submit'
                          : lastDayOfWeek()
                              ? 'Submit'
                              : "Submit & Next",
                      style: const TextStyle(fontSize: 16),
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
