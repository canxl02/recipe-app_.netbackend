import 'dart:convert';

UserLogin deviceInformationFromJson(String str) =>
    UserLogin.fromJson(json.decode(str));

String deviceInformationToJson(UserLogin data) => json.encode(data.toJson());

class UserLogin {
  String password;
  String email;

  UserLogin({
    required this.password,
    required this.email,
  });

  factory UserLogin.fromJson(Map<String, dynamic> json) => UserLogin(
        password: json["password"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "email": email,
      };
}
