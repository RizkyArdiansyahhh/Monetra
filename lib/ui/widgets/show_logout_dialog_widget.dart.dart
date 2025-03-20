import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monetra/bloc/user/user_bloc.dart';
import 'package:monetra/ui/widgets/text_button_widget.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      title: Center(
        child: Text(
          "Are you sure you want to log out?",
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      content: Text(
        "If you log out, you'll need to sign in again to access your account!",
        style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade700),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButtonWidget(
              color: Color(0xffFCBC05),
              text: "Cancel",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            BlocListener<UserBloc, UserState>(
              listener: (context, state) {
                if (state is UserUnauthenticated) {
                  log("unauthenticated");
                  context.goNamed("login");
                }
              },
              child: TextButtonWidget(
                color: Color(0xff0146A5),
                text: "Logout",
                onPressed: () {
                  context.read<UserBloc>().add(LogoutUser());
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ],
    ),
  );
}
