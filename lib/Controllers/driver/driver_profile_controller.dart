import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/car.dart';
import '../../Views/Driver/Car Screens/insert_driver_data_screen.dart';

class DriverProfileController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Car? car;
  List<String> cars = [
    "assets/images/car4p.png",
    "assets/images/bus.png",
    "assets/images/longbus.png"
  ];
  List<String> carTypes = ["سيارة", "باص", "باص طويل"];

  void getCarData() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .get()
        .then((value) {
      if (value.data()!.containsKey('car')) {
        car = Car.fromJson(value.data()!["car"]!);
        update();
      } else {
        Get.snackbar(
            '                                                             تنبيه',
            '                                     يجب اضافة معلومات السيارة اولاً',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.transparent,
            colorText: Colors.black);
        Get.toNamed(InsertDriverDataScreen.routeName);
      }
    });
  }

  @override
  void onInit() {
    getCarData();
    super.onInit();
  }
}
