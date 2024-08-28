// ignore_for_file: non_constant_identifier_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'package:recipe_app/myWidgets/my_list_tile.dart';
import 'package:recipe_app/screens/login_or_register_page.dart';
import 'package:recipe_app/screens/my_favs.dart';
import 'package:recipe_app/screens/my_recipes.dart';
import 'package:recipe_app/screens/user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyUser extends StatefulWidget {
  const MyUser({
    super.key,
  });

  @override
  State<MyUser> createState() => _MyUserState();
}

class _MyUserState extends State<MyUser> {
  logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isLogin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                child: Column(
                  children: [
                    Icon(
                      Icons.person,
                      size: 95,
                      color: Colors.black87,
                    ),
                  ],
                ),
              ),
              MyListTitle(
                icon: Icons.favorite_outlined,
                text: "My Favorites",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyFavs())),
              ),
              MyListTitle(
                icon: Icons.sticky_note_2_sharp,
                text: "My Recipes",
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyRecipes())),
              ),
              MyListTitle(
                icon: Icons.account_circle_sharp,
                text: "My Profile",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserScreen())),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MyListTitle(
              icon: Icons.logout,
              text: "Log Out",
              onTap: () {
                logOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginOrRegisterPage()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
