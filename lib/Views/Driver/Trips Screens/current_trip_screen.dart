import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/Controllers/driver/orders_controller.dart';

import '../../../Controllers/driver/trips_controller.dart';
import '../../Widgets/Buttons/zoom_tap_button.dart';
import '../../Widgets/custom/current_trip_info.dart';
import '../../Widgets/custom/request_list.dart';
import '../Driver Maps Screens/create_trip_screen.dart';
import '../Driver Maps Screens/on_map_screen.dart';

// ignore: must_be_immutable
class CurrentTripScreen extends StatelessWidget {
  CurrentTripScreen({super.key});
  TripsController tripsController = Get.put(TripsController());
  OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TripsController>(
      builder: (context) {
        return tripsController.currenTrip == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'لا يوجد رحلة حالية',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ZoomTapButton(
                    onTap: () {
                      Get.toNamed(CreateTripScreen.routeName);
                    },
                    image: 'assets/images/createTrip.png',
                    text: 'إنشاء رحلة',
                  )
                ],
              )
            : Column(
                children: [
                  GetBuilder<OrderController>(builder: (_) {
                    return CurrentTripInfo(
                      onGo: () {
                        tripsController
                            .startTrip(tripsController.currenTrip!.id!);
                      },
                      onLocation: () {
                        Get.toNamed(OnMapScreen.routeName, arguments: [
                          tripsController.currenTrip!.destination,
                          tripsController.currenTrip!.source
                        ]);
                      },
                      onStop: () {
                        tripsController
                            .stopTrip(tripsController.currenTrip!.id!);
                      },
                      onEndTrip: () {
                        Get.defaultDialog(
                          title: 'تنبيه',
                          titleStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                          radius: 15,
                          content: const Text(
                            "هل تريد إنهاء الرحلة الحالية؟",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('تراجع',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () {
                                tripsController.finishTrip(
                                    tripsController.currenTrip!.id!);
                                Get.back();
                              },
                              child: const Text('تأكيد',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ),
                          ],
                        );
                      },
                      onDeleted: () {
                        Get.defaultDialog(
                          title: 'تحذير',
                          titleStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                          radius: 15,
                          content: const Text(
                            "الغاء الرحلة الحلية سوف يؤدي إلى إلغاء جميع الطلبات المرتبطة بها هل تريد الاستمرار؟",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('تراجع',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () {
                                tripsController.deleteTrip(
                                    tripsController.currenTrip!.id!);
                                Get.back();
                              },
                              child: const Text('تأكيد',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            ),
                          ],
                        );
                      },
                      passengers: orderController.acceptedOrders.length,
                      price: tripsController.currenTrip!.price,
                      status: tripsController.currenTrip!.status,
                    );
                  }),
                  const Divider(
                    thickness: 1,
                    color: Colors.black45,
                    endIndent: 20,
                    indent: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'الطلبات الحالية',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    thickness: 1,
                    color: Colors.black45,
                    endIndent: 20,
                    indent: 20,
                  ),
                  GetBuilder<OrderController>(builder: (_) {
                    return orderController.acceptedOrders.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount: orderController.acceptedOrders.length,
                              itemBuilder: (context, index) {
                                return RequestList(
                                  gender: orderController
                                          .acceptedUsers[index].gender ??
                                      'ذكر',
                                  name: orderController
                                          .acceptedUsers[index].name ??
                                      '',
                                  onAccept: () {
                                    orderController.updateOrderStatus(
                                        "accepted",
                                        orderController.acceptedOrders[index]);
                                  },
                                  onLocation: () {
                                    Get.toNamed(OnMapScreen.routeName,
                                        arguments: [
                                          orderController.acceptedOrders[index]
                                              .destination,
                                          orderController
                                              .acceptedOrders[index].source
                                        ]);
                                  },
                                  onReject: () {
                                    Get.defaultDialog(
                                      title: 'تحذير',
                                      titleStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red,
                                      ),
                                      radius: 15,
                                      content: const Text(
                                        "هل تريد رفض الطلب؟",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text('تراجع',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            orderController.updateOrderStatus(
                                                "rejected",
                                                orderController
                                                    .acceptedOrders[index]);
                                            Get.back();
                                          },
                                          child: const Text('تأكيد',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red)),
                                        ),
                                      ],
                                    );
                                  },
                                  isInlist: false,
                                  orderController: orderController,
                                  orderId: orderController
                                      .acceptedOrders[index].tripId,
                                  status: orderController
                                      .acceptedOrders[index].status,
                                  order: orderController.acceptedOrders[index],
                                );
                              },
                            ),
                          )
                        : const Center(
                            child: Text(
                              'لا يوجد طلبات حالية',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                  })
                ],
              );
      },
    );
  }
}
