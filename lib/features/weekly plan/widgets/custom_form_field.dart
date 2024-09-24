import 'package:flutter/material.dart';
import 'package:mr_buddy/utils.dart';
import 'package:provider/provider.dart';

import '../provider/weekly_plan_provider.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField(
      {super.key,
      required this.hintText,
      this.value = "",
      this.size = 60,
      this.maxLine});
  final String hintText;
  final String value;
  final double size;
  final int? maxLine;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.value.isNotEmpty ? _controller.text = widget.value : null;
    _controller.addListener(updateValue);
  }

  void updateValue() {
    final weeklyProvider =
        Provider.of<WeeklyProviderPlan>(context, listen: false);
    if (widget.hintText == "Address") {
      weeklyProvider.setAddress(_controller.text);
    } else if (widget.hintText == "Visit Purpose/Plan") {
      weeklyProvider.setPurpose(_controller.text);
    } else if (widget.hintText == "Point of Contact/Doctor") {
      weeklyProvider.setContactPoint(_controller.text);
    } else if (widget.hintText == "Date") {
      weeklyProvider.setDate(_controller.text);
    } else if (widget.hintText == 'Name') {
      weeklyProvider.setClientName(_controller.text);
    } else if (widget.hintText == 'Specialization') {
      weeklyProvider.setSpecialization(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(updateValue);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weeklyProvider =
        Provider.of<WeeklyProviderPlan>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText,
          style: TextStyle(
              color: HexColor("1F1F1F").withOpacity(0.5),
              fontSize: Utils.isTab ? 18 : 14),
        ),
        SizedBox(
          height: widget.size,
          child: TextFormField(
            maxLines: widget.maxLine ?? widget.size ~/ 25,
            controller: _controller,
            readOnly: widget.value != "" ? true : false,
            decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.all(10),
                errorMaxLines: 1,
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: HexColor("1F1F1F").withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: HexColor("1F1F1F"))),
                labelStyle: TextStyle(color: HexColor("1F1F1F"))),
            validator: (value) {
              return weeklyProvider.validateInput(value);
            },
          ),
        ),
      ],
    );
  }
}
