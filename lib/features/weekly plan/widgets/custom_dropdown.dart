import 'package:flutter/material.dart';

import '../../../utils.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.hintText,
      required this.placeHolder,
      required this.values,
      required this.setFunction,
      required this.selectedValue});
  final String hintText;
  final String placeHolder;
  final List<String> values;
  final String? selectedValue;
  final Function(String) setFunction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hintText,
          style: TextStyle(color: HexColor("1F1F1F").withOpacity(0.5)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: HexColor("1F1F1F").withOpacity(0.5))),
          child: DropdownButton(
            isExpanded: true,
            isDense: true,
            borderRadius: BorderRadius.circular(10),
            underline: const SizedBox(),
            hint: Text(placeHolder),
            value: selectedValue,
            onChanged: (newValue) {
              setFunction(newValue.toString());
            },
            items: values.map((location) {
              return DropdownMenuItem(
                value: location,
                child: Text(location),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}