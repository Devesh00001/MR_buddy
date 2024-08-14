import 'package:flutter/material.dart';
import 'package:mr_buddy/utils.dart';

class VisitTextField extends StatefulWidget {
  const VisitTextField(
      {super.key,
      required this.hintText,
      this.value = "",
      this.size = 44,
      this.setFunction,
      required this.validateFunction,
      this.isRequired = true,
      this.visibility = false,
      this.textFieldColor = Colors.transparent,
      this.readOnly = false});
  final String hintText;
  final String value;
  final double size;
  final Function(String)? setFunction;
  final Function(String?) validateFunction;
  final bool isRequired;
  final bool visibility;
  final Color textFieldColor;
  final bool readOnly;

  @override
  State<VisitTextField> createState() => _VisitTextFieldState();
}

class _VisitTextFieldState extends State<VisitTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.value.isNotEmpty ? _controller.text = widget.value : null;
    _controller.addListener(updateValue);
  }

  void updateValue() {
    widget.setFunction!(_controller.text);
  }

  @override
  void dispose() {
    _controller.removeListener(updateValue);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText,
          style: TextStyle(color: HexColor("1F1F1F").withOpacity(0.5)),
        ),
        SizedBox(height: 5),
        Container(
          color: widget.textFieldColor,
          height: widget.size,
          child: TextFormField(
            cursorColor: Colors.black,
            maxLines: widget.visibility ? 1 : null,
            controller: _controller,
            readOnly: widget.readOnly,
            obscureText: widget.visibility,
            expands: widget.visibility ? false : true,
            decoration: InputDecoration(
                suffixIcon: widget.hintText == "Location"
                    ? Icon(
                        widget.value == "Match With Client Location"
                            ? Icons.check_circle_rounded
                            : Icons.clear_rounded,
                        color: widget.value == "Match With Client Location"
                            ? Colors.green
                            : Colors.red,
                        size: 30,
                      )
                    : null,
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
              return widget.isRequired ? widget.validateFunction(value) : null;
            },
          ),
        ),
      ],
    );
  }
}
