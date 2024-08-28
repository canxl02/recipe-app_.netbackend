import 'package:recipe_app/model/user_info.dart';

class LoginRegisterResponse {
  LoginRegisterResponse({
    this.message,
    this.success,
    this.data,
  });

  bool? success;
  UserInfo? data;
  String? message;

  factory LoginRegisterResponse.fromJson(Map<String, dynamic> json) =>
      LoginRegisterResponse(
        message: json['message'],
        success: json["success"],
        data: json["data"] != null ? UserInfo.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}
