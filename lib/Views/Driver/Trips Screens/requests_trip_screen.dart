import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/driver/orders_controller.dart';
import '../../Widgets/custom/request_list.dart';
import '../Driver Maps Screens/on_map_screen.dart';

// ignore: must_be_immutable
class RequestsScreen extends StatelessWidget {
  RequestsScreen({super.key});
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (_) {
      return orderController.pendingOrders.isEmpty
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'لا يوجد طلبات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: orderController.pendingUsers.length,
              itemBuilder: (context, index) {
                return RequestList(
                  gender: orderController.pendingUsers[index].gender ?? 'ذكر',
                  name: orderController.pendingUsers[index].name ?? '',
                  onAccept: () {
                    orderController.acceptedOrder(
                        "waiting", orderController.pendingOrders[index].tripId);
                  },
                  onLocation: () {
                    Get.toNamed(OnMapScreen.routeName, arguments: [
                      orderController.pendingOrders[index].destination,
                      orderController.pendingOrders[index].source
                    ]);
                  },
                  onReject: () {
                    orderController.acceptedOrder("rejected",
                        orderController.pendingOrders[index].tripId);
                  },
                  order: orderController.pendingOrders[index],
                );
              });
    });
  }
}
