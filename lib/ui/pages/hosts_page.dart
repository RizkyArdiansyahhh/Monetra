import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:monetra/bloc/host/host_bloc.dart';
import 'package:monetra/bloc/host/host_event.dart';
import 'package:monetra/bloc/host/host_state.dart';
import 'package:monetra/ui/widgets/host_list_card_widget.dart';
import 'package:monetra/ui/widgets/show_dialog_alert.dart';
import 'package:monetra/ui/widgets/text_button_widget.dart';

class HostsPage extends StatefulWidget {
  const HostsPage({super.key});

  @override
  State<HostsPage> createState() => _HostsPageState();
}

class _HostsPageState extends State<HostsPage> {
  @override
  void initState() {
    super.initState();
    context.read<HostBloc>().add(FetchHosts());
  }

  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF4F7FF),
      appBar: AppBar(
          backgroundColor: Color(0xff1778FB),
          title: Icon(MdiIcons.menu, color: Colors.white, size: 30)),
      body: BlocListener<HostBloc, HostState>(
        listener: (context, state) {
          if (state is HostDelected) {
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
                          child: Icon(
                        MdiIcons.deleteCircle,
                        size: 70,
                        color: Colors.red,
                      )),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text("Host has been deleted successfully",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ],
                      ),
                      actions: [
                        TextButtonWidget(
                          color: Color(0xff0146A5),
                          text: "Ok",
                          onPressed: () {
                            Navigator.pop(context);
                            context.read<HostBloc>().add(FetchHosts());
                          },
                        ),
                      ],
                    ));
          } else if (state is HostError) {
            showDialogAlert(context, state.message);
          }
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xff1778FB),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .5,
                    child: Text(
                      "Search for Devices by HostName or IP Address",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                        log(searchQuery);
                      });
                    },
                    cursorColor: Color(0xff1778FB),
                    decoration: InputDecoration(
                      hintText: "Search by Name or IP Address",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                      ),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        MdiIcons.magnify,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Host List",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () {
                      context.go("/hosts/create");
                    },
                    icon: Icon(
                      MdiIcons.plusThick,
                      size: 30,
                    ),
                    color: Color(0xff1778FB),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<HostBloc, HostState>(
                  builder: (context, state) {
                    if (state is HostLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HostLoaded) {
                      final hosts = state.hosts
                          .where((host) =>
                              host.host.toLowerCase().contains(searchQuery) ||
                              host.ip.toLowerCase().contains(searchQuery))
                          .toList();

                      if (hosts.isEmpty) {
                        return Center(
                            child: Text(
                          "No hosts found",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ));
                      }
                      return ListView.separated(
                        itemCount: hosts.length,
                        itemBuilder: (context, index) {
                          final host = hosts[index];
                          return HostListCardWidget(
                            hostId: host.hostId,
                            hostName: host.host,
                            iPAddress: host.ip,
                            onPressed: () {
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
                                              "Delete ${host.host}?",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          actions: [
                                            TextButtonWidget(
                                              color: Color(0xffFCBC05),
                                              text: "Cancel",
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                            TextButtonWidget(
                                              color: Color(0xff0146A5),
                                              text: "OK",
                                              onPressed: () {
                                                context.read<HostBloc>().add(
                                                    DeleteHost(
                                                        hostId: host.hostId));
                                                Navigator.pop(context);
                                              },
                                            )
                                          ]));
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10);
                        },
                      );
                    } else if (state is HostError) {
                      return Center(
                          child: SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          color: Color(0xff1778FB),
                          strokeWidth: 5,
                        ),
                      ));
                    } else {
                      return const Center(child: Text("Unknown host"));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
