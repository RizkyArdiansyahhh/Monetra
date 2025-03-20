import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainPage extends StatelessWidget {
  final Widget child;
  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    log(location);

    return Scaffold(
      backgroundColor: Color(0xffF4F7FF),
      body: child,
      bottomNavigationBar:
          (location == "/account/create" || location == "/hosts/create")
              ? null
              : CurvedNavigationBar(
                  height: 60,
                  backgroundColor: Colors.transparent,
                  color: Color(0xff1778FB),
                  animationDuration: Duration(milliseconds: 300),
                  index: _getSelectedIndex(context),
                  items: [
                    Icon(MdiIcons.monitorDashboard, color: Colors.white),
                    Icon(MdiIcons.devices, color: Colors.white),
                    Icon(MdiIcons.bell, color: Colors.white),
                    Icon(MdiIcons.account, color: Colors.white),
                  ],
                  onTap: (index) {
                    _onTapNav(index, context);
                  },
                ),
    );
  }
}

int _getSelectedIndex(BuildContext context) {
  final String location = GoRouterState.of(context).uri.toString();
  if (location.startsWith("/hosts")) return 1;
  if (location.startsWith("/notifications")) return 2;
  if (location.startsWith("/account")) return 3;
  return 0;
}

void _onTapNav(int index, BuildContext context) {
  switch (index) {
    case 0:
      context.goNamed("dashboard");
      break;
    case 1:
      context.goNamed("hosts");
      break;
    case 2:
      context.goNamed("notifications");
      break;
    case 3:
      context.goNamed("account");
      break;
  }
}
