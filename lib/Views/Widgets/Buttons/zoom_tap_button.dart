import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

// ignore: must_be_immutable
class ZoomTapButton extends StatelessWidget {
  Function() onTap;
  String image;
  String text;
  double? width;
  double? height;

  ZoomTapButton({
    Key? key,
    required this.onTap,
    required this.image,
    required this.text,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            width: width ?? Get.width * 0.35,
            height: height ?? Get.height * 0.17,
            child: Image.asset(
              image,
              fit: BoxFit.scaleDown,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
