import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class StatusTrip extends StatelessWidget {
  String? text;
  double? width;
  double? height;
  Widget? child;

  StatusTrip({
    Key? key,
    this.text,
    this.width,
    this.height,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: width ?? Get.width * 0.35,
            height: height ?? Get.height * 0.17,
            child: child),
        text != null
            ? Text(
                text!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              )
            : Container(),
      ],
    );
  }
}
