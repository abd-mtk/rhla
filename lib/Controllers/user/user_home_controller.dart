import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/Views/User/Profile%20Screens/user_profile_screen.dart';

import '../../Views/User/Trip Screens/display_available_trips_on_map_screen.dart';
import '../../Views/User/Trip Screens/user_trips_screen.dart';

class UserHomeController extends GetxController {
  final _currentPage = 0.obs;

  int get currentPage => _currentPage.value;

  List<Widget> pages = [
    DisplayAvailableTripOnMapScreen(),
    UserTripsScreen(),
    UserProfileScreen(),
  ];

  void changePage(int index) {
    _currentPage.value = index;
    update();
  }
}
