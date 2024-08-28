import 'package:flutter/material.dart';
import 'package:recipe_app/model/login_response.dart';
import 'package:recipe_app/model/user.dart';
import 'package:recipe_app/myWidgets/my_buttonA.dart';
import 'package:recipe_app/myWidgets/my_textfieldA.dart';
import 'package:recipe_app/screens/bottom_navigation_bar.dart';
import 'package:recipe_app/screens/login_or_register_page.dart';
import 'package:recipe_app/services/DependencyConfiguration.dart';
import 'package:recipe_app/services/UserServices/UserService.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _bioController = TextEditingController();

  final UserService _userService = getIt.get<UserService>();

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
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontFamily: "hellix",
                  ),
                ),

                const SizedBox(height: 25),

                MyTextfielda(
                  controller: _nameController,
                  hintText: 'Name',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                MyTextfielda(
                  controller: _numberController,
                  hintText: 'Phone Number',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

                MyTextfielda(
                  controller: _bioController,
                  hintText: 'Bio',
                  obscureText: false,
                ),

                const SizedBox(height: 10),

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

                const SizedBox(height: 25),

                MyButtona(
                  text: "Sign Up",
                  onTap: () async {
                    LoginRegisterResponse apiResponse =
                        await _userService.addUser(User(
                            name: _nameController.text,
                            password: _passwordController.text,
                            email: _emailController.text,
                            bio: _bioController.text,
                            phoneNumber: _numberController.text));

                    if (apiResponse.success!) {
                      final prefs = await SharedPreferences.getInstance();

                      prefs.setBool('isLogin', true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomnavigationBar()));
                    } else {
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
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
