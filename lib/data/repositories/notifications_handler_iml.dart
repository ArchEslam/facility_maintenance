import 'dart:async';
import 'dart:convert';

import 'package:facility_maintenance/data/repositories/notification_handler.dart';
import 'package:facility_maintenance/data/repositories/shared_preferences.dart';
import 'package:facility_maintenance/model/fcm_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class NotificationsHandlerImpl implements NotificationsHandler {
  final FirebaseMessaging firebaseMessaging;
  final MySharedPreferences mySharedPreferences;

  NotificationsHandlerImpl({
    @required this.mySharedPreferences,
    @required this.firebaseMessaging,
  });

  @override
  Map<String, dynamic> initializeMessaging() {
    Map<String, dynamic> myMessage;
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    firebaseMessaging.subscribeToTopic('all');
    firebaseMessaging.getToken().then((token) {
      print("==========================TOKEN=====================\n $token");
      mySharedPreferences.setToke(token);
      // }
    });
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("================onMessage===========:\n ${message}");
        //   HandleMessages.getInstance().onReceive(FcmNotificationModel.fromJson(message), context, FCMpayload.onLaunch,key);
        myMessage = message;
        return myMessage;
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("================onLaunch===========:\n ${message}");
        // HandleMessages.getInstance().onReceive(FcmNotificationModel.fromJson(message), context, FCMpayload.onLaunch,key);
        myMessage = message;
        return myMessage;
      },
      onResume: (Map<String, dynamic> message) async {
        // notificationModel= FcmNotificationModel.fromJson(message);
        print("================onResume===========:\n ${message}");
        //  HandleMessages.getInstance().onReceive(FcmNotificationModel.fromJson(message), context, FCMpayload.onResume,key);
        myMessage = message;
        return myMessage;
      },
    );
    //  throw("Exception thrown while unbinding");
  }

  @override
  Future myBackgroundMessageHandler(Map<String, dynamic> message) {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
  }

  @override
  Future<Map<String, dynamic>> sendAndRetrieveMessage(
      FcmNotificationModel notify,dynamic token) async {
    print(" token on sendAndRetrieveMessage ${token}");

    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${NotificationConstatns.serverToken}',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': notify.messageBody,
            'title': notify.messageTitle,
            'messageBody': notify.messageBody,
            'messageTitle': notify.messageTitle,
            'customerId': notify.customerId,
            'customerName': notify.customerName,
            'itemId': notify.itemId,
            'senderName': notify.senderName,
            'sentAt': notify.sentAt,
            'type': notify.type,
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
            'type': notify.type,
            'message': notify.messageBody,
            'messageBody': notify.messageBody,
            'messageTitle': notify.messageTitle,
            'customerId': notify.customerId,
            'customerName': notify.customerName,
            'itemId': notify.itemId,
            'senderName': notify.senderName,
            'sentAt': notify.sentAt,
          },
          'to': token,
        },
      ),
    );

    final Completer<Map<String, dynamic>> completer =
        Completer<Map<String, dynamic>>();

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      },
    );

    return completer.future;
  }
}
