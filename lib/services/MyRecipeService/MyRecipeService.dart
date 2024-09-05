import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe_app/model/loginRegister_response.dart';
import 'package:recipe_app/model/myrecipe_info.dart';
import 'package:recipe_app/model/myrecipe_response.dart';
import 'package:recipe_app/model/myrecipe_responseL.dart';
import 'package:recipe_app/model/user.dart';

import 'package:recipe_app/services/ApiClient.dart';
import 'package:recipe_app/model/mobile_api_response.dart';

import 'IMyRecipeService.dart';

class MyRecipeService implements IMyRecipeService {
  ApiClient? _apiClient;
  MyRecipeService(ApiClient apiClient) {
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
  Future<MyRecipeResponse> addMyRecipe(MyRecipeInfo myRecipeInfo) async {
    Response response =
        await _apiClient!.postRequest("MyRecipe/AddMyRecipe", myRecipeInfo);
    return MyRecipeResponse.fromJson(response.data);
  }

  @override
  Future<MyRecipeResponse> deleteMyRecipe(int id) async {
    Response response =
        await _apiClient!.deleteRequest("MyRecipe/DeleteMyRecipe", id);
    return MyRecipeResponse.fromJson(response.data);
  }

  @override
  Future<MyRecipeResponseL> getUserMyRecipeList(int userId) async {
    Response response = await _apiClient!
        .getRequest("MyRecipe/GetUserMyRecipeList?userId=$userId");

    // API'den gelen veriyi `RecipeResponse` modeline dönüştürün
    if (response.data != null && response.data is Map<String, dynamic>) {
      return MyRecipeResponseL.fromJson(response.data);
    } else {
      throw Exception("Failed to load recipes");
    }
  }
}
