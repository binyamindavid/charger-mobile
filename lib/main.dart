import 'package:charger/screens/home.dart';
import 'package:charger/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(const MyApp());
}


GoRouter router(String? jwt)  {
  return GoRouter(
  initialLocation: jwt != null ? '/home' : '/login',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: 'login',
          pageBuilder: (context, state) => MaterialPage<void>(
            key: state.pageKey,
            child: const LoginScreen(),
          ),
        ),
      ],
    ),
  ],
);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router(null),
    );
  }
}


