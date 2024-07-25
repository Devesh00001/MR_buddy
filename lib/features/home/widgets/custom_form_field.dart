import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({super.key, required this.hintText});
  final String hintText;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(updateValue);
  }

  void updateValue() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (widget.hintText == "Place name") {
      homeProvider.setPlaceName(_controller.text);
    } else if (widget.hintText == "Address") {
      homeProvider.setAddress(_controller.text);
    } else if (widget.hintText == "Description") {
      homeProvider.setDescription(_controller.text);
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
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: const EdgeInsets.all(10),
          errorMaxLines: 2,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 0.5)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)),
          labelText: widget.hintText,
          labelStyle: const TextStyle(color: Colors.black)),
      validator: (value) {
        return homeProvider.validateInput(value);
      },
    );
  }
}
