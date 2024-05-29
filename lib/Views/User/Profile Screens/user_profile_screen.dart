import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/main.dart';

import '../../../Controllers/user/insert_user_data_controller.dart';
import '../../Widgets/custom/confirm_dialog.dart';
import '../../Widgets/custom/custom_text_section.dart';
import 'insert_user_data_screen.dart';

// ignore: must_be_immutable
class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  static const routeName = '/user-profile-screen';
  InsertUserDataController controller = Get.put(InsertUserDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
          title: const Text('الملف الشخصي'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Get.toNamed(InsertUserDataScreen.routeName);
              },
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Get.defaultDialog(
                  title: 'تسجيل الخروج',
                  content: ConfirmTripDialog(
                    title: 'هل تريد تسجيل الخروج؟',
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () {
                      FirebaseAuth.instance.signOut();
                      prefs!.clear();
                      Get.offAllNamed('/loginScreen');
                    },
                  ));
            },
          )),
      body: GetBuilder<InsertUserDataController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Image.asset(
                'assets/images/profile.png',
                width: 150,
                height: 150,
              ),

              TextSection(
                text: 'اسم المستخدم  : ${controller.nameController.text}',
              ),
              TextSection(
                text: 'رقم التواصل : ${controller.phoneController.text}',
              ),
              // capacity

              // driver gender
              TextSection(
                text: ' الجنس : ${controller.gender == true ? "ذكر" : "أنثى"}',
              ),
            ],
          )),
        );
      }),
    );
  }
}
