import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwd_manager/screens/change_master_password_screen.dart';

import 'package:passwd_manager/screens/home_screen.dart';
import 'package:passwd_manager/screens/login_screen.dart';
import 'package:passwd_manager/screens/make_password_screen.dart';
import 'package:passwd_manager/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      home: const LoginScreen(),
      getPages: [
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: MakePasswordScreen.routeName,
          page: () => const MakePasswordScreen(),
        ),
        GetPage(
          name: SettingScreen.routeName,
          page: () => const SettingScreen(),
        ),
        GetPage(
          name: ChangeMasterPasswordScreen.routeName,
          page: () => ChangeMasterPasswordScreen(),
        ),
      ],
    );
  }
}
