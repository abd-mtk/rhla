import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Views/User/user_home_screen.dart';

class InsertUserDataController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool gender = true;

  void saveUserData() {
    if (nameController.text == "" || phoneController.text == "") {
      Get.snackbar("خطأ", "برجاء ادخال البيانات المطلوبة");
    } else {
      FirebaseFirestore.instance.collection("users").doc(uid).set({
        "name": nameController.text,
        "phone": phoneController.text,
        "gender": gender ? "ذكر" : "انثى"
      }, SetOptions(merge: true)).then((value) => {
            Get.snackbar("تم", "تم حفظ البيانات بنجاح"),
            Get.offAllNamed(UserHomeScreen.routeName)
          });
    }
  }

  //get user data
  void getUser() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((value) => {
              nameController.text = value.data()!['name'],
              phoneController.text = value.data()!['phone'],
              gender = value.data()!['gender'] == "ذكر" ? true : false,
              update()
            });
  }

  @override
  void onInit() {
    getUser();
    super.onInit();
  }
}
