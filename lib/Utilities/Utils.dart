import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils {
  //Loading Widgets

  static bool checkShowLoader = false;
  static BuildContext parentLoadingContext = null;
  

  static Future showLoader(context) async {
    await showDialog(
      context: context,
      builder: (_) => CircularProgressIndicator()
    ).then((onValue) {
      parentLoadingContext = context;
      checkShowLoader = true;
    });
  }

  static Future hideLoader() async {
    if (checkShowLoader == true && parentLoadingContext != null) {
      Navigator.pop(parentLoadingContext);
      parentLoadingContext = null;
      checkShowLoader = false;
    }
  }

  static Future hideLoaderCurrrent(context) async {
    Navigator.pop(context);
    parentLoadingContext = null;
    checkShowLoader = false;
  }

  

}

enum alertDialogAction { cancel, save }

class Dialogs {
  static Future<alertDialogAction> alertDialog(
    BuildContext context,
    String title,
    String body,
    String cancel,
  ) {
    Future<alertDialogAction> action = showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              RaisedButton(
                  color: Colors.orange,
                  onPressed: () =>
                      Navigator.of(context).pop(alertDialogAction.cancel),
                  child: Text(
                    cancel,
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
    return (action != null) ? action : alertDialogAction.cancel;
  }
}