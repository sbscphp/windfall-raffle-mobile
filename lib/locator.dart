import 'package:get_it/get_it.dart';

import 'core/data/services/geolocator_service.dart';
import 'core/data/services/navigation_service.dart';



GetIt locator = GetIt.instance;

void setupLocator() {
  //register api classes
  //locator.registerLazySingleton<UtilityDataProvider>(() => UtilityDataProvider());




  ///services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<GeoLocatorService>(() => GeoLocatorService());
}
