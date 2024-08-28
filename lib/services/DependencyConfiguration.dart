import 'package:get_it/get_it.dart';
import 'package:recipe_app/services/ApiClient.dart';
import 'package:recipe_app/services/UserServices/UserService.dart';

GetIt getIt = GetIt.instance;
void configureInjection() {
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());
  getIt.registerLazySingleton<UserService>(
      () => UserService(getIt<ApiClient>()));
}
