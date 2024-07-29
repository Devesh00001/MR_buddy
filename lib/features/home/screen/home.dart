import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:mr_buddy/features/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../weekly plan/widgets/custom_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

DateTime _focusDate = DateTime.now();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int mondayOffset = now.weekday - DateTime.monday;
    DateTime monday = now.subtract(Duration(days: mondayOffset));
    int sundayOffset = DateTime.sunday - now.weekday;
    DateTime friday = now.add(Duration(days: sundayOffset));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text(
            "MR Buddy",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff2A357E)),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            GradientText("Create Your Weekly Plan",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                colors: const [
                  Color(0xff2a357e),
                  Color(0xff00ae4d),
                  Color(0xff00ae4d)
                ]),
            const SizedBox(height: 20),
            EasyInfiniteDateTimeLine(
              showTimelineHeader: false,
              firstDate: monday,
              focusDate: _focusDate,
              lastDate: friday,
              onDateChange: (selectedDate) {
                setState(() {
                  _focusDate = selectedDate;
                });
              },
              activeColor: const Color(0xff85A389),
              dayProps: const EasyDayProps(
                todayHighlightStyle: TodayHighlightStyle.withBackground,
                todayHighlightColor: Color(0xffE1ECC8),
              ),
            ),
            const SizedBox(height: 20),
            dayForm(_focusDate)
          ],
        ),
      ),
    );
  }

  Widget dayForm(DateTime date) {
    final _formKey = GlobalKey<FormState>();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.grey[200],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Form for ${date.day}/${date.month}/${date.year}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Form(
            key: _formKey,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomFormField(hintText: "Place name"),
                SizedBox(height: 20),
                CustomFormField(hintText: "Address"),
                SizedBox(height: 20),
                CustomFormField(hintText: "Description"),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  homeProvider.uploadData();
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
