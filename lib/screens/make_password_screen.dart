import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwd_manager/model/my_account.dart';
import 'package:passwd_manager/screens/home_screen.dart';

import '../controller.dart';

class MakePasswordScreen extends StatefulWidget {
  static const routeName = '/password-making';
  const MakePasswordScreen({super.key});

  @override
  State<MakePasswordScreen> createState() => _MakePasswordScreenState();
}

class _MakePasswordScreenState extends State<MakePasswordScreen> {
  MyAccount? myAcc;
  Controller c = Get.find<Controller>();
  PageController? controller;
  GlobalKey<FormState>? myKey;
  final TextEditingController title = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void initState() {
    super.initState();
    myKey = c.makePasswordKey;

    controller = c.pageController;
    myAcc = Get.arguments;
  }

  @override
  void dispose() {
    super.dispose();

    title.dispose();
    username.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (myAcc != null) {
      title.text = myAcc!.title!;
      username.text = myAcc!.loginUsername!;
      password.text = myAcc!.password!;
    }

    return Scaffold(
      appBar: AppBar(
        title: myAcc != null
            ? const Text('Edit Password')
            : const Text('New Password'),
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: myKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  controller: title,
                  decoration: const InputDecoration(hintText: 'Title'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill your Title';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: username,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      const InputDecoration(hintText: 'Name or Username'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: password,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(hintText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill your password';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 100,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 90,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      splashFactory: InkRipple.splashFactory,
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () {
                      if (myKey!.currentState!.validate()) {
                        if (myAcc == null) {

                          // FOR MAKING NEW DATA
                          MyAccount mAC = MyAccount(
                              title.text, username.text, password.text);

                          c.addNewAccountData(mAC);
                          return;
                        } else {
                          // FOR UPDATING DATA
                          myAcc!.title = title.text;
                          myAcc!.loginUsername = username.text;
                          myAcc!.password = password.text;

                          c.updateAccountData(myAcc!);
                        }

                        FocusManager.instance.primaryFocus?.unfocus();
                        Get.offAndToNamed(HomeScreen.routeName);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
