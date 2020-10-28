import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/screens/home_screen.dart';
import 'package:speed_run/screens/splash_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;

import 'domain/services/models/game.dart';
import 'domain/services/models/names.dart';

void main() {
  //runApp(MyApp());
  final Map<String, dynamic> json = jsonDecode("""{
"id":"v1pxjz68",
"names":{
"international":"Super Mario Sunshine",
"japanese":"\u30b9\u30fc\u30d1\u30fc\u30de\u30ea\u30aa\u30b5\u30f3\u30b7\u30e3\u30a4\u30f3",
"twitch":"Super Mario Sunshine"
},
"abbreviation":"sms",
"weblink":"https://www.speedrun.com/sms",
"released":2002,
"release-date":"2002-07-19",
"ruleset":{
"show-milliseconds":true,
"require-verification":true,
"require-video":false,
"run-times":[
"realtime"
],
"default-time":"realtime",
"emulators-allowed":true
},
"romhack":false,
"gametypes":[
],
"platforms":{
"data":[
{
"id":"4p9z06rn",
"name":"GameCube",
"released":2001,
"links":[
{
"rel":"self",
"uri":"https://www.speedrun.com/api/v1/platforms/4p9z06rn"
},
{
"rel":"games",
"uri":"https://www.speedrun.com/api/v1/games?platform=4p9z06rn"
},
{
"rel":"runs",
"uri":"https://www.speedrun.com/api/v1/runs?platform=4p9z06rn"
}
]
},
{
"id":"v06dk3e4",
"name":"Wii",
"released":2006,
"links":[
{
"rel":"self",
"uri":"https://www.speedrun.com/api/v1/platforms/v06dk3e4"
},
{
"rel":"games",
"uri":"https://www.speedrun.com/api/v1/games?platform=v06dk3e4"
},
{
"rel":"runs",
"uri":"https://www.speedrun.com/api/v1/runs?platform=v06dk3e4"
}
]
}
]
},
"regions":[
"pr184lqn",
"e6lxy1dz",
"o316x197",
"p2g50lnk"
],
"genres":[
"qdnqkn8k",
"jp23ox26"
],
"engines":[
],
"developers":[
"xv6dvx62"
],
"publishers":[
"m0rvylrx"
],
"moderators":{
"dkjplk8q":"super-moderator",
"qjopynx6":"super-moderator",
"y8d44o86":"super-moderator",
"v81q5ljp":"moderator",
"y8d41986":"super-moderator",
"o8639p8z":"super-moderator",
"98r36381":"super-moderator",
"o8663m38":"super-moderator",
"kj9k3lr8":"super-moderator",
"o8677eqj":"moderator",
"48g4yqr8":"super-moderator"
},
"created":"2014-12-07T12:50:20Z",
"assets":{
"logo":{
"uri":"https://www.speedrun.com/themes/sms/logo.png",
"width":180,
"height":32
},
"cover-tiny":{
"uri":"https://www.speedrun.com/themes/sms/cover-32.png",
"width":32,
"height":45
},
"cover-small":{
"uri":"https://www.speedrun.com/themes/sms/cover-64.png",
"width":64,
"height":90
},
"cover-medium":{
"uri":"https://www.speedrun.com/themes/sms/cover-128.png",
"width":128,
"height":180
},
"cover-large":{
"uri":"https://www.speedrun.com/themes/sms/cover-256.png",
"width":256,
"height":360
},
"icon":{
"uri":"https://www.speedrun.com/themes/sms/favicon.png",
"width":282,
"height":325
},
"trophy-1st":{
"uri":"https://www.speedrun.com/themes/sms/1st.png",
"width":18,
"height":18
},
"trophy-2nd":{
"uri":"https://www.speedrun.com/themes/sms/2nd.png",
"width":18,
"height":18
},
"trophy-3rd":{
"uri":"https://www.speedrun.com/themes/sms/3rd.png",
"width":18,
"height":18
},
"trophy-4th":null,
"background":{
"uri":"https://www.speedrun.com/themes/sms/background.png",
"width":1920,
"height":1080
},
"foreground":null
},
"links":[
{
"rel":"self",
"uri":"https://www.speedrun.com/api/v1/games/v1pxjz68"
},
{
"rel":"runs",
"uri":"https://www.speedrun.com/api/v1/runs?game=v1pxjz68"
},
{
"rel":"levels",
"uri":"https://www.speedrun.com/api/v1/games/v1pxjz68/levels"
},
{
"rel":"categories",
"uri":"https://www.speedrun.com/api/v1/games/v1pxjz68/categories"
},
{
"rel":"variables",
"uri":"https://www.speedrun.com/api/v1/games/v1pxjz68/variables"
},
{
"rel":"records",
"uri":"https://www.speedrun.com/api/v1/games/v1pxjz68/records"
},
{
"rel":"series",
"uri":"https://www.speedrun.com/api/v1/series/rv7emz49"
},
{
"rel":"derived-games",
"uri":"https://www.speedrun.com/api/v1/games/v1pxjz68/derived-games"
},
{
"rel":"romhacks",
"uri":"https://www.speedrun.com/api/v1/games/v1pxjz68/derived-games"
},
{
"rel":"leaderboard",
"uri":"https://www.speedrun.com/api/v1/leaderboards/v1pxjz68/category/n2y3r8do"
}
]
}""") as Map<String, dynamic>;
  final game = Game.fromJson(json);
  print("==== RESULT ====");
  print(game);
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
