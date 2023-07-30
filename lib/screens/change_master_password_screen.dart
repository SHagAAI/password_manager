import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwd_manager/controller.dart';
import 'package:passwd_manager/screens/home_screen.dart';

class ChangeMasterPasswordScreen extends StatelessWidget {
  ChangeMasterPasswordScreen({super.key});
  static const routeName = '/change-master-password';
  final Controller c = Get.find<Controller>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController retypeNewPasswordController =
      TextEditingController();

  callALertDialog(String message) {
    Get.dialog(
      transitionCurve: Curves.fastEaseInToSlowEaseOut,
      AlertDialog(
        title: const Text("Failed !"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("Close"))
        ],
      ),
    );
  }

  void updateMasterPassword(
      String oldPassword, String newPassword, String retype) async {
    if (await c.updatePin(newPassword, oldPassword)) {
      Get.offAllNamed(HomeScreen.routeName);
      return;
    }

    callALertDialog("Failed to update master password");
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState>? myKey = c.masterPasswordKey;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: myKey,
          child: Column(
            children: [
              TextFormField(
                controller: oldPasswordController,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  hintText: "Type your old password",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2)),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: newPasswordController,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  hintText: "Type New Password",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill your password';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: retypeNewPasswordController,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: const InputDecoration(
                  hintText: "Retype your new password",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2)),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please fill your password';
                  }

                  if (value != newPasswordController.text) {
                    return 'New password doesn\'t match';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 35,
              ),
              SizedBox(
                width: double.infinity,
                height: 90,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    side: const BorderSide(
                      color: Colors.deepPurple,
                      width: 2,
                    )
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    if (myKey!.currentState!.validate()) {
                      updateMasterPassword(
                          oldPasswordController.text,
                          newPasswordController.text,
                          retypeNewPasswordController.text);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
