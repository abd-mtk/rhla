// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/driver/insert_driver_data_controller.dart';
import '../../Widgets/Inputs/input_field.dart';
import '../../Widgets/custom/custom_data_picker.dart';
import '../../Widgets/custom/custom_drop_down.dart';

// ignore: must_be_immutable
class InsertDriverDataScreen extends StatelessWidget {
  InsertDriverDataScreen({super.key});
  static const String routeName = '/insertDriverDataScreen';
  InsertDriverDataController controller =
      Get.put(InsertDriverDataController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل بيانات المركبة'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                controller.clear();
              },
              icon: const Icon(Icons.clear_all))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<InsertDriverDataController>(builder: (_) {
            return Column(
              children: [
                ImageSlideshow(
                  indicatorBottomPadding: -10,
                  children: [
                    Image.asset(
                      controller.cars[
                          controller.carTypes.indexOf(controller.carType)],
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
                const Gap(
                  20,
                ),
                CustomDropDown(
                  onPressed: (value) => controller.setCarType(value),
                  downList: controller.carTypes,
                  hint: 'نوع المركبة',
                  value: controller.carType,
                ),
                const Divider(
                  height: 1,
                  thickness: 1,
                ),
                const Gap(
                  5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.dialog(CustomDatePicker(controller: controller));
                        },
                        icon: const Icon(Icons.calendar_today_outlined,
                            size: 30, color: Colors.purple)),
                    GetBuilder<InsertDriverDataController>(builder: (_) {
                      return Text(controller.carModel,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold));
                    }),
                    const Text('حدد تاريخ صنع المركبة',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDropDown(
                      onPressed: (value) => controller.setCarCapacity(value),
                      downList: controller.carCapacityList,
                      hint: 'سعة المركبة',
                      value: controller.carCapacityValue,
                    ),
                    const Text('حدد سعة المركبة',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDropDown(
                      onPressed: (value) => controller.setCarColor(value),
                      downList: controller.carColorsList,
                      hint: 'لون المركبة',
                      value: controller.carColorValue,
                    ),
                    const Text('حدد لون المركبة',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const Gap(25),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('رقم المركبة',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                InputField(
                  inputController: controller.carNumber,
                  maxchar: 10,
                  textAlign: TextAlign.left,
                  textDirection: TextDirection.ltr,
                ),
                const Gap(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomDropDown(
                      onPressed: (value) => controller.setDriverGender(value),
                      downList: controller.driverGender,
                      hint: 'جنس السائق',
                      value: controller.driverGenderValue,
                      iconList: controller.iconGender,
                    ),
                    const Text(' حدد جنس السائق',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
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
                        controller.submit();
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
              ],
            );
          }),
        ),
      ),
    );
  }
}
