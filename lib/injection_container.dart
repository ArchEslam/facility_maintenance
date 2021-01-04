import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/notification_handler.dart';
import 'data/repositories/notifications_handler_iml.dart';
import 'data/repositories/shared_preferences.dart';
import 'data/repositories/shared_preferences_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  sl.registerLazySingleton(() => firebaseMessaging);

  sl.registerLazySingleton<NotificationsHandler>(
    () => NotificationsHandlerImpl(
        firebaseMessaging: sl(), mySharedPreferences: sl()),
  );

  sl.registerLazySingleton<MySharedPreferences>(
    () => MySharedPreferencesImpl(
      sharedPreference: sl(),
    ),
  );
}
