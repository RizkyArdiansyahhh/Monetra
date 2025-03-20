import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class RadialBarChartWidget extends StatelessWidget {
  final int totalDevices;
  final int activeDevices;
  final Color color;
  const RadialBarChartWidget(
      {super.key,
      required this.totalDevices,
      required this.activeDevices,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 130,
          // padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                pointers: [
                  RangePointer(
                    value: (activeDevices / totalDevices) * 100,
                    width: 10,
                    cornerStyle: CornerStyle.bothCurve,
                    gradient: const SweepGradient(
                        colors: [Color(0xFFFFC434), Color(0xFFFF8209)],
                        stops: [0.1, 0.75]),
                  )
                ],
                axisLineStyle: AxisLineStyle(
                  thickness: 10,
                  color: Colors.grey.shade300,
                ),
                startAngle: 5,
                endAngle: 5,
                showLabels: false,
                showTicks: false,
                annotations: [
                  GaugeAnnotation(
                    widget: Text(
                      "$activeDevices of $totalDevices",
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    angle: 270,
                    positionFactor: 0.1,
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text("Devices Active",
            style: GoogleFonts.poppins(
                fontSize: 12, fontWeight: FontWeight.w700, color: color)),
      ],
    );
  }
}
