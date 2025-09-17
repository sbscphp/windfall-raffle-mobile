class ConfigData {
  final RegistrationConfiguration? registrationConfiguration;
  final GameConfiguration? gameConfiguration;

  ConfigData({
    this.registrationConfiguration,
    this.gameConfiguration,
  });

  factory ConfigData.fromJson(Map<String, dynamic> json) => ConfigData(
    registrationConfiguration: json["registration_configuration"] == null ? null : RegistrationConfiguration.fromJson(json["registration_configuration"]),
    gameConfiguration: json["game_configuration"] == null ? null : GameConfiguration.fromJson(json["game_configuration"]),
  );

  Map<String, dynamic> toJson() => {
    "registration_configuration": registrationConfiguration?.toJson(),
    "game_configuration": gameConfiguration?.toJson(),
  };
}

class GameConfiguration {
  final bool? usePromoCode;
  final bool? useReferralAmount;

  GameConfiguration({
    this.usePromoCode,
    this.useReferralAmount,
  });

  factory GameConfiguration.fromJson(Map<String, dynamic> json) => GameConfiguration(
    usePromoCode: json["use_promo_code"],
    useReferralAmount: json["use_referral_amount"],
  );

  Map<String, dynamic> toJson() => {
    "use_promo_code": usePromoCode,
    "use_referral_amount": useReferralAmount,
  };
}

class RegistrationConfiguration {
  final bool? useLga;
  final bool? useLgaArea;
  final bool? verifyEmailOtp;

  RegistrationConfiguration({
    this.useLga,
    this.useLgaArea,
    this.verifyEmailOtp,
  });

  factory RegistrationConfiguration.fromJson(Map<String, dynamic> json) => RegistrationConfiguration(
    useLga: json["use_lga"],
    useLgaArea: json["use_lga_area"],
    verifyEmailOtp: json["verify_email_otp"],
  );

  Map<String, dynamic> toJson() => {
    "use_lga": useLga,
    "use_lga_area": useLgaArea,
    "verify_email_otp": verifyEmailOtp,
  };
}