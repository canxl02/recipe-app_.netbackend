import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/model/myrecipe_response.dart';

import 'package:recipe_app/screens/my_recipe_viewer.dart';
import 'package:recipe_app/services/ApiClient.dart';
import 'package:recipe_app/services/MyRecipeService/MyRecipeService.dart';

class MyRecipes extends StatefulWidget {
  const MyRecipes({super.key});

  @override
  State<MyRecipes> createState() => _MyRecipesState();
}

class _MyRecipesState extends State<MyRecipes> {
  late Future<List<MyRecipeResponse>> _recipesFuture;
  MyRecipeService _myRecipeService = MyRecipeService(ApiClient());

  @override
  void initState() {
    super.initState();
    _recipesFuture = _myRecipeService.getUserMyRecipeList(1)
        as Future<List<MyRecipeResponse>>;
    // Kullanıcı ID'si
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "My Recipes",
          style: TextStyle(fontFamily: "hellix", color: Colors.black),
        ),
      ),
      body: FutureBuilder<List<MyRecipeResponse>>(
        future: _recipesFuture,
        builder: (BuildContext context,
            AsyncSnapshot<List<MyRecipeResponse>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No recipes found"));
          } else {
            List<MyRecipeResponse> recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                MyRecipeResponse recipe = recipes[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      tileColor: HexColor(backgroundColor),
                      trailing: IconButton(
                        onPressed: () {
                          showAlertDialog(context, index, recipes);
                        },
                        icon: const Icon(Icons.delete_forever),
                      ),
                      onTap: () {
                        Get.to(
                          () => const MyRecipeViewer(),
                          arguments: {"recipe": recipe},
                          transition: Transition.rightToLeft,
                        );
                      },
                      title: Text(recipe.data!.name),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void showAlertDialog(
      BuildContext context, int index, List<MyRecipeResponse> recipes) {
    Widget cancelButton = ElevatedButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = ElevatedButton(
        child: const Text("Yes"),
        onPressed: () async {
          /*
        var result = await _myRecipeService.deleteMyRecipe(recipes[index].data.id!);
        if (result.success) {
          setState(() {
            recipes.removeAt(index);
          });
        }
        Navigator.pop(context);
      },*/
        });

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Recipe"),
      content: const Text("Are you sure you want to delete this recipe?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
