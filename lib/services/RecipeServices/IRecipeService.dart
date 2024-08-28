import 'package:recipe_app/model/recipe_response.dart';

import 'package:recipe_app/services/IBaseService.dart';

abstract class IRecipeService extends IBaseService {
  Future<RecipeResponse> getAllRecipes();
}
