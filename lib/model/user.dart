import 'dart:convert';

User deviceInformationFromJson(String str) => User.fromJson(json.decode(str));

String deviceInformationToJson(User data) => json.encode(data.toJson());

class User {
  String name;
  String password;
  String email;
  String bio;
  String phoneNumber;

  User({
    required this.name,
    required this.password,
    required this.email,
    required this.bio,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json["name"],
      password: json["password"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      bio: json[" bio"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "email": email,
        "phoneNumber": phoneNumber,
        "bio": bio
      };
}
