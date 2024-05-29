// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rhla/Views/Constants/style/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../Controllers/user/display_available_trips_on_map_controller.dart';

// ignore: must_be_immutable
class AvailableTrip extends StatelessWidget {
  DisplayAvailableTripOnMapController controller;
  AvailableTrip({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.availableTrips.isNotEmpty &&
            controller.availableCars.isNotEmpty &&
            controller.isSended.length == controller.availableTrips.length
        ? SizedBox(
            width: Get.width,
            height: Get.height * 0.3,
            child: ListView.builder(
              itemCount: controller.availableTrips.length,
              itemBuilder: (_, item) => Container(
                decoration: snowContainer,
                height: Get.height * 0.15,
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ZoomTapAnimation(
                              onTap: () {
                                if (controller.isSended[item] == false) {
                                  controller.isSended[item] =
                                      !controller.isSended[item];
                                  controller.sendOrder(
                                      controller.availableTrips[item]);
                                } else {
                                  Get.snackbar('تنبيه', 'تم ارسال طلبك مسبقاً',
                                      titleText: const Text("تنبيه",
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      messageText: const Text(
                                          'تم ارسال طلبك مسبقاً',
                                          textAlign: TextAlign.right,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Colors.blueGrey,
                                      colorText: Colors.white);
                                }
                                controller.update();
                              },
                              child: Column(
                                children: [
                                  controller.isSended[item]
                                      ? const Icon(
                                          Icons.mark_email_read,
                                          size: 35,
                                          color: Colors.green,
                                        )
                                      : const Icon(
                                          Icons.mark_email_unread,
                                          size: 35,
                                          color: Colors.red,
                                        ),
                                  Text(
                                    controller.isSended[item]
                                        ? "تم الارسال"
                                        : 'ارسال طلب',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              )),
                          ZoomTapAnimation(
                              onTap: () {
                                controller.showCarDetails(
                                    controller.availableTrips[item],
                                    controller.availableCars[item]);
                              },
                              child: const Column(
                                children: [
                                  Icon(Icons.no_crash_sharp,
                                      size: 35, color: Colors.purple),
                                  Text(
                                    'تفاصيل الرحلة',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              )),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    controller.availableTrips[item].price
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  const Text(
                                    'السعر : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    controller.availableCars[item].type ==
                                            'سيارة'
                                        ? 'صالون'
                                        : controller.availableCars[item].type,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  const Text(
                                    'نوع السيارة : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    controller
                                        .availableTrips[item].availableSeats
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  const Text(
                                    'المقاعد المتاحة : ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textDirection: TextDirection.rtl,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Gap(10),
                    ],
                  ),
                ),
              ),
            ),
          )
        : SizedBox(
            width: Get.width,
            height: Get.height * 0.3,
            child: const Center(
                child: Text(
              'لا يوجد رحلات متاحة',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )));
  }
}
