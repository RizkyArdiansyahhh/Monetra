import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextButtonWidget extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback? onPressed;
  const TextButtonWidget(
      {super.key, required this.color, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
