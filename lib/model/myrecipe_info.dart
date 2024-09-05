class MyRecipeInfo {
  int userId;

  String name;
  String ingredients;
  String instructions;
  String servings;
  String image;

  MyRecipeInfo({
    required this.userId,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.servings,
    required this.image,
  });

  factory MyRecipeInfo.fromJson(Map<String, dynamic> json) => MyRecipeInfo(
      name: json["name"],
      ingredients: json["ingredients"],
      image: json["image"],
      instructions: json["instructions"],
      servings: json["servings"],
      userId: json["userId"]);

  Map<String, dynamic> toJson() => {
        "ingredients": ingredients,
        "servings": servings,
        "instructions": instructions,
        "name": name,
        "image": image,
        "userId": userId
      };
}
