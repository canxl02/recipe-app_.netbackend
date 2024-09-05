import 'package:flutter/material.dart';
import 'package:recipe_app/model/loginRegister_response.dart';
import 'package:recipe_app/model/userLogin.dart';
import 'package:recipe_app/myWidgets/my_buttonA.dart';
import 'package:recipe_app/myWidgets/my_textfieldA.dart';
import 'package:recipe_app/screens/bottom_navigation_bar.dart';
import 'package:recipe_app/screens/login_or_register_page.dart';
import 'package:recipe_app/services/DependencyConfiguration.dart';
import 'package:recipe_app/services/UserServices/UserService.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool isLogin;
  int? userId;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final UserService _userService = getIt.get<UserService>();

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool('isLogin') ?? false;
      userId = prefs.getInt("userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // logo
                const Icon(
                  Icons.food_bank_rounded,
                  size: 100,
                ),

                const SizedBox(height: 50),

                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                      fontFamily: "hellix"),
                ),

                const SizedBox(height: 25),

                MyTextfielda(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                MyTextfielda(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                const SizedBox(height: 25),

                MyButtona(
                  text: "Sign In",
                  onTap: () async {
                    LoginRegisterResponse apiResponse =
                        await _userService.loginUser(UserLogin(
                      password: _passwordController.text,
                      email: _emailController.text,
                    ));

                    if (apiResponse.success!) {
                      final prefs = await SharedPreferences.getInstance();
                      // Store the user ID and login state in SharedPreferences
                      prefs.setBool('isLogin', true);
                      prefs.setInt('userId', apiResponse.data!.id);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomnavigationBar()));
                    } else {
                      // If login fails, navigate to the login or register page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginOrRegisterPage()));
                    }
                  },
                ),

                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // not a member? register now
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member?',
                        style: TextStyle(color: Colors.grey[700], fontSize: 16),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
