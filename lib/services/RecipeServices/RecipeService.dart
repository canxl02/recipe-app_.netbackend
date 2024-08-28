import 'package:dio/dio.dart';
import 'package:recipe_app/model/login_response.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/model/recipe_response.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/model/userLogin.dart';
import 'package:recipe_app/services/ApiClient.dart';
import 'package:recipe_app/model/mobile_api_response.dart';

import 'IRecipeService.dart';

class Recipeservice implements IRecipeService {
  ApiClient? _apiClient;
  UserService(ApiClient apiClient) {
    _apiClient = apiClient;
    _apiClient!.onResponseCallback = this.onResponseCallback;
    _apiClient!.onErrorCallback = this.onErrorCallback;
  }

  @override
  onResponseCallback(MobileApiResponse response) {
    print("Success: ${response.success}");
  }

  @override
  onErrorCallback(MobileApiResponse response) {
    print('Error: ${response.errorMessage}');
    // Belki burada bir kullanıcıya hata mesajı gösterme işlemi yapılabilir
  }

  @override
  Future<RecipeResponse> getAllRecipes() async {
    Response response = await _apiClient!.getRequest("Recipe/GetAllRecipes");
    return RecipeResponse.fromJson(response.data);
  }
}
