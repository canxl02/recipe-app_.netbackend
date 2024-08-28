class RecipeResponse {
  int id;
  String name;
  String ingredients;
  String instructions;
  String servings;
  String image;

  RecipeResponse({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.servings,
    required this.image,
  });

  factory RecipeResponse.fromJson(Map<String, dynamic> json) => RecipeResponse(
        id: json['id'],
        name: json["name"],
        ingredients: json["ingredients"],
        image: json["ingredients"],
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