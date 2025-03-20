import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:monetra/bloc/alert/alert_bloc.dart';
import 'package:monetra/bloc/greeting/greeting_bloc.dart';
import 'package:monetra/bloc/host/host_bloc.dart';
import 'package:monetra/bloc/user/user_bloc.dart';
import 'package:monetra/ui/pages/account_page.dart';
import 'package:monetra/ui/pages/create_account_page.dart';
import 'package:monetra/ui/pages/create_host_page.dart';
import 'package:monetra/ui/pages/dashboard_page.dart';
import 'package:monetra/ui/pages/hosts_page.dart';
import 'package:monetra/ui/pages/login_page.dart';
import 'package:monetra/ui/pages/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monetra/ui/pages/notifications_page.dart';

final GoRouter router = GoRouter(
  initialLocation: "/login",
  routes: [
    GoRoute(
      path: "/login",
      name: "login",
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(
        builder: (context, state, child) {
          return MainPage(child: child);
        },
        routes: [
          GoRoute(
            path: "/dashboard",
            name: "dashboard",
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
              path: "/hosts",
              name: "hosts",
              builder: (context, state) => const HostsPage(),
              routes: [
                GoRoute(
                  path: "create",
                  name: "create-host",
                  builder: (context, state) => const CreateHostPage(),
                ),
              ]),
          GoRoute(
            path: "/notifications",
            name: "notifications",
            builder: (context, state) => const NotificationsPage(),
          ),
          GoRoute(
            path: "/account",
            name: "account",
            builder: (context, state) => const AccountPage(),
            routes: [
              GoRoute(
                path: "create",
                name: "create-account",
                builder: (context, state) => const CreateAccountPage(),
              ),
            ],
          )
        ])
  ],
  debugLogDiagnostics: true,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GreetingBloc(),
        ),
        BlocProvider(
          create: (context) => HostBloc(),
        ),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => AlertBloc()..add(FetchAlerts())),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
