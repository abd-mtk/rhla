import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateTripController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController title = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController availableSeats = TextEditingController();
  LatLng? destination;
  LatLng? source;

  void uploadTrip() {
    if (title.text.isNotEmpty &&
        price.text.isNotEmpty &&
        description.text.isNotEmpty &&
        availableSeats.text.isNotEmpty &&
        destination != null &&
        source != null) {
      try {
        saveToFirebase();
      } catch (e) {
        Get.snackbar(
          "                                                              خطأ",
          "                                                  حدث خطأ ما الرجاء المحاولة مرة اخرى",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        "                                                              خطأ",
        "                                               الرجاء ملئ جميع الحقول",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void saveToFirebase() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection('trips')
        .add({
      'title': title.text,
      'price': price.text,
      'description': description.text,
      'availableSeats': int.parse(availableSeats.text),
      'destination': destination!.toJson(),
      'source': source!.toJson(),
      'status': "started"
    }).then((value) => {
              FirebaseFirestore.instance
                  .collection('trips')
                  .add({
                    'id': value.id,
                    'uid': uid,
                    'title': title.text,
                    'price': price.text,
                    'description': description.text,
                    'availableSeats': int.parse(availableSeats.text),
                    'destination': destination!.toJson(),
                    'source': source!.toJson(),
                    'status': "started"
                  })
                  .then((value) => {clear()})
                  .then((value) => {
                        Get.snackbar(
                          "                                                              تم",
                          "                                               تم اضافة الرحلة بنجاح",
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        )
                      })
            });
    Get.back();
  }

  void clear() {
    title.clear();
    price.clear();
    description.clear();
    availableSeats.clear();
    destination = null;
    source = null;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    title.dispose();
    price.dispose();
    description.dispose();
    availableSeats.dispose();

    super.onClose();
  }
}
