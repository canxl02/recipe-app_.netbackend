import 'package:recipe_app/model/myrecipe_info.dart';

class MyRecipeResponseL {
  MyRecipeResponseL({
    this.message,
    this.success,
    this.data,
  });

  bool? success;
  List<MyRecipeInfo>? data;
  String? message;

  factory MyRecipeResponseL.fromJson(Map<String, dynamic> json) =>
      MyRecipeResponseL(
        message: json['message'],
        success: json["success"],
        data: json["data"] != null
            ? List<MyRecipeInfo>.from(
                json["data"].map((x) => MyRecipeInfo.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.map((MyRecipeInfo) => MyRecipeInfo.toJson()).toList,
      };
}
