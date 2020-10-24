import 'package:flutter/material.dart';
import 'package:speed_run/network/response_error.dart';

class Dialogs{

  static void showConfirmDialog({BuildContext buildContext,
      String title,
      String body,
      String buttonPositive,
      Function onActionPositive,
      String buttonNegative,
      Function onActionNegative}){
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
      }
    );
  }

  static void showAlertDialog({BuildContext buildContext,
    String title,
    String body,
    String buttonAlert,
    Function onActionAlert
  }) => Dialogs.showConfirmDialog(buildContext: buildContext,title: title,
      body: body,buttonPositive: buttonAlert, onActionPositive: onActionAlert);

  static void showResponseErrroAlertDialog({BuildContext buildContext,ResponseError error, Function onActionAlert}){
    showAlertDialog(buildContext: buildContext,
      title: "Conection Error",
      body: error.messageError,
      buttonAlert: "OK",
      onActionAlert: onActionAlert
    );
  }

  static showSnackbar(BuildContext context,String message){
    Scaffold.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          message,
          style: TextStyle(
            color:Colors.black
          ),
        )
      )
    );
  }

  static showResponseErrorSnackbar(BuildContext context, ResponseError error)=>
      showSnackbar(context, error.messageError);
}