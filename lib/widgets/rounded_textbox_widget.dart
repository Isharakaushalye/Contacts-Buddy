import '../style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedTextboxWidget extends StatefulWidget {
  TextEditingController controller;
  TextInputType keyboardType;
  bool enabled;
  int minLine;
  int maxLine;
  String labelText;
  double verticalMargin;
  String? Function(dynamic)? validator;
  bool isPassword;
  Widget? prefixIcon;
  Function(String)? onChanged;

  RoundedTextboxWidget({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.minLine = 1,
    this.maxLine = 1,
    this.verticalMargin = 10,
    this.prefixIcon,
    required this.labelText,
    this.validator,
    this.isPassword = false,
    required this.onChanged,
  }) : super(key: key);

  static InputBorder enabledBorder = const OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xffDFDFDF),
    ),
  );

  static InputBorder errorBorder = const OutlineInputBorder(borderSide: BorderSide(color: Colors.red));

  @override
  State<RoundedTextboxWidget> createState() => _RoundedTextboxWidgetState();
}

class _RoundedTextboxWidgetState extends State<RoundedTextboxWidget> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 16.0),
        maxLines: widget.maxLine,
        minLines: widget.minLine,
        keyboardType: widget.keyboardType,
        autofocus: false,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: isVisible,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          border: InputBorder.none,
          hintText: widget.labelText,
          enabled: widget.enabled,
          fillColor: Colors.black12,
          hintStyle: hintStyle,
          contentPadding: const EdgeInsets.all(20),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}
