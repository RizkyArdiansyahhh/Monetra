import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldCreateAccountWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool? obsureText;
  final String hintText;
  final bool touch;
  final String? Function(String) validate;
  final ValueChanged<String?>? onChanged;
  const TextFieldCreateAccountWidget(
      {super.key,
      required this.controller,
      this.obsureText,
      required this.hintText,
      required this.touch,
      required this.validate,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.poppins(
        fontSize: 14,
      ),
      controller: controller,
      obscureText: obsureText ?? false,
      cursorColor: Color(0xff0146A5),
      decoration: InputDecoration(
        hintText: hintText,
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red.shade200,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff0146A5)),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red.shade200),
        ),
        errorText: touch ? validate(controller.text) : null,
      ),
      onChanged: onChanged,
    );
  }
}
