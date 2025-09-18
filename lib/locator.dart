import 'package:get_it/get_it.dart';
import 'package:windfall/core/data/data_provider/order_history_data_provider.dart';
import 'package:windfall/core/data/data_provider/payment_data_provider.dart';
import 'package:windfall/core/data/data_provider/referral_data_provider.dart';

import 'core/data/data_provider/auth_data_provider/auth_data_provider.dart';
import 'core/data/data_provider/auth_data_provider/otp_data_provider.dart';
import 'core/data/data_provider/cart_data_provider.dart';
import 'core/data/data_provider/game_data_provider.dart';
import 'core/data/data_provider/profile_data_provider/notification_data_provider.dart';
import 'core/data/data_provider/profile_data_provider/profile_data_provider.dart';
import 'core/data/data_provider/utility_data_provider/utility_data_provider.dart';
import 'core/data/services/geolocator_service.dart';
import 'core/data/services/navigation_service.dart';



GetIt locator = GetIt.instance;

void setupLocator() {
  //register api classes
  locator.registerLazySingleton<UtilityDataProvider>(() => UtilityDataProvider());
  locator.registerLazySingleton<AuthDataProvider>(() => AuthDataProvider());
  locator.registerLazySingleton<OtpDataProvider>(() => OtpDataProvider());
  locator.registerLazySingleton<ProfileDataProvider>(() => ProfileDataProvider());
  locator.registerLazySingleton<NotificationDataProvider>(() => NotificationDataProvider());
  locator.registerLazySingleton<GameDataProvider>(() => GameDataProvider());
  locator.registerLazySingleton<CartDataProvider>(() => CartDataProvider());
  locator.registerLazySingleton<ReferralDataProvider>(() => ReferralDataProvider());
  locator.registerLazySingleton<PaymentDataProvider>(() => PaymentDataProvider());
  locator.registerLazySingleton<OrderHistoryDataProvider>(() => OrderHistoryDataProvider());




  ///services
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton<GeoLocatorService>(() => GeoLocatorService());
}
