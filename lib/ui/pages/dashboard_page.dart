import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monetra/bloc/greeting/greeting_bloc.dart';
import 'package:monetra/bloc/host/host_bloc.dart';
import 'package:monetra/bloc/host/host_event.dart';
import 'package:monetra/bloc/host/host_state.dart';
import 'package:monetra/bloc/user/user_bloc.dart';
import 'package:monetra/ui/widgets/device_information_widget.dart';
import 'package:monetra/ui/widgets/host_card_widget.dart';
import 'dart:async';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    context.read<GreetingBloc>().add(UpdateGreeting());
    _fetchHosts();
    _startAutoRefresh();
  }

  void _fetchHosts() {
    context.read<HostBloc>().add(FetchHosts());
  }

  void _startAutoRefresh() {
    _timer = Timer.periodic(Duration(minutes: 30), (timer) {
      if (mounted) {
        _fetchHosts();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return Text(
                      (state is UserAuthenticated)
                          ? "Hi, ${state.username}"
                          : "Anonymous",
                      style: GoogleFonts.poppins(
                          fontSize: 19, fontWeight: FontWeight.w600),
                    );
                  },
                ),
                BlocBuilder<GreetingBloc, GreetingState>(
                  builder: (context, state) {
                    return Text(
                      state.greeting.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff1778FB),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ]),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              MdiIcons.accountCircle,
              size: 40,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _fetchHosts();
        },
        child: SingleChildScrollView(
          child: Column(children: [
            Align(
              alignment: Alignment.center,
              child: BlocBuilder<HostBloc, HostState>(
                builder: (context, state) {
                  if (state is HostLoaded) {
                    return DeviceInformationWidget(
                        activeDevices: state.hosts
                            .where((host) => host.icmpPing == "1")
                            .length,
                        totalDevices: state.hosts.length);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hosts",
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "View details",
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            BlocBuilder<HostBloc, HostState>(
              builder: (context, state) {
                if (state is HostLoading) {
                  return const Center(child: CircularProgressIndicator());
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
                } else if (state is HostLoaded) {
                  if (state.hosts.isEmpty) {
                    return const Center(child: Text("no data available"));
                  }

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 10,
                      alignment: WrapAlignment.start,
                      children: state.hosts.map((host) {
                        return HostCardWidget(
                          statusActive:
                              host.icmpPing == "1" ? "active" : "inactive",
                          hostIp: host.ip.isNotEmpty ? host.ip : "Unknown",
                          hostName: host.host,
                        );
                      }).toList(),
                    ),
                  );
                } else {
                  return const Center(child: Text("Unknown state"));
                }
              },
            ),
          ]),
        ),
      ),
    );
  }
}
