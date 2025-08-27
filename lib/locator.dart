import 'package:get_it/get_it.dart';

import 'core/data/data_provider/auth_data_provider/auth_data_provider.dart';
import 'core/data/data_provider/auth_data_provider/otp_data_provider.dart';
import 'core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'core/data/services/geolocator_service.dart';
import 'core/data/services/navigation_service.dart';



GetIt locator = GetIt.instance;

void setupLocator() {
  //register api classes
  locator.registerLazySingleton<UtilityDataProvider>(() => UtilityDataProvider());
  locator.registerLazySingleton<AuthDataProvider>(() => AuthDataProvider());
  locator.registerLazySingleton<OtpDataProvider>(() => OtpDataProvider());




  ///services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<GeoLocatorService>(() => GeoLocatorService());
}
