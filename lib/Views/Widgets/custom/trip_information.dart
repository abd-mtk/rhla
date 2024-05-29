import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class TripInformation extends StatelessWidget {
  int passengers;
  double distance;
  String price;

  TripInformation(
      {super.key,
      required this.passengers,
      required this.distance,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Icon(Icons.people, color: Colors.blueGrey, size: 40),
            const Text("عدد الركاب",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)),
            Text(passengers.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const Gap(1),
        Column(
          children: [
            const Icon(Icons.location_on, color: Colors.blue, size: 40),
            const Text("المسافة",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)),
            Text(distance.toString() + " كم",
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        const Gap(10),
        Column(
          children: [
            const Icon(Icons.attach_money_rounded,
                color: Colors.green, size: 40),
            const Text("السعر",
                style:  TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)),
            Text(price,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}