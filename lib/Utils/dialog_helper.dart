import 'package:flutter/material.dart';

class DialogHelper {
  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            FilledButton(
              onPressed: () {
                return onPressed();
              },
              child: Text(buttonText),
            )
          ],
        );
      },
    );
  }

  static void showProgressIndicator(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Processing'),
          content: Center(
            heightFactor: 10,
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
