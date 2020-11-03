import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  _delayTimer() async {
    var _duration = Duration(seconds: 2);
    return Timer(_duration, _goToHomeScreen);
  }

  _goToHomeScreen() {
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _delayTimer();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
            /*child: Image.asset(
            "assets/images/logo_speed_run.png",
            width: 200.0,
            fit: BoxFit.fitWidth,
          )*/
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/icon_speedrun.png",
              width: 80.0,
              fit: BoxFit.fitWidth,
            ),
            Text(
              "Speedrun API",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            )
          ],
        )),
      ),
    );
  }
}
