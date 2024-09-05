import 'package:recipe_app/model/myrecipe_info.dart';

class MyRecipeResponse {
  MyRecipeResponse({
    this.message,
    this.success,
    this.data,
  });

  bool? success;
  MyRecipeInfo? data;
  String? message;

  factory MyRecipeResponse.fromJson(Map<String, dynamic> json) =>
      MyRecipeResponse(
        message: json['message'],
        success: json["success"],
        data: json["data"] != null ? MyRecipeInfo.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}
