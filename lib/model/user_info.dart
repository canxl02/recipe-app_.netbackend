class UserInfo {
  String name;
  String password;
  String email;
  String bio;
  String phoneNumber;
  int id;

  UserInfo({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.bio,
    required this.phoneNumber,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
      id: json["id"],
      name: json["name"],
      password: json["password"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      bio: json["bio"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "email": email,
        "phoneNumber": phoneNumber,
        "bio": bio
      };
}
