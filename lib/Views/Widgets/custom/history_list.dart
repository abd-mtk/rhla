import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../Constants/style/style.dart';
import 'trip_information.dart';

// ignore: must_be_immutable
class HistoryList extends StatelessWidget {
  int passengers;
  double distance;
  String price;
  String status;
  Function() onDeleted;

  HistoryList(
      {super.key,
      required this.passengers,
      required this.distance,
      required this.price,
      required this.status,
      required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
      child: Column(
        children: [
          Container(
            decoration: snowContainer,
            height: Get.height * 0.23,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ZoomTapAnimation(
                        onTap: onDeleted,
                        child: const Icon(Icons.delete_forever_sharp,
                            color: Colors.red, size: 30),
                      ),
                      const Spacer(),
                      Text(
                        status,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                      const Text(
                        " : الحالة",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  TripInformation(
                    passengers: passengers,
                    distance: distance,
                    price: price,
                  )
                ],
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
