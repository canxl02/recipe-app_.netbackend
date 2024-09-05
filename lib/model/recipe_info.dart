class RecipeInfo {
  int id;
  String name;
  String ingredients;
  String instructions;
  String servings;
  String image;

  RecipeInfo({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.servings,
    required this.image,
  });

  factory RecipeInfo.fromJson(Map<String, dynamic> json) => RecipeInfo(
        id: json['id'],
        name: json["name"],
        ingredients: json["ingredients"],
        image: json["image"],
        instructions: json["instructions"],
        servings: json["servings"],
      );

  Map<String, dynamic> toJson() => {
        "ingredients": ingredients,
        "servings": servings,
        "instructions": instructions,
        "name": name,
        "id": id,
        "image": image
      };
}
