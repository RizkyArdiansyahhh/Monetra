import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monetra/ui/widgets/text_button_widget.dart';

void showDialogAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      title: Center(
        child: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      actions: [
        TextButtonWidget(
          color: Color(0xff0146A5),
          text: "OK",
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}
