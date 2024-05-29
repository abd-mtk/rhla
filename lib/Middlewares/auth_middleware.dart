import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rhla/Views/Driver/driver_home_screen.dart';

import '../Views/User/user_home_screen.dart';
import '../main.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  // ignore: overridden_fields
  int? priority = 1;

  @override
  redirect(String? route) {
    if (prefs!.getString("uid") != null && prefs!.getBool("userType") == true) {
      return const RouteSettings(name: DriverHomeScreen.routeName);
    } else if (prefs!.getString("uid") != null &&
        prefs!.getBool("userType") == false) {
      return const RouteSettings(name: UserHomeScreen.routeName);
    } else {
      return null;
    }
  }
}
