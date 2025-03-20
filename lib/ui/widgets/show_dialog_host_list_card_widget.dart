import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void showDialogHostListCardWidget(
    BuildContext context,
    hostId,
    hostName,
    ipAddress,
    hostStatus,
    pingStatus,
    packetLoss,
    responseTime,
    cpuLoad,
    availableRam,
    proxyHost,
    deviceModel,
    opearingSystem) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
              child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xffFCBC05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              MdiIcons.laptop,
              size: 30,
              color: Color(0xff08103A),
            ),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Host ID : $hostId"),
              Text("Host Name : $hostName"),
              Text("IP Address  : $ipAddress"),
              Text("Host Status : $hostStatus (active)"),
              Text("Ping Status : $pingStatus (online)"),
              Text("Packet Loss (%) : $packetLoss"),
              Text("Response Time (s) : $responseTime"),
              Text("CPU Load  : $cpuLoad"),
              Text("Available RAM (MB)  : $availableRam"),
              Text("Proxy Host ID : $proxyHost"),
              Text("Device Model  : $deviceModel"),
              Text("Operating System  : $opearingSystem"),
            ],
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                child: Text(
                  'OK',
                  style: TextStyle(color: Color(0xff0146A5)),
                ),
                onPressed: () {
                  // Menutup dialog
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      });
}
