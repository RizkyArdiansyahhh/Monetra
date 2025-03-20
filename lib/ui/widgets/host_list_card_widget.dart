import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HostListCardWidget extends StatelessWidget {
  final String hostId;
  final String hostName;
  final String iPAddress;
  final VoidCallback onPressed;

  const HostListCardWidget({
    super.key,
    required this.hostId,
    required this.hostName,
    required this.iPAddress,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .9,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: .1,
              blurRadius: .9,
              offset: Offset(0, 1),
            )
          ]),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                color: Color(0xffFCBC05),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(MdiIcons.laptop, color: Color(0xff08103A), size: 50),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hostName,
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          iPAddress,
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        Text(
                          hostId,
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: onPressed,
                      // icon: Icon(
                      //   MdiIcons.pageNext,
                      //   color: Color(0xff0146A5),
                      //   size: 30,
                      // ),
                      icon: Icon(MdiIcons.delete, color: Colors.red, size: 30),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
