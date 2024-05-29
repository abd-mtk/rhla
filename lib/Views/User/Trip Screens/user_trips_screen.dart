import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/user/user_trips_controller.dart';
import 'user_current_trip_screen.dart';
import 'user_requests_screen.dart';

// ignore: must_be_immutable
class UserTripsScreen extends StatelessWidget {
  UserTripsScreen({super.key});
  static const routeName = '/user-trips-screen';
  UserTripsController controller = Get.put(UserTripsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: const Text('رحلتي الحالية'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        animationDuration: const Duration(milliseconds: 500),
        length: 2,
        child: Column(
          children: [
            ButtonsTabBar(
              backgroundColor: Colors.purple,
              unselectedBackgroundColor: Colors.grey[300],
              unselectedLabelStyle: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              labelStyle: const TextStyle(color: Colors.white),
              radius: 15,
              tabs: const [
                Tab(
                  text: 'الرحلة الحالية',
                  icon: Icon(Icons.directions_car),
                ),
                Tab(
                  text: 'الطلبات',
                  icon: Icon(Icons.request_page),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  UserCurrentTripScreen(),
                  UsreRequestsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
