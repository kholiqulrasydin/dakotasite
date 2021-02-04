import 'package:get_it/get_it.dart';
import 'package:dakotawebsite/services/api.dart';
import 'package:dakotawebsite/services/auth/api.dart';
import 'package:dakotawebsite/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => ApiService());
}
