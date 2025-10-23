import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:windfall/core/utilities/secure_storage/secure_storage_utils.dart';



class SecureStorageInit {
  static late FlutterSecureStorage storage;

  static void initSecureStorage() async {
    AndroidOptions androidOption() => const AndroidOptions(
          encryptedSharedPreferences: true,
        );

    IOSOptions iosOptions() =>
        const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

    storage =
        FlutterSecureStorage(aOptions: androidOption(), iOptions: iosOptions());

    initAuthData();
  }

  // ///fetch user auth data
  static void initAuthData() async {
  }
}
