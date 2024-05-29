import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Middlewares/auth_middleware.dart';
import 'Views/App/Default/login_screen.dart';
import 'Views/App/Default/onboarding_screen.dart';
import 'Views/App/Default/register_screen.dart';
import 'Views/App/Default/select_mode_screen.dart';
import 'Views/Constants/colors/theme_app.dart';
import 'Views/Driver/Car Screens/driver_profile_screen.dart';
import 'Views/Driver/Car Screens/insert_driver_data_screen.dart';
import 'Views/Driver/Driver Maps Screens/create_trip_screen.dart';
import 'Views/Driver/Driver Maps Screens/get_location_screen.dart';
import 'Views/Driver/Driver Maps Screens/on_map_screen.dart';
import 'Views/Driver/Trips Screens/trips_screen.dart';
import 'Views/Driver/driver_home_screen.dart';
import 'Views/User/Profile Screens/insert_user_data_screen.dart';
import 'Views/User/Profile Screens/user_profile_screen.dart';
import 'Views/User/Trip Screens/car_info_screen.dart';
import 'Views/User/Trip Screens/display_available_trips_on_map_screen.dart';
import 'Views/User/Trip Screens/user_trips_screen.dart';
import 'Views/User/user_home_screen.dart';

SharedPreferences? prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.size,
      title: 'تطبيق رحلة',
      theme: appTheme,
      initialRoute: OnboardingScreen.routeName,
      getPages: [
        GetPage(
          name: OnboardingScreen.routeName,
          page: () => const OnboardingScreen(),
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: SelectModeScreen.routeName,
          page: () => SelectModeScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => LoginScreen(),
        ),
        GetPage(
          name: RegisterScreen.routeName,
          page: () => RegisterScreen(),
        ),
        GetPage(
          name: DriverHomeScreen.routeName,
          page: () => DriverHomeScreen(),
        ),
        GetPage(
          name: UserHomeScreen.routeName,
          page: () => UserHomeScreen(),
        ),
        GetPage(
          name: GetLocationScreen.routeName,
          page: () => GetLocationScreen(),
        ),
        GetPage(
          name: DriverProfileScreen.routeName,
          page: () => DriverProfileScreen(),
        ),
        GetPage(
          name: InsertDriverDataScreen.routeName,
          page: () => InsertDriverDataScreen(),
        ),
        GetPage(
          name: OnMapScreen.routeName,
          page: () => OnMapScreen(),
        ),
        GetPage(
          name: CreateTripScreen.routeName,
          page: () => CreateTripScreen(),
        ),
        GetPage(
          name: OrdersScreen.routeName,
          page: () => OrdersScreen(),
        ),
        GetPage(
          name: InsertUserDataScreen.routeName,
          page: () => InsertUserDataScreen(),
        ),
        GetPage(
          name: UserProfileScreen.routeName,
          page: () => UserProfileScreen(),
        ),
        GetPage(
          name: UserTripsScreen.routeName,
          page: () => UserTripsScreen(),
        ),
        GetPage(
          name: DisplayAvailableTripOnMapScreen.routeName,
          page: () => DisplayAvailableTripOnMapScreen(),
        ),
        GetPage(
          name: CarInfoScreen.routeName,
          page: () => CarInfoScreen(),
        ),
      ],
    );
  }
}
