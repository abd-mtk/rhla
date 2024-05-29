import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:rhla/Models/order.dart';
import 'package:rolling_switch/rolling_switch.dart';

import '../../../Controllers/driver/orders_controller.dart';

// ignore: must_be_immutable
class RequestList extends StatelessWidget {
  String gender;
  String name;
  Function onLocation;
  Function onReject;
  Function onAccept;
  bool isInlist = true;
  OrderController? orderController;
  String? orderId;
  String? status;
  TripOrder? order;
  RequestList({
    super.key,
    required this.gender,
    required this.name,
    required this.onLocation,
    required this.onReject,
    required this.onAccept,
    this.orderController,
    this.orderId,
    this.status,
   required this.order,
    this.isInlist = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          width: Get.width,
          height: isInlist != true ? Get.height * 0.2 : Get.height * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width * 0.18,
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: (){onReject();},
                          icon: const Icon(
                            Icons.delete_forever,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "ازالة",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(2),
                  Container(
                    width: Get.width * 0.18,
                    height: Get.height * 0.1,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed:(){ onLocation();},
                          icon: const Icon(
                            Icons.location_on,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          "الموقع",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(2),
                  isInlist
                      ? Container(
                          width: Get.width * 0.18,
                          height: Get.height * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  onAccept();
                                },
                                icon: const Icon(
                                  Icons.check_circle,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                "قبول",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                      : // add switch button
                      Container(),
                  const Spacer(),
                  SizedBox(
                    height: Get.height * 0.1,
                    child: Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
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
                    ),
                  ),
                ],
              ),
              isInlist != true ? const Spacer() : Container(),
              isInlist != true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RollingSwitch.icon(
                          initialState: status == "completed" ? true : false,
                          onChanged: (bool state) {
                            if (state) {
                              orderController!
                                  .updateOrderStatus("completed", order!);
                            } else {
                              orderController!
                                  .updateOrderStatus("waiting", order!);
                            }
                          },
                          rollingInfoRight: const RollingIconInfo(
                            icon: Icons.check_circle,
                            text: Text('راكب',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.green,
                          ),
                          rollingInfoLeft: const RollingIconInfo(
                            icon: Icons.timer,
                            backgroundColor: Colors.red,
                            text: Text('ينتظر',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "حالة الطلب",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        const Gap(5),
                      ],
                    )
                  : Container(),
              const Spacer(),
            ],
          ),
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
          endIndent: 20,
          indent: 20,
        ),
      ],
    );
  }
}
