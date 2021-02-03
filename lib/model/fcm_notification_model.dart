// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'dart:io' show Platform;

String FcmNotificationToJson(FcmNotificationModel data) {
  if (data != null) {
    return json.encode(data.toJson());
  } else {
    return "null";
  }
}

class FcmNotificationModel {
  String isFCM;
  String type;
  String token;
  String messageTitle;
  String messageBody;
  String senderName;
  String sentAt;
  String customerId;
  String customerName;
  String itemId;

  FcmNotificationModel(
      {this.isFCM,
      this.type,
      this.token,
      this.messageTitle,
      this.messageBody,
      this.senderName,
      this.sentAt,
      this.customerId,
      this.customerName,
      this.itemId});

  factory FcmNotificationModel.fromJson(Map<String, dynamic> json) =>
      FcmNotificationModel(
        isFCM: Platform.isAndroid
            ? json["data"]["isFCM"] ?? ""
            : json["isFCM"] ?? "",
        type: Platform.isAndroid
            ? json["data"]["type"] ?? ""
            : json["type"] ?? "",
        token: Platform.isAndroid
            ? json["data"]["token"] ?? ""
            : json["token"] ?? "",
        messageTitle: Platform.isAndroid
            ? json["data"]["messageTitle"] ?? ""
            : json["messageTitle"] ?? "",
        messageBody: Platform.isAndroid
            ? json["data"]["messageBody"] ?? ""
            : json["messageBody"] ?? "",
        senderName: Platform.isAndroid
            ? json["data"]["senderName"] ?? ""
            : json["senderName"] ?? "",
        sentAt: Platform.isAndroid
            ? json["data"]["sentAt"] ?? ""
            : json["sentAt"] ?? "",
        customerId: Platform.isAndroid
            ? json["data"]["customerId"] ?? ""
            : json["customerId"] ?? "",
        customerName: Platform.isAndroid
            ? json["data"]["customerName"] ?? ""
            : json["customerName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "token": token,
        "messageTitle": messageTitle,
        "messageBody": messageBody,
        "senderName": senderName,
        "sentAt": sentAt,
        "customerId": customerId,
        "customerName": customerName,
      };
}
