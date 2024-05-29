import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/user/user_home_controller.dart';

// ignore: must_be_immutable
class UserHomeScreen extends StatelessWidget {
  UserHomeScreen({super.key});
  static const String routeName = '/userHomeScreen';
  UserHomeController controller = Get.put(UserHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: GetBuilder<UserHomeController>(builder: (_) {
        return controller.pages[controller.currentPage];
      }),
      bottomNavigationBar: CurvedNavigationBar(
        height: Get.height * 0.065,
        backgroundColor: Colors.transparent,
        items: const <Widget>[
          Icon(Icons.add, size: 30),
          Icon(Icons.list, size: 30),
          Icon(Icons.info, size: 30),
        ],
        onTap: (index) {
          controller.changePage(index);
        },
      ),
    );
  }
}
