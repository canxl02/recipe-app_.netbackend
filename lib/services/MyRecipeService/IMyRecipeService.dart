import 'package:recipe_app/model/myrecipe_info.dart';
import 'package:recipe_app/model/myrecipe_response.dart';
import 'package:recipe_app/model/myrecipe_responseL.dart';

import 'package:recipe_app/services/IBaseService.dart';

abstract class IMyRecipeService extends IBaseService {
  Future<MyRecipeResponse> addMyRecipe(MyRecipeInfo myRecipeInfo);
  Future<MyRecipeResponseL> getUserMyRecipeList(int userId);
  Future<MyRecipeResponse> deleteMyRecipe(int id);
}
