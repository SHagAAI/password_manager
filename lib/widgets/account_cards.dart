
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'my_bottom_sheet.dart';
import '../model/my_account.dart';
import '../screens/make_password_screen.dart';

class AccountCards extends StatelessWidget {
  final MyAccount account;
  AccountCards({super.key, required this.account});

  String get firstLetter => account.title!.substring(0, 1).toUpperCase();
  final Controller c = Get.put(Controller());

  void callSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 900),
    );
  }

  void editData() {
    Get.toNamed(MakePasswordScreen.routeName, arguments: account);
  }

  void deleteThisAccount(MyAccount deleteThisAccount) {
    c.deleteAccountData(deleteThisAccount);
  }

  void callBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      barrierColor: Colors.transparent,
      builder: (context) {
        return MyBottomSheet(myAcc: account,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callBottomSheet(context),
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.deepPurpleAccent.withAlpha(100),
                    maxRadius: 34,
                    foregroundColor: Colors.black38,
                    child: Text(
                      firstLetter,
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.title!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.black.withAlpha(166)),
                      ),
                      Text(
                        account.loginUsername!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    onTap: editData,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        // const SizedBox(width: 5,),
                        Icon(
                          Icons.edit,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        // const SizedBox(width: 5,),
                        Icon(
                          Icons.delete_outlined,
                          color: Colors.red.shade400,
                        ),
                      ],
                    ),
                    onTap: () {
                      deleteThisAccount(account);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


