import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Views/Constants/fonts/fonts.dart';
import '../utilities/get_location.dart';

class GetLocationController extends GetxController {
  final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(33.314815005455586, 44.366285875439644),
    zoom: 9,
  );
  bool showdetail = false;
  late Position position;
  LatLng currentLocation = const LatLng(33.314815005455586, 44.366285875439644);
  LatLng? destination;
  LatLng? source;
  final Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;
  MapType currentCameraMode = MapType.normal;
  List<Placemark>? placemarks;
  String distance = "0";

  final List<MapType> cameraMode = const [
    MapType.normal,
    MapType.satellite,
    MapType.terrain,
    MapType.hybrid,
  ];

  @override
  void onInit() async {
    position = await determinePosition();
    currentLocation = LatLng(position.latitude, position.longitude);
    super.onInit();
  }

  void clearFilter() {
    markers.clear();
    update();
  }

  // distance between my location and marker
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
      source = position;
    }
    if (markers.length == 1) {
      destination = position;
    }
    placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    markers.add(Marker(
      position: position,
      markerId: MarkerId(position.toString()),
      infoWindow: InfoWindow(
          title: markers.length == 1 ? "الوجهة" : "نقطة الانطلاق",
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
      icon: BitmapDescriptor.defaultMarkerWithHue(
        markers.length == 1
            ? BitmapDescriptor.hueMagenta
            : BitmapDescriptor.hueGreen,
      ),
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
}
