import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/model/myrecipe_info.dart';
import 'package:recipe_app/model/myrecipe_response.dart';
import 'package:recipe_app/screens/my_recipes.dart';
import 'package:recipe_app/services/ApiClient.dart';

import 'package:recipe_app/services/MyRecipeService/MyRecipeService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({super.key});

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  var uuid = const Uuid();
  TextEditingController titleController = TextEditingController();
  TextEditingController servingsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();

  bool _isLoading = false;
  int? userId; // Nullable user ID

  @override
  void initState() {
    super.initState();
    _userPreferences(); // Load user ID on screen initialization
  }

  void _userPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId'); // No null check operator here
    });
  }

  Future<void> _saveRecipe() async {
    if (userId == null) {
      // Handle case where user ID is not set
      print("User ID not found.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('User not logged in, cannot save recipe.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    MyRecipeInfo newRecipe = MyRecipeInfo(
      userId: userId!, // Now safe to use `!` because we've checked if it's null
      name: titleController.text,
      ingredients: ingredientsController.text,
      instructions: instructionsController.text,
      servings: servingsController.text,
      image: 'lib/assets/images/image_m.jpg', // Placeholder image
    );

    MyRecipeService myRecipeService = MyRecipeService(ApiClient());
    MyRecipeResponse response = await myRecipeService.addMyRecipe(newRecipe);

    setState(() {
      _isLoading = false;
    });

    if (response.success!) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyRecipes()),
      );
    } else {
      // Show error message if recipe save fails
      print("Recipe could not be saved: ${response.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;
    double deviceHeight = MediaQuery.sizeOf(context).height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: deviceWidth,
                      height: deviceHeight / 6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Colors.grey,
                      ),
                      child: const Center(
                        child: Text(
                          "Add new recipe",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: "hellix"),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Recipe Title:",
                                style: TextStyle(
                                    fontFamily: "hellix", fontSize: 20),
                              ),
                              Container(
                                width: deviceWidth / 2,
                                height: deviceHeight / 10,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: HexColor(backgroundColor),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextField(
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  controller: titleController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 8, bottom: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Servings:",
                                style: TextStyle(
                                    fontFamily: "hellix", fontSize: 20),
                              ),
                              Container(
                                width: deviceWidth / 2,
                                height: deviceHeight / 10,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: HexColor(backgroundColor),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: TextField(
                                  onTapOutside: (event) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  },
                                  controller: servingsController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15, top: 8, bottom: 8, left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ingredients:",
                          style: TextStyle(fontFamily: "hellix", fontSize: 20),
                        ),
                        Container(
                          width: deviceWidth,
                          height: deviceHeight / 10,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            color: HexColor(backgroundColor),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            controller: ingredientsController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Instructions:",
                          style: TextStyle(fontFamily: "hellix", fontSize: 20),
                        ),
                        Container(
                          height: deviceHeight / 4,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 8),
                          decoration: BoxDecoration(
                            color: HexColor(backgroundColor),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: TextField(
                            onTapOutside: (event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            controller: instructionsController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: HexColor(myGreen)),
                      onPressed: _isLoading ? null : _saveRecipe,
                      child: const Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Lottie.asset(
                    'lib/assets/animations/Animation - 1724239121865.json',
                    width: 400,
                    height: 400,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
