import 'package:recipe_app/model/recipe_info.dart';

class RecipeResponse {
  RecipeResponse({
    this.message,
    this.success,
    this.data,
  });

  bool? success;
  List<RecipeInfo>? data;
  String? message;

  factory RecipeResponse.fromJson(Map<String, dynamic> json) => RecipeResponse(
        message: json['message'],
        success: json["success"],
        data: json["data"] != null
            ? List<RecipeInfo>.from(
                json["data"].map((x) => RecipeInfo.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.map((RecipeInfo) => RecipeInfo.toJson()).toList,
      };
}
