import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../model/my_account.dart';

class MyBottomSheet extends StatefulWidget {
  final MyAccount myAcc;

  const MyBottomSheet({
    super.key,
    required this.myAcc,
  });

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  bool isVisible = false;

  changePaswwordVisibility(){
    isVisible = !isVisible;
    setState(() {
      
    });
  }

  void callSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(milliseconds: 900),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 300,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 15,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.myAcc.title!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          Divider(color: Colors.grey.shade300),
          Container(
            height: 80,
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    
                    children: [
                      const Icon(Icons.person_rounded),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.myAcc.loginUsername!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.myAcc.password!));
                      callSnackBar('Copied !', 'Username copied to clipboard');
                    },
                    
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            width: double.maxFinite,
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: changePaswwordVisibility,
                        icon: isVisible ? const Icon(Icons.lock_outline) : const Icon(Icons.lock_open_rounded),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        isVisible ? widget.myAcc.password! : '* * * * * * * * * * * * * * * *',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.myAcc.password!));
                      callSnackBar('Copied !', 'Password copied to clipboard');
                    },
                    icon: const Icon(Icons.copy),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
