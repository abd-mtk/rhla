import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rhla/Models/trip.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../Models/car.dart';
import '../../Views/Constants/fonts/fonts.dart';
import '../../Views/User/Trip Screens/car_info_screen.dart';
import '../utilities/get_location.dart';

class DisplayAvailableTripOnMapController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late Position position;
  LatLng? currentLocation;
  LatLng? destinationLocation;
//=================================================
  Set<Marker> markers = {};
  List<Placemark>? placemarks;
//=================================================

  String distance = "0";
  double driverDistanceError = 2;
  double destinationDistanceError = 5;
//=================================================
  List<Trip> availableTrips = [];
  List<Trip> currentTrips = [];
  List<Car> availableCars = [];
  Car? car;
  List<String> cars = [
    "assets/images/car4p.png",
    "assets/images/bus.png",
    "assets/images/longbus.png"
  ];

  List<bool> isSended = [];
//=================================================
  bool showdetail = false;
  MapType currentCameraMode = MapType.normal;
  final List<MapType> cameraMode = const [
    MapType.normal,
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid,
  ];
//=================================================

  void showCarDetails(Trip trip, Car car) {
    Get.toNamed(CarInfoScreen.routeName, arguments: [trip, car]);
  }

  void sendOrder(Trip trip) {
    FirebaseFirestore.instance.collection('orders').add({
      'destination': destinationLocation!.toJson(),
      'source': currentLocation!.toJson(),
      'status': 'pending',
      'tripId': trip.id,
      'uid': uid,
      "driverId": trip.uid
    });
    Get.snackbar("تم الطلب", "تم ارسال طلبك بنجاح",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3));
  }

  void getAvailableTrips() async {
    Get.defaultDialog(
      title: "قم بتحديد مسافة البحث",
      content: Row(
        children: [
          SleekCircularSlider(
              initialValue: 2,
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                  progressBarColors: [Colors.red, Colors.pink],
                ),
                size: 120,
                infoProperties: InfoProperties(
                  bottomLabelText: 'البعد عن الوجهة',
                  mainLabelStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  modifier: (double value) {
                    return '${value.toInt()} كم';
                  },
                ),
              ),
              onChange: (double value) {
                destinationDistanceError = value;
              }),
          const Spacer(),
          SleekCircularSlider(
              initialValue: 2,
              appearance: CircularSliderAppearance(
                customColors: CustomSliderColors(
                  progressBarColors: [Colors.blue, Colors.blue],
                ),
                size: 120,
                infoProperties: InfoProperties(
                  bottomLabelText: 'بعد السائق',
                  mainLabelStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  modifier: (double value) {
                    return '${value.toInt()} كم';
                  },
                ),
              ),
              onChange: (double value) {
                driverDistanceError = value;
              }),
        ],
      ),
      cancelTextColor: Colors.red,
      textCancel: "الغاء",
      textConfirm: "بحث",
      onConfirm: () {
        availableTrips.clear();
        availableCars.clear();
        isSended.clear();
        FirebaseFirestore.instance
            .collection('trips')
            .where('status', isEqualTo: 'started')
            .get()
            .then((value) => {
                  if (value.docs.isNotEmpty)
                    {
                      value.docs.forEach((element) {
                        if (distanceCompute(element['destination'], [
                                  destinationLocation!.latitude,
                                  destinationLocation!.longitude
                                ]) <=
                                destinationDistanceError &&
                            distanceCompute(element['source'], [
                                  currentLocation!.latitude,
                                  currentLocation!.longitude
                                ]) <=
                                driverDistanceError) {
                          availableTrips.add(Trip.fromJson(element.data()));
                          update();
                          // search for orders if have order same tripId with any status add isisSended true else false
                          FirebaseFirestore.instance
                              .collection("orders")
                              .where("tripId",
                                  isEqualTo: element.data()["tripId"])
                              .get()
                              .then((value) => {
                                    if (value.docs.isNotEmpty)
                                      {isSended.add(true), update()}
                                    else
                                      {isSended.add(false), update()}
                                  });
                        }
                      }),
                    }
                })
            .then((value) => {
                  for (var i = 0; i < availableTrips.length; i++)
                    {
                      FirebaseFirestore.instance
                          .collection('drivers')
                          .doc(availableTrips[i].uid)
                          .get()
                          .then((value) => {
                                if (value.exists)
                                  {
                                    car = Car.fromJson(value.data()!["car"]),
                                    availableCars.add(car!),
                                    update(),
                                  }
                              }),
                    },
                })
            .then((value) => Get.back());
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  @override
  void onInit() async {
    position = await determinePosition();
    // currentLocation = LatLng(position.latitude, position.longitude);
    super.onInit();
  }

  double distanceCompute(start, end) {
    double distanceInMeters = Geolocator.distanceBetween(
      start[0],
      start[1],
      end[0],
      end[1],
    );
    return double.parse((distanceInMeters / 1000).toStringAsFixed(2));
  }

  Future<String> distanceBetweenMyLocationAndMarker(
      List<double> eventLocation) async {
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      eventLocation[0],
      eventLocation[1],
    );
    return (distanceInMeters / 1000).toStringAsFixed(2);
  }

  void onLongMapTap(LatLng position) async {
    if (markers.length == 2) {
      markers.clear();
    }
    if (markers.isEmpty) {
      currentLocation = position;
    }
    if (markers.length == 1) {
      destinationLocation = position;
    }
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    markers.add(Marker(
      position: position,
      markerId: MarkerId(position.toString()),
      infoWindow: InfoWindow(
          title: markers.length == 1 ? "وجهتي" : "موقعي",
          snippet: placemarks![0].subAdministrativeArea.toString(),
          onTap: () async {
            placemarks = await placemarkFromCoordinates(
                position.latitude, position.longitude);
            distanceBetweenMyLocationAndMarker(
                <double>[position.latitude, position.longitude]).then((value) {
              distance = value;
              showdetail = !showdetail;
              update();
            });
          }),
      icon: BitmapDescriptor.defaultMarkerWithHue(markers.length == 1
          ? BitmapDescriptor.hueRed
          : BitmapDescriptor.hueBlue),
    ));
    update();
  }

  void changeCameraMode(String mode) {
    switch (mode) {
      case 'normal':
        currentCameraMode = MapType.normal;
        break;
      case 'satellite':
        currentCameraMode = MapType.satellite;
        break;
      case 'terrain':
        currentCameraMode = MapType.terrain;
        break;
      case 'hybrid':
        currentCameraMode = MapType.hybrid;
        break;
    }
    update();
  }

  void changeMapMode() {
    Get.defaultDialog(
      title: "تغيير نوع الخريطة",
      content: Column(
        children: [
          ListTile(
            trailing: currentCameraMode == MapType.normal
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            title: const Text('عادي', style: subtitleTextStyle),
            onTap: () {
              changeCameraMode('normal');
              Get.back();
            },
          ),
          ListTile(
            trailing: currentCameraMode == MapType.satellite
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            title: const Text('قمر صناعي', style: subtitleTextStyle),
            onTap: () {
              changeCameraMode('satellite');
              Get.back();
            },
          ),
          ListTile(
            trailing: currentCameraMode == MapType.terrain
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            title: const Text('تضاريس', style: subtitleTextStyle),
            onTap: () {
              changeCameraMode('terrain');
              Get.back();
            },
          ),
          ListTile(
            trailing: currentCameraMode == MapType.hybrid
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            title: const Text('هجين', style: subtitleTextStyle),
            onTap: () {
              changeCameraMode('hybrid');
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  void showInfoWindow() {
    Get.defaultDialog(
      title: "تعليمات الاستخدام",
      content: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            title: Text(
              'عليك اولا تحديد موقعك الحالي',
              style: subtitleTextStyle,
              textDirection: TextDirection.rtl,
            ),
            leading: Icon(Icons.location_on, color: Colors.green, size: 30),
          ),
          Divider(thickness: 2),
          ListTile(
            title: Text(
              'ثم تحديد موقع الوجهة',
              style: subtitleTextStyle,
              textDirection: TextDirection.rtl,
            ),
            leading: Icon(Icons.flag, color: Colors.blue, size: 30),
          ),
          Divider(thickness: 2),
          ListTile(
            title: Text(
              'ثم الضغط على زر البحث',
              style: subtitleTextStyle,
              textDirection: TextDirection.rtl,
            ),
            leading: Icon(Icons.search, color: Colors.purple, size: 30),
          ),
        ],
      ),
    );
  }
}
