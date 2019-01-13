import 'package:flutter/material.dart';

void showDialogApp({BuildContext buildContext,
    String title,
    String body,
    String buttonPositive,
    Function onActionPositive,
    String buttonNegative,
    Function onActionNegative
}){
  showDialog(
    context: buildContext,
    barrierDismissible: false,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Navigator.of(context).pop();
              onActionPositive();
            },
            child: Text(buttonPositive)
          ),
          buttonNegative != null ?
          FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
                onActionNegative();
              },
              child: Text(buttonNegative)
          ) : Container()
        ],
      );
    });
}