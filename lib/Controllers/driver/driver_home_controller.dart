import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Views/Driver/Car Screens/driver_profile_screen.dart';
import '../../Views/Driver/Driver Maps Screens/create_trip_screen.dart';
import '../../Views/Driver/Trips Screens/trips_screen.dart';

class DriverHomeController extends GetxController {
  final _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  List<Widget> pages = [
    CreateTripScreen(),
    OrdersScreen(),
    DriverProfileScreen(),
  ];

  void changePage(int index) {
    _currentPage.value = index;
    update();
  }
}
