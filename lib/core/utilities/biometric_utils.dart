import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

import '../../ui/widgets/show_flush_bar.dart';

class BiometricUtils {
  static final _auth = LocalAuthentication();

  ///check if biometric auth is available on target device
  static Future<bool> canAuthenticate() async {
    try {
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } on PlatformException catch (_) {
      return false;
    }
  }

  ///attempt biometric authentication
  // static Future<bool?> authenticate() async {
  //   try {
  //     if (!await canAuthenticate()) return false;
  //
  //     return _auth.authenticate(
  //       localizedReason: "Authenticate using biometrics",
  //       authMessages: [
  //         const AndroidAuthMessages(
  //           //signInTitle: 'Biometric authentication required!',
  //           cancelButton: 'No thanks',
  //         ),
  //         const IOSAuthMessages(
  //           cancelButton: 'No thanks',
  //         ),
  //       ],
  //       options: const AuthenticationOptions(
  //           useErrorDialogs: true,
  //           biometricOnly: true,
  //           stickyAuth:
  //               true //setting this to true causes an ish on android 10 devices(the auth dialog shows up twice)
  //           ),
  //     );
  //   } on PlatformException catch (e) {
  //     if (e.code == auth_error.notAvailable) {
  //       // Add handling of no hardware here.
  //       return false;
  //     } else if (e.code == auth_error.notEnrolled) {
  //       return false;
  //     } else {
  //       return false;
  //     }
  //   }
  // }

  static Future<bool?> authenticate(BuildContext context) async {
    try {
      if (!await canAuthenticate()) {
        showFlushBar(
          context: context,
          success: false,
          message: 'Biometric authentication not available or not set up.',
          duration: 5,
        );
        return false;
      }

      final result = await _auth.authenticate(
        localizedReason: "Authenticate using biometrics",
        authMessages: const [
          AndroidAuthMessages(cancelButton: 'No thanks'),
          IOSAuthMessages(cancelButton: 'No thanks'),
        ],
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          biometricOnly: true,
          stickyAuth: true,
        ),
      );

      if (result) {
        showFlushBar(
          context: context,
          success: true,
          message: 'Authentication successful',
          duration: 3,
        );
      } else {
        showFlushBar(
          context: context,
          success: false,
          message: 'Authentication failed or cancelled',
          duration: 3,
        );
      }

      return result;
    } on PlatformException catch (e) {
      String msg = 'Authentication failed.';

      if (e.code == auth_error.notAvailable) {
        msg = 'Biometric authentication not available on this device.';
      } else if (e.code == auth_error.notEnrolled) {
        msg = 'No biometric credentials enrolled. Please set up fingerprint or face unlock.';
      } else if (e.message?.contains('Security credentials not available') == true) {
        msg = 'Security credentials not available. Set up a screen lock or fingerprint.';
      }

      showFlushBar(
        context: context,
        success: false,
        message: msg,
        duration: 5,
      );

      return false;
    } catch (e) {
      showFlushBar(
        context: context,
        success: false,
        message: 'Unexpected error: $e',
        duration: 5,
      );
      return false;
    }
  }

  ///fetch the type of biometrics available/allowed on target device
  static Future<List<BiometricType>?> getBiometricTypes() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (_) {
      return <BiometricType>[];
    }
  }
}
