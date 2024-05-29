import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/Views/Driver/driver_home_screen.dart';

import '../../Views/Driver/Car Screens/insert_driver_data_screen.dart';
import '../../Views/User/Profile Screens/insert_user_data_screen.dart';
import '../../Views/User/user_home_screen.dart';
import '../../main.dart';

class SelectModeControler extends GetxController {
  bool isDriverMode = false;
  bool isPassengerMode = false;

  @override
  void onInit() async {
    super.onInit();
    isDriverMode = prefs!.getBool('userType') ?? false;
    isPassengerMode = !isDriverMode;
    update();
  }

  void selectDriver() async {
    isDriverMode = true;
    isPassengerMode = false;
    prefs!.setBool('userType', isDriverMode);
    if (await isDriver()) {
      Get.offAllNamed(DriverHomeScreen.routeName);
    } else {
      Get.snackbar(
          '                                                             تنبيه',
          '                                     يجب اضافة معلومات السيارة اولاً',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.transparent,
          colorText: Colors.black);
      Get.toNamed(InsertDriverDataScreen.routeName);
    }
    update();
  }

  void selectPassenger() async {
    isDriverMode = false;
    isPassengerMode = true;
    prefs!.setBool('userType', isDriverMode);
    if (await userHaveInformation()) {
      Get.offAllNamed(UserHomeScreen.routeName);
    } else {
      Get.snackbar(
          '                                                             تنبيه',
          '                                     يجب اضافة معلومات المستخدم اولاً',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.transparent,
          colorText: Colors.black);
      Get.toNamed(InsertUserDataScreen.routeName);
    }
    update();
  }

  Future<bool> isDriver() async {
    bool isDriver = false;
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!.containsKey('car')) {
        isDriver = true;
      }
    });
    return isDriver;
  }

  Future<bool> userHaveInformation() async {
    bool haveInformation = false;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!['name'] != null) {
        haveInformation = true;
      }
    });
    return haveInformation;
  }
}
