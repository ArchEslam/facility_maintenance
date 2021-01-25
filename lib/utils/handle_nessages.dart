import 'package:facility_maintenance/model/fcm_notification_model.dart';
import 'package:facility_maintenance/widgets/message_dialog.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class HandleMessages {
  static HandleMessages utility = null;

  static HandleMessages getInstance() {
    if (utility == null) {
      utility = HandleMessages();
    }
    return utility;
  }

  void onReceive(FcmNotificationModel fcmNotificationModel,
      BuildContext context, int launchType, GlobalKey<NavigatorState> key) {
    try {
      if (launchType == FCMpayload.onMessage) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return MessageDialog(fcmNotificationModel: fcmNotificationModel);
          },
        );
      } else {
        navigateToItemDetail(fcmNotificationModel, context);
      }
    } catch (e) {
      print(
          "================Error handling message===========:\n ${e.toString()}");
    }
  }

  void navigateToItemDetail(
      FcmNotificationModel fcmNotificationModel, BuildContext context) {
    if (fcmNotificationModel.type == FCMpayload.user) {
      Navigator.pushNamed(context, '/create_hvac_request');
    } else if (fcmNotificationModel.type == FCMpayload.employee) {
      Navigator.pushNamed(context, '/hvac_requests');
    }
  }

  showAlertDialog(
      BuildContext context, FcmNotificationModel fcmNotificationModel) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("your request changed"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text(fcmNotificationModel.messageBody)],
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessageDialog(
          fcmNotificationModel: fcmNotificationModel,
        );
      },
    );
  }
}
