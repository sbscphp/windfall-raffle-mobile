class User {
  final String? uuid;
  final String? email;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? firstname;
  final String? lastname;
  final dynamic referrerId;
  final String? confirmResident;
  final String? platform;
  final dynamic merchant;
  final dynamic merchantId;
  final String? uniqueId;
  final String? referralCode;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final DateTime? lastLogin;
  final int? loginCount;
  final String? referralLink;
  final String? avatar;

  User({
    this.uuid,
    this.email,
    this.phoneNumber,
    this.dateOfBirth,
    this.firstname,
    this.lastname,
    this.referrerId,
    this.confirmResident,
    this.platform,
    this.merchant,
    this.merchantId,
    this.uniqueId,
    this.referralCode,
    this.updatedAt,
    this.createdAt,
    this.lastLogin,
    this.loginCount,
    this.referralLink,
    this.avatar
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    uuid: json["uuid"],
    email: json["email"],
    avatar: json["avatar"],
    phoneNumber: json["phone_number"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    firstname: json["firstname"],
    lastname: json["lastname"],
    referrerId: json["referrer_id"],
    confirmResident: json["confirm_resident"],
    platform: json["platform"],
    merchant: json["merchant"],
    merchantId: json["merchant_id"],
    uniqueId: json["uniqueID"],
    referralCode: json["referral_code"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    lastLogin: json["last_login"] == null ? null : DateTime.parse(json["last_login"]),
    loginCount: json["login_count"],
    referralLink: json["referral_link"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "email": email,
    "avatar": avatar,
    "phone_number": phoneNumber,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "firstname": firstname,
    "lastname": lastname,
    "referrer_id": referrerId,
    "confirm_resident": confirmResident,
    "platform": platform,
    "merchant": merchant,
    "merchant_id": merchantId,
    "uniqueID": uniqueId,
    "referral_code": referralCode,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "last_login": lastLogin?.toIso8601String(),
    "login_count": loginCount,
    "referral_link": referralLink,
  };
}