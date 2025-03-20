import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monetra/ui/widgets/radial_bar_chart_widget.dart';

class DeviceInformationWidget extends StatelessWidget {
  final int activeDevices;
  final int totalDevices;
  const DeviceInformationWidget(
      {super.key, required this.activeDevices, required this.totalDevices});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * .9,
      height: 200,
      decoration: BoxDecoration(
        color: Color(0xff1778FB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You have connected devices",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Text("$totalDevices devices",
                        style: GoogleFonts.poppins(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  context.go("/hosts");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffFCBC05)),
                child: Text(
                  "View all",
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
          Expanded(
            child: RadialBarChartWidget(
              activeDevices: activeDevices,
              totalDevices: totalDevices,
            ),
          ),
        ],
      ),
    );
  }
}
