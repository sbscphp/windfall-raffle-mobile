import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:windfall/core/data/models/responses/response_data/login_data.dart';
import 'package:windfall/core/utilities/secure_storage/secure_storage_init.dart';
import '../../constants/secure_storage_constants.dart';
import '../../data/models/user.dart';


class SecureStorageUtils{

  //todo:REFACTOR CLASS

  ///retrieve token
  static Future<String?> retrieveToken() async{
    return SecureStorageInit.storage.read(key: SecuredStorageConstants.token);
  }

  ///save guest token
  static saveGuestToken({required String? value}) async{
    SecureStorageInit.storage.write(key: SecuredStorageConstants.guestToken, value: value);
  }

  ///retrieve guest token
  static Future<String?> retrieveGuestToken() async{
    final pref = await SecureStorageInit.storage.read(key: SecuredStorageConstants.guestToken);
    return pref;
  }

  ///save passcode
  static saveToken({required String token}) async{
    await SecureStorageInit.storage.write(key: SecuredStorageConstants.token, value: token);
  }

  ///retrieve refresh token
  static Future<String?> retrieveRefreshToken() async {
    return SecureStorageInit.storage.read(key: SecuredStorageConstants.refreshToken);
  }

  static Future<void> saveRefreshToken({required String refreshToken}) async {
    await SecureStorageInit.storage.write(key: SecuredStorageConstants.refreshToken, value: refreshToken);
  }

  ///save user details
  static saveUser({required String user}) async{
    SecureStorageInit.storage.write(key: SecuredStorageConstants.user, value: user);
  }

  ///retrieve user details
  static Future<User?> retrieveUser() async{
    final userString = await SecureStorageInit.storage.read(key: SecuredStorageConstants.user);
    if(userString != null) {
      final user = User.fromJson(json.decode(userString));
      return user;
    }
    return null;
  }

  ///save password
  static savePassword({required String? value}) async{
    SecureStorageInit.storage.write(key: SecuredStorageConstants.password, value: value);
  }

  ///save passkey
  static savePasskey({required String? value}) async{
    SecureStorageInit.storage.write(key: SecuredStorageConstants.passkey, value: value);
  }

  ///retrieve password
  static Future<String?> retrievePassword() async{
    final pref = await SecureStorageInit.storage.read(key: SecuredStorageConstants.password);
    return pref;
  }

  ///retrieve passkey
  static Future<String?> retrievePasskey() async{
    final pref = await SecureStorageInit.storage.read(key: SecuredStorageConstants.passkey);
    return pref;
  }

  // ///retrieve user details
  // static Future<User?> retrieveUser() async{
  //   final userString = await SecureStorageInit.storage.read(key: SecuredStorageConstants.user);
  //   if(userString != null) {
  //     final user = User.fromJson(json.decode(userString));
  //     return user;
  //   }
  //   return null;
  // }

  ///saves biometrics flag
  static biometricsEnabled() async{
    SecureStorageInit.storage.write(key: SecuredStorageConstants.biometricStatus, value: 'true');
  }

  // ///retrieves 'biometrics status flag'
  // static Future<bool> isBiometricsEnabled() async{
  //   final seen = await SecureStorageInit.storage.read(key: SecuredStorageConstants.biometricStatus);
  //   return seen == 'true' ?  true : false;
  // }

  ///retrieves 'biometrics pref'
  static Future<bool> retrieveBiometricPref() async{
    final pref = await SecureStorageInit.storage.read(key: SecuredStorageConstants.biometricPref);
    if(pref == null)return false;
    return pref == 'true' ?  true : false;
  }

  ///saves biometrics pref
  static saveAuthStatus({required bool value}) async{
    SecureStorageInit.storage.write(key: SecuredStorageConstants.authStatus, value: value == true ? 'true':'false');
  }

  ///retrieves 'auth status'
  static Future<bool> retrieveAuthStatus() async{
    final pref = await SecureStorageInit.storage.read(key: SecuredStorageConstants.authStatus);
    if(pref == null)return false;
    return pref == 'true' ?  true : false;
  }

  ///saves biometrics pref
  static saveBiometricsPref({required bool? value}) async{
    print('pref to save::::::$value>>>>');
    SecureStorageInit.storage.write(key: SecuredStorageConstants.biometricPref, value: value == true ? 'true':'false');
  }


  static saveUserDetailsToStorage({required LoginData? response, required String password})async{

    //save token
    await SecureStorageUtils.saveToken(token: response?.accessToken ?? '');

    //save password
    await SecureStorageUtils.savePassword(value: password);

    //save auth status
    await SecureStorageUtils.saveAuthStatus(value: true);

    //retrieve saved user
    final savedUser = await SecureStorageUtils.retrieveUser();

    if(savedUser == null || (savedUser.phoneNumber != response?.user?.phoneNumber)){

      //update data in secure storage
      //await SecureStorageUtils.savePasskey(value: null);
      //await SecureStorageUtils.saveSavingsStatBalPref(value: null);
      //await SecureStorageUtils.saveInvestmentBalPref(value: null);
      //await SecureStorageUtils.saveAccountBalPref(value: null);
      //await SecureStorageUtils.saveBiometricsPref(value: null);
    }

    if(response?.user != null){
      //convert user to string
      final userString = json.encode(response?.user?.toJson());

      //save user
      await SecureStorageUtils.saveUser(user: userString);

      //save password
      await SecureStorageUtils.savePassword(value: password);

      await Future.delayed(const Duration(seconds: 2));
    }
  }




  ///delete all records
  static deleteAll() async{
    SecureStorageInit.storage.deleteAll();
  }

  ///delete a particular key

  static deleteKey({required String key}) async{
    SecureStorageInit.storage.delete(key: key);
    debugPrint('$key deleted>>>>>>');
  }


}