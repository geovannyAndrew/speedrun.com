import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/screens/home_screen.dart';
import 'package:speed_run/screens/splash_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class _DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = _DevHttpOverrides();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeedRun API',
      theme: ThemeData(
        primaryColor: colors.blackDark,
        primaryColorDark: Colors.black,
        colorScheme: const ColorScheme.dark().copyWith(
          secondary: colors.greenAccent,
        ),
        dialogBackgroundColor: colors.blackBackground,
        fontFamily: 'OpenSans',
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 72.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(fontSize: 14.0, color: Colors.white),
          labelLarge: TextStyle(color: Colors.white),
          titleSmall: TextStyle(color: Colors.white),
          titleMedium: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: "/",
      onGenerateRoute: _onGenerateRoute,
    );
  }
}

Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case "/":
      return MaterialPageRoute(builder: (_) => SplashScreen());
    case "/home":
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case "/run_detail":
      final runId = settings.arguments as String?;
      if (runId == null || runId.isEmpty) {
        return _errorRoute('Missing runId');
      }
      return MaterialPageRoute(
        builder: (_) => RunDetailScreen(runId: runId),
      );
    case "/game_detail":
      final gameId = settings.arguments as String?;
      if (gameId == null || gameId.isEmpty) {
        return _errorRoute('Missing gameId');
      }
      return MaterialPageRoute(
        builder: (_) => GameDetailScreen(gameId: gameId),
      );
    default:
      return _errorRoute('Unknown route: ${settings.name}');
  }
}

Route<dynamic> _errorRoute(String message) {
  return MaterialPageRoute(
    builder: (_) => Scaffold(
      body: Center(
        child: Text(message),
      ),
    ),
  );
}
