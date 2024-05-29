import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/driver/trips_controller.dart';
import 'current_trip_screen.dart';
// import 'history_trips_screen.dart';
import 'requests_trip_screen.dart';

// ignore: must_be_immutable
class OrdersScreen extends StatelessWidget {
  OrdersScreen({super.key});
  static const String routeName = '/OrdersScreen';
  TripsController controller = Get.put(TripsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: const Text('تنظيم الرحلات'),
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
                // Tab(
                //   text: 'الرحلات السابقة',
                //   icon: Icon(Icons.history),
                // ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  CurrentTripScreen(),
                  RequestsScreen(),
                  // HistoryTripsScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
