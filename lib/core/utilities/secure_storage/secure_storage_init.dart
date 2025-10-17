import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class SecureStorageInit {
  static late FlutterSecureStorage storage;
  static late bool? useBiometrics;

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
