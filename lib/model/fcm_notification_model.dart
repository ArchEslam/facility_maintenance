// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

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
  String deviceRegId;
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
      this.deviceRegId,
      this.messageTitle,
      this.messageBody,
      this.senderName,
      this.sentAt,
      this.customerId,
      this.customerName,
      this.itemId});

  factory FcmNotificationModel.fromJson(Map<String, dynamic> json) =>
      FcmNotificationModel(
        isFCM: json["data"]["isFCM"] ?? "",
        type: json["data"]["type"] ?? "",
        deviceRegId: json["data"]["deviceRegId"] ?? "",
        messageTitle: json["data"]["messageTitle"] ?? "",
        messageBody: json["data"]["messageBody"] ?? "",
        senderName: json["data"]["senderName"] ?? "",
        sentAt: json["data"]["sentAt"] ?? "",
        customerId: json["data"]["customerId"] ?? "",
        customerName: json["data"]["customerName"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "deviceRegId": deviceRegId,
        "messageTitle": messageTitle,
        "messageBody": messageBody,
        "senderName": senderName,
        "sentAt": sentAt,
        "customerId": customerId,
        "customerName": customerName,
      };
}
