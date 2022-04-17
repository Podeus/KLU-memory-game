import 'package:get_it/get_it.dart';
import 'package:flutter_base/core/services/view/navigation_service.dart';
import 'package:flutter_base/core/services/view/dialog_service.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  // locator.registerLazySingleton(() => DeviceInfoService());
  // locator.registerLazySingleton(() => PushNotificationService());
  // locator.registerLazySingleton(() => FirebaseService());

  // locator.registerLazySingleton(() => FirestoreService());
  // locator.registerLazySingleton(() => FirestoreService());
  // locator.registerLazySingleton(() => CloudStorageService());
  // locator.registerLazySingleton(() => ImageSelector());

  // locator.registerLazySingleton(() => Api());
}
