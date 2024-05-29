import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void successSnakBar(String title, String message) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          textAlign: TextAlign.right,
        ),
        messageText: Text(
          message,
          textAlign: TextAlign.right,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.greenAccent[400]);
  }

  // error snak bar
  static void errorSnakBar(String title, String message) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          textAlign: TextAlign.right,
        ),
        messageText: Text(
          message,
          textAlign: TextAlign.right,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent[400]);
  }

  // warning snak bar
  static void warningSnakBar(String title, String message) {
    Get.snackbar(title, message,
        titleText: Text(
          title,
          textAlign: TextAlign.right,
        ),
        messageText: Text(
          message,
          textAlign: TextAlign.right,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.yellowAccent[400]);
  }
}
