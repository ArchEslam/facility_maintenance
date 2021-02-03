import 'package:facility_maintenance/model/fcm_notification_model.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageDialog extends StatefulWidget {
  final FcmNotificationModel fcmNotificationModel;

  MessageDialog({this.fcmNotificationModel});

  @override
  _MessageDialogState createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data:
          Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
      child: AlertDialog(
        content: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                    offset: Offset(0.0, 3.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /* Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              color: Colors.white,
                              child: Text(message_title,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: AppTheme.grey[700],
                                      fontFamily: AppTheme.fontName,
                                      fontWeight: FontWeight.w700,),),),
                        ),*/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        'From : ${widget.fcmNotificationModel.senderName}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        widget.fcmNotificationModel.messageBody == null
                            ? ''
                            : widget.fcmNotificationModel.messageBody,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.greenAccent,
                          child: Text(
                            "goo details",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: () {
                            switch (widget.fcmNotificationModel.type) {
                              case FCMpayload.employee:
                                Navigator.pushNamed(
                                    context, '/create_hvac_request');
                                break;
                              case FCMpayload.employee:
                                Navigator.pushNamed(context, '/hvac_requests');
                                break;
                            }
                          },
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        FlatButton(
                          color: Colors.redAccent,
                          child: Text(
                            "Cancel",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[],
      ),
    );
  }
}
