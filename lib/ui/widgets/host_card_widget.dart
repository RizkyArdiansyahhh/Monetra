import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HostCardWidget extends StatelessWidget {
  final String statusActive;
  final String hostName;
  final String hostIp;

  const HostCardWidget(
      {super.key,
      required this.statusActive,
      required this.hostName,
      required this.hostIp});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * .40,
        height: 200,
        decoration: BoxDecoration(
          color: Color(0xffDCEBFF),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: (statusActive == "active")
                    ? Colors.lightGreenAccent
                    : Colors.redAccent.shade700,
                shape: BoxShape.circle,
              ),
              child: Icon(
                MdiIcons.devices,
                size: 50,
              ),
            ),
            Column(
              children: [
                Text(hostName.toString(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                Text(hostIp.toString(),
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w400)),
              ],
            ),
          ],
        ));
  }
}
