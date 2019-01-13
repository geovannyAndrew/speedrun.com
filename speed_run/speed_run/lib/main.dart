import 'package:flutter/material.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/screens/home_screen.dart';
import 'package:speed_run/screens/splash_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SpeedRuns',
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
          headline: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          title: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          body1: TextStyle(
              fontSize: 14.0,
              color: Colors.white
          ),
          button: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
          subtitle: TextStyle(
            color: Colors.white
          ),
          subhead: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/home" : (context) => HomeScreen(),
        "/run_detail" : (context) => RunDetailScreen(),
        "/game_detail" : (context) => GameDetailScreen()
      },
    );
  }
}

