import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/Views/Constants/style/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../Controllers/user/user_cureent_trip_controller.dart';

// ignore: must_be_immutable
class UsreRequestsScreen extends StatelessWidget {
  UsreRequestsScreen({super.key});
  UserCurrentTripController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserCurrentTripController>(builder: (_) {
      return controller.historyTrips.isNotEmpty
          ? ListView.builder(
              itemCount: controller.historyTrips.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: snowContainer,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ZoomTapAnimation(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 40,
                          ),
                          onTap: () => controller.deleteMyOrder(
                            controller.historyTrips[index].id!,
                          ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "عنوان الرحلة: ${controller.historyTrips[index].title}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "وصف الرحلة: ${controller.historyTrips[index].description}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "سعر الرحلة: ${controller.historyTrips[index].price}",
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      ],
                    ),
                  ),
                );
              },
            )
          : const Center(child: Text('لا يوجد طلبات حالية'));
    });
  }
}
