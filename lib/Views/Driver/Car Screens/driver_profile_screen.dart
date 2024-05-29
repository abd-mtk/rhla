import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/Views/Widgets/custom/confirm_dialog.dart';

import '../../../Controllers/driver/driver_profile_controller.dart';
import '../../../main.dart';
import '../../Constants/fonts/fonts.dart';
import '../../Widgets/custom/custom_text_section.dart';
import 'insert_driver_data_screen.dart';

// ignore: must_be_immutable
class DriverProfileScreen extends StatelessWidget {
  DriverProfileScreen({super.key});
  static const String routeName = '/DriverProfileScreen';

  DriverProfileController controller = Get.put(DriverProfileController());

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
                Get.toNamed(InsertDriverDataScreen.routeName);
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
      body: GetBuilder<DriverProfileController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
              child: controller.car != null
                  ? Column(
                      children: [
                        Image.asset(
                          controller.cars[controller.carTypes
                              .indexOf(controller.car!.type)],
                          fit: BoxFit.scaleDown,
                          width: 200,
                          height: 200,
                        ),
                        const Text(
                          'معلومات المركبة',
                          style: titleTextStyle,
                        ),
                        TextSection(
                          text:
                              'النوع : ${controller.car!.type == "سيارة" ? "صالون" : controller.car!.type}',
                        ),
                        TextSection(
                          text: 'الموديل : ${controller.car!.model}',
                        ),
                        TextSection(
                          text: 'اللون : ${controller.car!.color}',
                        ),
                        TextSection(
                          text: 'رقم اللوحة : ${controller.car!.plateNumber}',
                        ),
                        // capacity
                        TextSection(
                          text: 'السعة : ${controller.car!.capacity} راكب',
                        ),
                        // driver gender
                        TextSection(
                          text:
                              'جنس السائق : ${controller.car!.driverGender == true ? "ذكر" : "أنثى"}',
                        ),
                      ],
                    )
                  : const Center(
                      child: Text('لا يوجد معلومات مسجلة'),
                    )),
        );
      }),
    );
  }
}
