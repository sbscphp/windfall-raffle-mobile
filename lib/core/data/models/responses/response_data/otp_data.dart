class OtpData {
  final String? userId;
  final String? otp;
  final String? identifier;

  OtpData({
    this.userId,
    this.otp,
    this.identifier,
  });

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
    userId: json["user_id"],
    otp: json["otp"],
    identifier: json["identifier"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "otp": otp,
    "identifier": identifier,
  };
}