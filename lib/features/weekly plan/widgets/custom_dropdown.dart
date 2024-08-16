import 'package:flutter/material.dart';

import '../../../utils.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown(
      {super.key,
      required this.hintText,
      required this.placeHolder,
      required this.values,
      required this.setFunction,
      required this.selectedValue,
      required this.validateFunction,
      this.isRequired = true});
  final String hintText;
  final String placeHolder;
  final List<String> values;
  final String? selectedValue;
  final Function(String) setFunction;
  final Function(String?) validateFunction;
  final bool isRequired;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText,
          style: TextStyle(
              color: HexColor("1F1F1F").withOpacity(0.5),
              fontSize: Utils.isTab ? 18 : 14),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: HexColor("1F1F1F").withOpacity(0.5))),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              isCollapsed: true,
              border: InputBorder.none,
            ),
            icon: const Icon(Icons.keyboard_arrow_down_rounded),
            isExpanded: true,
            isDense: true,
            borderRadius: BorderRadius.circular(10),
            hint: Text(widget.placeHolder),
            value: widget.selectedValue,
            onChanged: (newValue) {
              widget.setFunction(newValue.toString());
            },
            items: widget.values.map((location) {
              return DropdownMenuItem(
                value: location,
                child: Text(location),
              );
            }).toList(),
            validator: (value) {
              return widget.isRequired ? widget.validateFunction(value) : null;
            },
          ),
        ),
      ],
    );
  }
}
