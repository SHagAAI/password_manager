import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwd_manager/screens/home_screen.dart';
import 'package:passwd_manager/screens/make_password_screen.dart';
import 'package:passwd_manager/screens/settings_screen.dart';

import '../controller.dart';

class MyBottomAppBar extends StatelessWidget {
  MyBottomAppBar({super.key});
  final Controller c = Get.find();
  
  static const List _widgetOptions = [
    HomeScreen.routeName,
    MakePasswordScreen.routeName,
    SettingScreen.routeName
  ];

  void _onTapped(int idx){
    Get.toNamed(_widgetOptions[idx]);
    

  }

  @override
  Widget build(BuildContext context) {
    
    return BottomNavigationBar(
      onTap: _onTapped,
      currentIndex: 0,
      items: const [
         BottomNavigationBarItem(
          icon: Icon(Icons.lock),
          label: "Password",
          
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.wifi_protected_setup_outlined),
          label: "Make Password",
          
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
          
        ),
      ],
    );

    // return Container(
    //   margin: const EdgeInsets.only(
    //     left: 50,
    //     right: 50,
    //     bottom: 50,
    //   ),
    //   color: Colors.transparent,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       BottomAppBarButton(
    //         bottomLeftRadii: const Radius.circular(9),
    //         bottomRightRadii: const Radius.circular(0),
    //         topLeftRadii: const Radius.circular(9),
    //         topRightRadii: const Radius.circular(0),
    //         rightMargin: 0.8,
    //         theIcon: Icons.lock,
    //         theText: 'Password',
    //         onTapEvent: () {
    //           control.jumpToPage(0);
    //         },
    //       ),
    //       BottomAppBarButton(
    //         bottomLeftRadii: const Radius.circular(0),
    //         bottomRightRadii: const Radius.circular(0),
    //         topLeftRadii: const Radius.circular(0),
    //         topRightRadii: const Radius.circular(0),
    //         rightMargin: 0.8,
    //         theIcon: Icons.wifi_protected_setup_outlined,
    //         theText: 'Generate',
    //         onTapEvent: () {
    //           Get.toNamed(MakePasswordScreen.routeName);
    //         },
    //       ),
    //       BottomAppBarButton(
    //         bottomLeftRadii: const Radius.circular(0),
    //         bottomRightRadii: const Radius.circular(9),
    //         topLeftRadii: const Radius.circular(0),
    //         topRightRadii: const Radius.circular(9),
    //         theIcon: Icons.settings,
    //         theText: 'Settings',
    //         onTapEvent: () {
    //           Get.toNamed(SettingScreen.routeName);
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}

class BottomAppBarButton extends StatelessWidget {
  final Radius topLeftRadii;
  final Radius topRightRadii;
  final Radius bottomLeftRadii;
  final Radius bottomRightRadii;
  final double? rightMargin;
  final IconData theIcon;
  final String theText;
  final VoidCallback onTapEvent;
  const BottomAppBarButton({
    super.key,
    required this.topLeftRadii,
    required this.topRightRadii,
    required this.bottomLeftRadii,
    required this.bottomRightRadii,
    this.rightMargin,
    required this.theIcon,
    required this.theText,
    required this.onTapEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      margin: EdgeInsets.only(
        right: rightMargin ?? 0,
      ),
      child: FilledButton(
        onPressed: onTapEvent,
        style: ButtonStyle(
          maximumSize: MaterialStateProperty.all(const Size(150, 100)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: bottomLeftRadii,
                bottomRight: bottomRightRadii,
                topLeft: topLeftRadii,
                topRight: topRightRadii,
              ),
            ),
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(theIcon),
              Center(
                  child: Text(
                theText,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
