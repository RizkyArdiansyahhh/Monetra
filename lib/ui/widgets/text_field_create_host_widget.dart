import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldCreateHostWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText;
  final bool isTouch;
  final double? width;
  final String label;
  final String? Function(String) validate;
  final ValueChanged<String?> onChanged;
  const TextFieldCreateHostWidget(
      {super.key,
      this.width,
      required this.label,
      required this.controller,
      required this.hintText,
      required this.isTouch,
      required this.validate,
      this.keyboardType,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(
          width: width,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            cursorColor: Color(0xff0146A5),
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                  fontSize: 14, color: Colors.grey.shade400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Color(0xff0146A5),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.red.shade200),
              ),
              errorText: (isTouch) ? validate(controller.text) : null,
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
