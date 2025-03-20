import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class NotifCardWidget extends StatelessWidget {
  final Color triggerSeverity;
  final String triggerCategory;
  // final String triggerTime;
  final String triggerMessage;
  final bool isRead;
  const NotifCardWidget(
      {super.key,
      required this.triggerSeverity,
      required this.triggerCategory,
      // required this.triggerTime,
      required this.triggerMessage,
      required this.isRead});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xffF4F7FF),
        border: Border.symmetric(
          horizontal: BorderSide(width: 1, color: Colors.grey.shade300),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration:
                  BoxDecoration(color: triggerSeverity, shape: BoxShape.circle),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(triggerCategory,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                        // Text(triggerTime,
                        //     style: GoogleFonts.poppins(
                        //       color: Colors.black,
                        //       fontWeight: FontWeight.w600,
                        //     ))
                      ]),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .65,
                    child: Text(
                      "$triggerMessage...",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color:
                              (isRead) ? Colors.grey.shade500 : Colors.black),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
