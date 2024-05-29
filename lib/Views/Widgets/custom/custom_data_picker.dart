// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/driver/insert_driver_data_controller.dart';

// ignore: must_be_immutable
class CustomDatePicker extends StatelessWidget {
  InsertDriverDataController controller;
  CustomDatePicker({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("اختر سنة صنع المركبة",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      content: SizedBox(
        height: Get.height * 0.4,
        width: Get.width * 0.6,
        child: YearPicker(
          firstDate: DateTime(DateTime.now().year - 30, 1),
          lastDate: DateTime(DateTime.now().year + 1, 1),
          initialDate: DateTime.now(),
          selectedDate: DateTime.now(),
          onChanged: (DateTime dateTime) {
            controller.setCarModel(dateTime.year.toString());
            Get.back();
          },
        ),
      ),
    );
  }
}
