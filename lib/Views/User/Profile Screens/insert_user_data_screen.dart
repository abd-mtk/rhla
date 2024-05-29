import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/user/insert_user_data_controller.dart';
import '../../Widgets/Inputs/input_field.dart';
import '../../Widgets/custom/custom_drop_down.dart';

// ignore: must_be_immutable
class InsertUserDataScreen extends StatelessWidget {
  InsertUserDataScreen({super.key});
  static const routeName = '/insert-user-data-screen';
  InsertUserDataController controller = Get.put(InsertUserDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('تسجيل بيانات المستخدم'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Image.asset(
              'assets/images/profile.png',
              width: 150,
              height: 150,
            ),
            InputField(
              inputController: controller.nameController,
              maxchar: 20,
              hintText: 'الاسم',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            InputField(
              inputController: controller.phoneController,
              maxchar: 11,
              hintText: 'رقم الهاتف',
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomDropDown(
                  onPressed: (value) {
                    controller.gender = value == "ذكر" ? true : false;
                  },
                  downList: const ["ذكر", "انثى"],
                  hint: 'جنس السائق',
                  value: "ذكر",
                  iconList: const [
                    Icon(
                      Icons.male,
                      color: Colors.blue,
                    ),
                    Icon(
                      Icons.female,
                      color: Colors.pink,
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text('تحدد جنس المستخدم',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    controller.saveUserData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('تسجيل البيانات',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ]),
        ));
  }
}
