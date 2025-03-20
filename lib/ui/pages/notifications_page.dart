import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:monetra/bloc/alert/alert_bloc.dart';
import '../widgets/notif_card_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F7FF),
      appBar: AppBar(
        backgroundColor: Color(0xffF4F7FF),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Notifications",
              style: GoogleFonts.poppins(
                  color: Color(0xff1F3B7E), fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 5),
            BlocBuilder<AlertBloc, AlertState>(
              builder: (context, state) {
                if (state is AlertLoaded) {
                  final unreadCount = state.alerts
                      .where((alert) => alert["icmp_ping"] == "0")
                      .length;
                  return Row(
                    children: [
                      Text(
                        "You have ",
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                      Text(
                        "$unreadCount new notifications",
                        style: GoogleFonts.poppins(
                            color: Color(0xffFCBC05),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                      ),
                    ],
                  );
                }
                return Text(
                  "Loading notifications...",
                  style: GoogleFonts.poppins(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                );
              },
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              MdiIcons.filterVariantPlus,
              size: 30,
              color: Color(0xff1F3B7E),
            ),
          )
        ],
      ),
      body: BlocBuilder<AlertBloc, AlertState>(
        builder: (context, state) {
          if (state is AlertLoaded) {
            final downAlerts = state.alerts.toList();

            if (downAlerts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 80),
                    SizedBox(height: 10),
                    Text(
                      "Semua host UP, tidak ada notifikasi.",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: downAlerts.length,
              itemBuilder: (context, index) {
                final alert = downAlerts[index];
                final timestamp = alert["last_updated"];
                DateTime dateTime =
                    DateTime.now(); // Default jika tidak ada timestamp

                if (timestamp is Timestamp) {
                  dateTime = timestamp.toDate();
                } else if (timestamp is int) {
                  dateTime =
                      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
                }

// Cetak debug untuk melihat timestamp yang digunakan
                print("Alert: ${alert["host"]}, Timestamp: $dateTime");

                return NotifCardWidget(
                  triggerSeverity: Colors.redAccent,
                  triggerCategory: "Host Disconnect",
                  triggerMessage: "CRITICAL: ${alert["host"]} is unreachable",
                  isRead: false,
                );
              },
            );
          } else if (state is AlertError) {
            return Center(
                child:
                    Text(state.message, style: TextStyle(color: Colors.red)));
          }
          return Center(
              child: Text("Tidak ada data.", style: TextStyle(fontSize: 16)));
        },
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../widgets/notif_card_widget.dart';
// import 'package:timeago/timeago.dart' as timeago;

// class NotificationsPage extends StatelessWidget {
//   const NotificationsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffF4F7FF),
//       appBar: AppBar(
//         backgroundColor: Color(0xffF4F7FF),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Notifications",
//               style: GoogleFonts.poppins(
//                 color: Color(0xff1F3B7E),
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(height: 5),
//             StreamBuilder<QuerySnapshot>(
//               stream:
//                   FirebaseFirestore.instance.collection("alerts").snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Text(
//                     "Loading notifications...",
//                     style: GoogleFonts.poppins(
//                       color: Colors.grey.shade600,
//                       fontWeight: FontWeight.w400,
//                       fontSize: 12,
//                     ),
//                   );
//                 }

//                 if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                   return Text(
//                     "You have 0 new notifications",
//                     style: GoogleFonts.poppins(
//                       color: Color(0xffFCBC05),
//                       fontWeight: FontWeight.w600,
//                       fontSize: 12,
//                     ),
//                   );
//                 }

//                 final unreadCount = snapshot.data!.docs
//                     .where((doc) => doc["icmp_ping"] == "0")
//                     .length;

//                 return Row(
//                   children: [
//                     Text(
//                       "You have ",
//                       style: GoogleFonts.poppins(
//                         color: Colors.grey.shade600,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 12,
//                       ),
//                     ),
//                     Text(
//                       "$unreadCount new notifications",
//                       style: GoogleFonts.poppins(
//                         color: Color(0xffFCBC05),
//                         fontWeight: FontWeight.w600,
//                         fontSize: 12,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(
//               MdiIcons.filterVariantPlus,
//               size: 30,
//               color: Color(0xff1F3B7E),
//             ),
//           )
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection("alerts").snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }

//           if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.check_circle, color: Colors.green, size: 80),
//                   SizedBox(height: 10),
//                   Text(
//                     "Semua host UP, tidak ada notifikasi.",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               ),
//             );
//           }

//           final downAlerts = snapshot.data!.docs
//               .where((doc) => doc["icmp_ping"] == "0")
//               .toList();

//           return ListView.builder(
//             padding: EdgeInsets.all(16),
//             itemCount: downAlerts.length,
//             itemBuilder: (context, index) {
//               final doc = downAlerts[index];
//               final data = doc.data() as Map<String, dynamic>;

//               if (data["host"] == null) {
//                 return SizedBox.shrink(); // Skip jika host null
//               }

//               // Ambil timestamp dari Firestore
//               DateTime dateTime = DateTime.now();
//               if (data.containsKey("last_updated")) {
//                 final timestamp = data["last_updated"];
//                 if (timestamp is Timestamp) {
//                   dateTime = timestamp.toDate();
//                 }
//               }

//               return NotifCardWidget(
//                 triggerSeverity: Colors.redAccent,
//                 triggerCategory: "Host Disconnect",
//                 triggerMessage: "CRITICAL: ${data["host"]} is unreachable",
//                 isRead: false,
//                 triggerTime: timeago.format(dateTime, locale: 'en_short'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
