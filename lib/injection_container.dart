import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/repositories/shared_preferences.dart';
import 'data/repositories/shared_preferences_impl.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton<MySharedPreferences>(
    () => MySharedPreferencesImpl(
      sharedPreference: sl(),
    ),
  );
}
