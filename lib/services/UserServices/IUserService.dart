import 'package:recipe_app/model/loginRegister_response.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/model/userLogin.dart';
import 'package:recipe_app/services/IBaseService.dart';

abstract class IUserService extends IBaseService {
  Future<LoginRegisterResponse> addUser(User userInfo);
  Future<LoginRegisterResponse> loginUser(UserLogin userInfo);
}
