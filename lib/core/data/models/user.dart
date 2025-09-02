import 'notification_setting.dart';

class User {
  final String? uuid;
  final String? uniqueId;
  final String? email;
  final String? phoneNumber;
  final dynamic avatar;
  final String? firstname;
  final String? lastname;
  final DateTime? dateOfBirth;
  final dynamic lga;
  final dynamic area;
  final dynamic spendLimitStatus;
  final String? referralCode;
  final String? referralLink;
  final String? referralBalance;
  final dynamic exclusionType;
  final dynamic excludeTill;
  final NotificationSetting? notificationSetting;

  User({
    this.uuid,
    this.uniqueId,
    this.email,
    this.phoneNumber,
    this.avatar,
    this.firstname,
    this.lastname,
    this.dateOfBirth,
    this.lga,
    this.area,
    this.spendLimitStatus,
    this.referralCode,
    this.referralLink,
    this.referralBalance,
    this.exclusionType,
    this.excludeTill,
    this.notificationSetting,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uuid: json["uuid"],
    uniqueId: json["uniqueID"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    avatar: json["avatar"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    lga: json["lga"],
    area: json["area"],
    spendLimitStatus: json["spend_limit_status"],
    referralCode: json["referral_code"],
    referralLink: json["referral_link"],
    referralBalance: json["referral_balance"],
    exclusionType: json["exclusion_type"],
    excludeTill: json["exclude_till"],
    notificationSetting: json["notification_setting"] == null ? null : NotificationSetting.fromJson(json["notification_setting"]),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "uniqueID": uniqueId,
    "email": email,
    "phone_number": phoneNumber,
    "avatar": avatar,
    "firstname": firstname,
    "lastname": lastname,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "lga": lga,
    "area": area,
    "spend_limit_status": spendLimitStatus,
    "referral_code": referralCode,
    "referral_link": referralLink,
    "referral_balance": referralBalance,
    "exclusion_type": exclusionType,
    "exclude_till": excludeTill,
    "notification_setting": notificationSetting?.toJson(),
  };
}
