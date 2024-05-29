import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../Constants/style/style.dart';

// ignore: must_be_immutable
class CurrentRequestTrip extends StatelessWidget {
  String gender;
  String name;
  Function() onLocation;
  Function() onCancel;
  Function() onDone;

  CurrentRequestTrip(
      {super.key,
      required this.gender,
      required this.name,
      required this.onLocation,
      required this.onCancel,
      required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: snowContainer,
          width: Get.width,
          height: Get.height * 0.12,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Gap(10),
                    Column(
                      children: [
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => onDone,
                              icon: const Icon(
                                Icons.check_circle,
                                size: 35,
                                color: Colors.green,
                              ),
                            ),
                            const Text(
                              'اكمال',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Gap(20),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => onCancel,
                          icon: const Icon(
                            Icons.cancel,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                        const Text(
                          'الغاء',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    const Gap(20),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => onLocation,
                          icon: const Icon(
                            Icons.location_on,
                            size: 35,
                            color: Colors.blue,
                          ),
                        ),
                        const Text(
                          'الموقع',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    gender == "ذكر"
                        ? const Icon(
                            Icons.man,
                            size: 35,
                            color: Colors.blueAccent,
                          )
                        : const Icon(
                            Icons.woman,
                            size: 35,
                            color: Colors.pinkAccent,
                          ),
                  ],
                )
              ],
            ),
          ),
        ),
        const Gap(5),
      ],
    );
  }
}
