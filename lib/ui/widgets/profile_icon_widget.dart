import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileIconWidget extends StatelessWidget {
  final IconData icon;
  final int amount;
  final String title;

  const ProfileIconWidget(
      {super.key,
      required this.icon,
      required this.title,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff1778FB),
          ),
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
        Text(
          "$amount $title",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
