import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwd_manager/controller.dart';
import 'package:passwd_manager/model/my_pin.dart';
import 'package:passwd_manager/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController myTextController = TextEditingController();
  final Controller c = Get.find();
  final List makePassword = [];
  PinModel? pinChecker;

  bool validatePin(String pin) {
    if (c.validateInputPin(pin)) {
      return true;
    }

    return false;
    
  }

  void makePin(String pin) {
    myTextController.clear();
    makePassword.add(pin);

    if (makePassword.length == 2) {
      if (makePassword[0] == makePassword[1]) {
        

        c.makeNewPin(pin);
        Get.offAndToNamed(HomeScreen.routeName);
      }
      makePassword.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('Cek isinya $pinChecker');
    return Center(
      child: Scaffold(
          body: FutureBuilder(
        future: c.getPin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (makePassword.isEmpty && snapshot.data == null)
                      ? 'Make New Pin'
                      : 'Type Your Pin',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: c.formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: myTextController,
                        obscuringCharacter: '*',
                        obscureText: true,
                        
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.deepPurple.shade50,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.deepPurple.shade200,
                            )),
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.deepPurple.shade200,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.deepPurple.shade200,
                            )),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide(
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(0.09),
                                ))),
                                onFieldSubmitted: (_) {
                                  c.formKey.currentState.validate();
                                },
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            if (validatePin(value)) {
                              Get.offAndToNamed(HomeScreen.routeName);
                            }
                            myTextController.clear();
                            return 'Wrong PIN';
                          }
                          return 'Enter PIN';
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
