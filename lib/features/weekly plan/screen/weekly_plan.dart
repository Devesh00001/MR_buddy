import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';
import '../../../widgets/custome_appbar.dart';
import '../widgets/custom_form_field.dart';
import '../provider/weekly_plan_provider.dart';
import '../widgets/custom_dropdown.dart';

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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        Provider.of<WeeklyProviderPlan>(context, listen: false).resetProivder();
      },
      child: Consumer<WeeklyProviderPlan>(
          builder: (context, weeklyProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(title: "Create Visit"),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                  activeColor: const Color(0xff85A389),
                  dayProps: const EasyDayProps(
                    todayHighlightStyle: TodayHighlightStyle.withBackground,
                    todayHighlightColor: Color(0xffE1ECC8),
                  ),
                ),
                const SizedBox(height: 20),
                dayForm(weeklyProvider.focusDate)
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget dayForm(DateTime date) {
    bool lastDayOfWeek() {
      final provider = Provider.of<WeeklyProviderPlan>(context, listen: false);
      if (DateFormat('dd/MM/yyyy').format(provider.focusDate) ==
          DateFormat('dd/MM/yyyy').format(provider.friday)) {
        return true;
      } else {
        return false;
      }
    }

    final _formKey = GlobalKey<FormState>();

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
                  height: Utils.deviceHeight * 0.55,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdown(
                            selectedValue: weeklyProvider.clientType,
                            hintText: "Client type",
                            placeHolder: "Select client type",
                            values: weeklyProvider.typeOfClient,
                            setFunction: weeklyProvider.setClientType),
                        const SizedBox(height: 10),
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
                                  setFunction: weeklyProvider.setClient),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                        CustomDropdown(
                            selectedValue: weeklyProvider.placeType,
                            hintText: "Select Place",
                            placeHolder: "Select place type",
                            values: weeklyProvider.typeOfPlace,
                            setFunction: weeklyProvider.setPlaceType),
                        const SizedBox(height: 10),
                        Visibility(
                            visible: weeklyProvider.clientType == "New Client",
                            child: const Column(
                              children: [
                                CustomFormField(hintText: "Name"),
                                SizedBox(height: 10),
                              ],
                            )),
                        const CustomFormField(hintText: "Address"),
                        const SizedBox(height: 10),
                        const CustomFormField(hintText: "Visit Purpose/Plan"),
                        const SizedBox(height: 10),
                        const CustomFormField(hintText: "Contact Point/Doctor"),
                        const SizedBox(height: 10),
                        CustomFormField(
                          hintText: "Date",
                          value: DateFormat('dd/MM/yyyy')
                              .format(weeklyProvider.focusDate),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Container(
                            height: Utils.deviceHeight * 0.12,
                            width: Utils.deviceWidth * 0.8,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 12,
                                      offset: Offset(2, 2))
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Upload any document",
                                  style: TextStyle(
                                      color:
                                          HexColor("1F1F1F").withOpacity(0.5)),
                                ),
                                Container(
                                  width: Utils.deviceWidth * 0.25,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: HexColor("3055B2")),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: TextButton(
                                    onPressed: () async {
                                      var picked =
                                          await FilePicker.platform.pickFiles();

                                      if (picked != null) {
                                        print(picked.files.first.name);
                                      }
                                    },
                                    child: Text(
                                      "Upload +",
                                      style:
                                          TextStyle(color: HexColor("3055B2")),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        weeklyProvider.uploadData('Devesh');
                      }
                    },
                    child: Text(
                      lastDayOfWeek() ? 'Submit' : "Submit & Next",
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
