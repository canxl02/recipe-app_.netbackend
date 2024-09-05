import 'package:dio/dio.dart';

import 'package:recipe_app/model/recipe_response.dart';

import 'package:recipe_app/services/ApiClient.dart';
import 'package:recipe_app/model/mobile_api_response.dart';

import 'IRecipeService.dart';

class RecipeService implements IRecipeService {
  ApiClient? _apiClient;

  RecipeService(ApiClient apiClient) {
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

  // RecipeService.dart içinde
  @override
  Future<RecipeResponse> getAllRecipes() async {
    Response response = await _apiClient!.getRequest("Recipe/GetAllRecipes");

    // API'den gelen veriyi `RecipeResponse` modeline dönüştürün
    if (response.data != null && response.data is Map<String, dynamic>) {
      return RecipeResponse.fromJson(response.data);
    } else {
      throw Exception("Failed to load recipes");
    }
  }
}
