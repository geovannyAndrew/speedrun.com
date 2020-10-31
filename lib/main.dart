import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/services/apis/games_api.dart';
import 'package:speed_run/data/services/apis/runs_api.dart';
import 'package:speed_run/data/services/apis/users_api.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';
import 'package:speed_run/injection.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/screens/home_screen.dart';
import 'package:speed_run/screens/splash_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'data/models/run.dart';
import 'package:speed_run/data/services/services_extensions.dart';

void main() async {
  configureInjection(Environment.prod);
  //runApp(MyApp());
  final ra = getIt<IUsersApi>();
  final run = await ra.getUser(idUser: "wzx7q875");
  run.fold((l) {}, (r) {
    print(r);
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeedRun API',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: colors.blackDark,
        primaryColorDark: Colors.black,
        backgroundColor: colors.blackBackground,
        accentColor: colors.greenAccent,
        dialogBackgroundColor: colors.blackBackground,
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          headline5: TextStyle(
              fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline6: TextStyle(
              fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
          button: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/home": (context) => HomeScreen(),
        "/run_detail": (context) => RunDetailScreen(),
        "/game_detail": (context) => GameDetailScreen()
      },
    );
  }
}
