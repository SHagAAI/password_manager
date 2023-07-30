import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controller.dart';

class EditAccountData extends StatelessWidget {
  EditAccountData({super.key});
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.shade100.withOpacity(0.1),
      // height: 300,
      width: double.maxFinite,
      padding: const EdgeInsets.all(10),
      child: Form(
        key: c.formKey,
        child: Column(
          children: [
            TextFormField(
              
            ),
            
          ],
        ),
      ),
    );
  }
}
