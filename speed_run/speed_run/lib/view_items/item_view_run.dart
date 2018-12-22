import 'package:flutter/material.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/utils/colors.dart' as colors;
class RunItemView extends StatelessWidget{

   final Run _run;

   RunItemView(this._run);


   @override
   Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Container(
            child: Center(
              child: Text('entry ${_run.date}',style: TextStyle(
                  color: Colors.white
              ),),
            ),
          )
      ),
      color: colors.blackCard,
    );
  }


}