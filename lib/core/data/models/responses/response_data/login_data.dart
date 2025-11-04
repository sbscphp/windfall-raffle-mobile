import '../../user.dart';

class LoginData {
  final String? accessToken;
  final String? tokenType;
  final int? expiresIn;
  final User? user;
  final String? refreshToken;

  LoginData({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
    this.user,
    this.refreshToken
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
    accessToken: json["access_token"],
    refreshToken: json['refresh_token'],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
    "user": user?.toJson(),
  };
}