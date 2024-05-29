import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class StatusBottom extends StatelessWidget {
  bool status;
  Function()? onPressed1;
  Function()? onPressed2;

  StatusBottom(
      {super.key,
      required this.status,
      required this.onPressed1,
      required this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.15,
      height: Get.height * 0.1,
      decoration: BoxDecoration(
        color: status ? Colors.yellow[400] : Colors.green[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: status ? (){

                onPressed1!();
                status = false;
                } : (){
                  onPressed2!();
                  status = true;
                
                },
              icon: status
                  ? const Icon(
                      Icons.timer_outlined,
                      size: 25,
                      color: Colors.red,
                    )
                  : const Icon(
                      Icons.check_circle_outline,
                      size: 25,
                      color: Colors.green,
                    )),
          Text(
            status ? "ينتظر" : "accept",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
