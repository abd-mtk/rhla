import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Controllers/driver/get_location_controller.dart';
import '../../Constants/style/style.dart';
import '../../Widgets/custom/location_info.dart';

// ignore: must_be_immutable
class OnMapScreen extends StatelessWidget {
  OnMapScreen({super.key});
  static const String routeName = '/onMapScreen';
  GetLocationController controller = Get.find();

  var location = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GetLocationController>(builder: (_) {
        return Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 1,
                  widthFactor: 2.5,
                  child: Stack(children: [
                    Positioned(
                      child: GoogleMap(
                        myLocationEnabled: true,
                        indoorViewEnabled: false,
                        mapType: controller.currentCameraMode,
                        initialCameraPosition: CameraPosition(
                          target: location.length > 1
                              ? LatLng(
                                  location[0][0],
                                  location[0][1],
                                )
                              : LatLng(
                                  location[0][0],
                                  location[0][1],
                                ),
                          zoom: 10,
                        ),
                        markers: location.length > 1
                            ? {
                                Marker(
                                  markerId: const MarkerId('1'),
                                  position: LatLng(
                                    location[0][0],
                                    location[0][1],
                                  ),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueGreen),
                                  infoWindow: InfoWindow(
                                    title: 'نقطة الوصول',
                                    snippet: '',
                                    onTap: () async {
                                      controller.currentLocation = LatLng(
                                        location[0][0],
                                        location[0][1],
                                      );
                                      controller.placemarks =
                                          await placemarkFromCoordinates(
                                              location[0][0], location[0][1]);

                                      controller
                                          .distanceBetweenMyLocationAndMarker(<double>[
                                        location[0][0],
                                        location[0][1]
                                      ]).then((value) {
                                        controller.distance = value;
                                        controller.showdetail =
                                            !controller.showdetail;
                                        controller.update();
                                      });
                                      controller.update();
                                    },
                                  ),
                                ),
                                Marker(
                                  markerId: const MarkerId('2'),
                                  position: LatLng(
                                    location[1][0],
                                    location[1][1],
                                  ),
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                      BitmapDescriptor.hueRed),
                                  infoWindow: InfoWindow(
                                    title: 'نقطة الانطلاق',
                                    snippet: '',
                                    onTap: () async {
                                      controller.currentLocation = LatLng(
                                        location[1][0],
                                        location[1][1],
                                      );
                                      controller.placemarks =
                                          await placemarkFromCoordinates(
                                              location[1][0], location[1][1]);

                                      controller
                                          .distanceBetweenMyLocationAndMarker(<double>[
                                        location[1][0],
                                        location[1][1]
                                      ]).then((value) {
                                        controller.distance = value;
                                        controller.showdetail =
                                            !controller.showdetail;
                                        controller.update();
                                      });
                                      controller.update();
                                    },
                                  ),
                                ),
                              }
                            : {
                                Marker(
                                  markerId: const MarkerId('1'),
                                  position: LatLng(
                                    location[0][0],
                                    location[0][1],
                                  ),
                                  infoWindow: InfoWindow(
                                    title: 'نقطة الوصول',
                                    snippet: '',
                                    onTap: () async {
                                      controller.currentLocation = LatLng(
                                        location[0][0],
                                        location[0][1],
                                      );
                                      controller.placemarks =
                                          await placemarkFromCoordinates(
                                              location[0][0], location[0][1]);

                                      controller
                                          .distanceBetweenMyLocationAndMarker(<double>[
                                        location[0][0],
                                        location[0][1]
                                      ]).then((value) {
                                        controller.distance = value;
                                        controller.showdetail =
                                            !controller.showdetail;
                                        controller.update();
                                      });
                                      controller.update();
                                    },
                                  ),
                                ),
                              },
                      ),
                    ),
                    Positioned(
                      bottom: 93,
                      right: 12,
                      child: Container(
                        width: 38,
                        height: 40,
                        color: Colors.white54,
                        child: IconButton(
                          onPressed: () {
                            controller.changeMapMode();
                          },
                          icon: const Icon(Icons.settings,
                              color: Colors.black54, size: 25),
                        ),
                      ),
                    ),
                    controller.showdetail
                        ? Positioned(
                            bottom: 5,
                            child: AnimatedContainer(
                              decoration: snowContainer,
                              height: Get.height * 0.5,
                              width: Get.width,
                              duration: const Duration(milliseconds: 1500),
                              curve: Curves.easeInSine,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.showdetail =
                                                !controller.showdetail;
                                            controller.update();
                                          },
                                          icon: const Icon(Icons.close,
                                              color: Colors.blue, size: 30),
                                        ),
                                      ],
                                    ),
                                    LocationInfo(
                                      position: controller.currentLocation,
                                      distance: controller.distance,
                                      placemarks: controller.placemarks,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ]),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
