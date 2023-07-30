import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwd_manager/widgets/account_cards.dart';

import '../controller.dart';
import '../widgets/my_bottom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    // Close the keyboard somehow
    FocusManager.instance.primaryFocus?.unfocus();

    return Scaffold(
      extendBody: true,
      bottomNavigationBar: MyBottomAppBar(),
      body: Column(
        children: [
          GetBuilder<Controller>(
            builder: (controller) {
              return FutureBuilder(
                future: controller.getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!
                          .map((e) => AccountCards(
                                account: e,
                              ))
                          .toList(),
                    );
                  }

                  return Container();
                },
              );
            },
          ),
          // MyBottomAppBar(),
        ],
      ),
    );
  }
}
