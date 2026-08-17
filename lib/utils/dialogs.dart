import 'package:flutter/material.dart';
import 'package:speed_run/network/response_error.dart';

class Dialogs {
  static void showConfirmDialog({
    required BuildContext buildContext,
    required String title,
    required String body,
    required String buttonPositive,
    required Function onActionPositive,
    String? buttonNegative,
    Function? onActionNegative,
  }) {
    showDialog(
      context: buildContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onActionPositive();
              },
              child: Text(buttonPositive),
            ),
            if (buttonNegative != null)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onActionNegative!();
                },
                child: Text(buttonNegative),
              )
            else
              Container(),
          ],
        );
      },
    );
  }

  static void showAlertDialog({
    required BuildContext buildContext,
    required String title,
    required String body,
    required String buttonAlert,
    required Function onActionAlert,
  }) =>
      Dialogs.showConfirmDialog(
        buildContext: buildContext,
        title: title,
        body: body,
        buttonPositive: buttonAlert,
        onActionPositive: onActionAlert,
      );

  static void showResponseErrroAlertDialog(
      {required BuildContext buildContext,
      required ResponseError error,
      required Function onActionAlert}) {
    showAlertDialog(
      buildContext: buildContext,
      title: "Conection Error",
      body: error.messageError,
      buttonAlert: "OK",
      onActionAlert: onActionAlert,
    );
  }

  static showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  static dynamic showResponseErrorSnackbar(
          BuildContext context, ResponseError error) =>
      showSnackbar(context, error.messageError);
}
