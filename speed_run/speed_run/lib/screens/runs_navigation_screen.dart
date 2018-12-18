
import 'package:flutter/material.dart';

class RunsNavigationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RunsNavigationScreenState();
  }

}

class _RunsNavigationScreenState extends State<RunsNavigationScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
        child: ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemExtent: 20.0,
          itemBuilder: (BuildContext context, int index) {
            return Text('entry $index');
          },
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.blue
      ),
    );
  }

}