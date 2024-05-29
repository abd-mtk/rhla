import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/user/user_cureent_trip_controller.dart';
import '../../Constants/style/style.dart';
import '../../Widgets/custom/custom_text_section.dart';

// ignore: must_be_immutable
class UserCurrentTripScreen extends StatelessWidget {
  UserCurrentTripScreen({super.key});
  UserCurrentTripController controller = Get.put(UserCurrentTripController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserCurrentTripController>(builder: (_) {
      return controller.currentTrips.isNotEmpty
          ? ListView.builder(
              itemCount: controller.currentTrips.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: snowContainer,
                  height: Get.height * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextSection(
                        text:
                            'عنوان الرحلة : ${controller.currentTrips[index].title}',
                      ),
                      TextSection(
                        text:
                            'وصف الرحلة : ${controller.currentTrips[index].description}',
                        lines: 4,
                      ),
                      TextSection(
                        text: 'السعر : ${controller.currentTrips[index].price}',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              onPressed: () {
                                controller.deleteMyOrder(
                                    controller.currentTrips[index].id!);
                              },
                              icon: const Icon(Icons.dangerous),
                              label: const Text('الغاء الرحلة')),
                          ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              onPressed: () {
                                controller.showTripDetails(
                                    controller.currentTrips[index]);
                              },
                              icon: const Icon(Icons.details),
                              label: const Text('تفاصيل الرحلة')),
                        ],
                      ),
                    ],
                  ),
                );
              },
            )
          : const Center(child: Text('لا يوجد رحلات حالية'));
    });
  }
}
