import 'package:facility_maintenance/model/fcm_notification_model.dart';

abstract class NotificationsHandler {
  Map<String, dynamic> initializeMessaging();

  Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message);

  Future<Map<String, dynamic>> sendAndRetrieveMessage(
      FcmNotificationModel notify, dynamic token);
}
