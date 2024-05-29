import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Views/Driver/driver_home_screen.dart';

class InsertDriverDataController extends GetxController {
  List<String> carTypes = ["سيارة", "باص", "باص طويل"];
  List<String> carCapacityList = [
    "2",
    "4",
    "7",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50"
  ];
  List<String> carColorsList = [
    "أبيض",
    "أسود",
    "أحمر",
    "أزرق",
    "أصفر",
    "أخضر",
    "برتقالي",
    "بني",
    "رمادي",
    "بيج",
    "أخرى"
  ];
  List<String> cars = [
    "assets/images/car4p.png",
    "assets/images/bus.png",
    "assets/images/longbus.png"
  ];

  List<String> driverGender = ["ذكر", "أنثى"];
  List<Icon>? iconGender = const [
    Icon(
      Icons.male,
      color: Colors.blue,
    ),
    Icon(Icons.female, color: Colors.pink)
  ];

  String carType = "سيارة";
  String carModel = "غير متوفر";
  String carColorValue = 'أصفر';
  TextEditingController carNumber = TextEditingController();
  String carCapacityValue = "2";
  String driverGenderValue = "ذكر";

  void setCarType(String value) {
    carType = value;
    update();
  }

  void setCarModel(String value) {
    carModel = value;
    update();
  }

  void setCarColor(String value) {
    carColorValue = value;
    update();
  }

  void setCarNumber(String value) {
    carNumber.text = value;
    update();
  }

  void setCarCapacity(String value) {
    carCapacityValue = value;
    update();
  }

  void setDriverGender(String value) {
    driverGenderValue = value;
    update();
  }

  void clear() {
    carType = "سيارة";
    carModel = "غير متوفر";
    carColorValue = 'أصفر';
    carNumber = TextEditingController();
    carCapacityValue = "2";
    driverGenderValue = "ذكر";
    update();
  }

  // save car info to firebase
  void saveCarInfoToFirebase() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'car': {
        'carType': carType,
        'carModel': carModel,
        'carColor': carColorValue,
        'carNumber': carNumber.text,
        'carCapacity': int.parse(carCapacityValue),
        'driverGender': driverGenderValue,
      },
    }, SetOptions(merge: true));
  }

  void submit() {
    if (carModel == "غير متوفر") {
      Get.snackbar(
        "                                                    خطأ",
        "                         من فضلك أدخل موديل السيارة",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        ),
      );
    } else if (carNumber.text.isEmpty) {
      Get.snackbar(
        "                                                     خطأ",
        "                              من فضلك أدخل رقم اللوحة",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.white,
        ),
      );
    } else {
      saveCarInfoToFirebase();
      Get.offAllNamed(DriverHomeScreen.routeName);
    }
  }

  Future<bool> isDriver() async {
    bool isDriver = false;
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data() != null) {
        isDriver = true;
      }
    });
    return isDriver;
  }
}
