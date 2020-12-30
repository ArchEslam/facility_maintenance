import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repository.dart';
import 'data/repository_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  // sl.registerLazySingleton(() => firebaseMessaging);

  // Data sources
  sl.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      sharedPreference: sl(),
      // socket: sl()
    ),
  );
}
