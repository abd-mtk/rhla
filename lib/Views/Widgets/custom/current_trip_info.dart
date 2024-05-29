// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/Views/Widgets/custom/status_trip.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// ignore: must_be_immutable
class CurrentTripInfo extends StatelessWidget {
  String status;
  String price;
  int passengers;
  Function() onLocation;
  Function() onStop;
  Function() onGo;
  Function()? onDeleted;
  Function()? onEndTrip;

  CurrentTripInfo({
    super.key,
    required this.status,
    required this.price,
    required this.passengers,
    required this.onLocation,
    required this.onStop,
    required this.onGo,
    this.onDeleted,
    this.onEndTrip,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: BorderRadius.circular(15),
        ),
        width: Get.width,
        height: Get.height * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StatusTrip(
                    text: 'عدد الركاب',
                    width: Get.width * 0.20,
                    height: Get.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.airline_seat_recline_normal_sharp,
                          size: 35,
                          color: Colors.black,
                        ),
                        Text(
                          passengers.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StatusTrip(
                    text: 'سعر الرحلة',
                    width: Get.width * 0.20,
                    height: Get.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 35,
                          color: Colors.green,
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StatusTrip(
                    text: 'حالة الرحلة',
                    width: Get.width * 0.20,
                    height: Get.height * 0.1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.settings_power_rounded,
                          size: 35,
                          color:
                              status == "started" ? Colors.green : Colors.red,
                        ),
                        Text(
                          status == "started" ? "مباشرة" : "متوقفة",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color:
                                status == "started" ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZoomTapAnimation(
                    onTap: onLocation,
                    child: StatusTrip(
                      width: Get.width * 0.20,
                      height: Get.height * 0.1,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.map,
                            size: 35,
                            color: Colors.blue,
                          ),
                          Text(
                            'الموقع',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: onGo,
                    child: StatusTrip(
                      width: Get.width * 0.20,
                      height: Get.height * 0.1,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.play_arrow_sharp,
                            size: 35,
                            color: Colors.green,
                          ),
                          Text(
                            'انطلاق',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: onStop,
                    child: StatusTrip(
                      width: Get.width * 0.20,
                      height: Get.height * 0.1,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.stop,
                            size: 35,
                            color: Colors.red,
                          ),
                          Text(
                            'توقف',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ZoomTapAnimation(
                    onTap: onDeleted,
                    child: StatusTrip(
                      width: Get.width * 0.20,
                      height: Get.height * 0.1,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.delete_forever_outlined,
                            size: 35,
                            color: Colors.red,
                          ),
                          Text(
                            'حذف',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ZoomTapAnimation(
                    onTap: onEndTrip,
                    child: StatusTrip(
                      width: Get.width * 0.20,
                      height: Get.height * 0.1,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.flag_circle,
                            size: 35,
                            color: Colors.blue,
                          ),
                          Text(
                            'انهاء',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
