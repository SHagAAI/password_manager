import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwd_manager/screens/change_master_password_screen.dart';
import 'package:passwd_manager/screens/login_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  static const routeName = "/settings-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),

      body: Container(
        color: Colors.grey[300],
        padding: const EdgeInsets.all(18),
        child: SafeArea(
          child: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MyBackButton(),
                const Text(
                  "General Settings",
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w500),
                ),
                const Text(
                  "Change Password",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                 ChangePasswordSection(
                  detail: const Text(
                    "Change Login Password",
                    style: TextStyle(fontSize: 15),
                  ),
                  buttonText: "Change Password",
                  buttonColor: Colors.deepPurple,
                  onTapFunction: (){
                    Get.toNamed(ChangeMasterPasswordScreen.routeName);
                  },
                ),
                
                const Text(
                  "Logout",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                ChangePasswordSection(
                  detail: const Text(
                    "Sign out for now",
                    style: TextStyle(fontSize: 15),
                  ),
                  buttonText: "Sign Out",
                  buttonColor: Colors.red.shade500,
                  onTapFunction: (){
                    Get.offAllNamed(LoginScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChangePasswordSection extends StatelessWidget {
  final Text detail;
  final String buttonText;
  final Color buttonColor;
  final VoidCallback onTapFunction;
  const ChangePasswordSection({
    super.key,
    required this.detail, required this.buttonText, required this.buttonColor, required this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        detail,
        TextButton(
            onPressed: onTapFunction,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.transparent;
                }
                return Colors.transparent;
              }),
              iconColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.transparent;
                }
                return Colors.transparent;
              }),
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Colors.grey;
                }
                return buttonColor;
              }),
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            )),
      ],
    );
  }
}

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.only(left: 0, right: 5),
      ),
      onPressed: () {
        Get.back();
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.arrow_back_ios_new),
          Text("Back"),
        ],
      ),
    );
  }
}
