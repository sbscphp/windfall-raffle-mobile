import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../data/enum/environment.dart';



class AppConfig {
  static late Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.dev:
        _config = _BaseUrlConfig.debugConstants;
        break;
      case Environment.staging:
        _config = _BaseUrlConfig.stagingConstants;
        break;
      case Environment.prod:
        _config = _BaseUrlConfig.prodConstants;
        break;
      case Environment.qa:
        _config = _BaseUrlConfig.qaConstants;
        break;
    }
  }

  static get baseUrl {
    return _config[_BaseUrlConfig.baseUrl];
  }

  static get payStackKey {
    return _config[_BaseUrlConfig.payStackKey];
  }
}

class _BaseUrlConfig {
  static const baseUrl = 'BaseUrl';
  static const payStackKey = 'PayStackPublicKey';

  static Map<String, dynamic> debugConstants = {
    baseUrl: dotenv.env['DEBUG_BASE_URL'],
    payStackKey: dotenv.env['DEBUG_PAY_STACK_KEY'],
  };

  static Map<String, dynamic> stagingConstants = {
    baseUrl: dotenv.env['STAGING_BASE_URL'],
    payStackKey: dotenv.env['STAGING_PAY_STACK_KEY'],
  };

  static Map<String, dynamic> qaConstants = {
    baseUrl: dotenv.env['QA_BASE_URL'],
    payStackKey: dotenv.env['QA_PAY_STACK_KEY'],
  };

  static Map<String, dynamic> prodConstants = {
    baseUrl: dotenv.env['PROD_BASE_URL'],
    payStackKey: dotenv.env['PROD_PAY_STACK_KEY'],
  };

}
