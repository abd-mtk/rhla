import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rhla/Views/Constants/style/style.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../Controllers/user/display_available_trips_on_map_controller.dart';
import '../../Widgets/custom/available_trip.dart';
import '../../Widgets/custom/location_info.dart';

// ignore: must_be_immutable
class DisplayAvailableTripOnMapScreen extends StatelessWidget {
  DisplayAvailableTripOnMapScreen({super.key});
  static const routeName = '/display-available-trip-on-map-screen';
  DisplayAvailableTripOnMapController controller =
      Get.put(DisplayAvailableTripOnMapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: const Text('البحث عن سائق'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            controller.showInfoWindow();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map),
            onPressed: () {
              controller.changeMapMode();
            },
          ),
        ],
      ),
      body: GetBuilder<DisplayAvailableTripOnMapController>(builder: (_) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              child: SizedBox(
                height: Get.height * 0.6,
                width: Get.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.4,
                      child: GoogleMap(
                        myLocationEnabled: true,
                        mapType: controller.currentCameraMode,
                        initialCameraPosition: const CameraPosition(
                            target:
                                LatLng(33.314815005455586, 44.366285875439644),
                            zoom: 10),
                        onLongPress: controller.onLongMapTap,
                        markers: controller.markers,
                      ),
                    ),
                    Container(
                      height: Get.height * 0.1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(children: [
                            controller.destinationLocation != null
                                ? const Icon(
                                    Icons.done_all_sharp,
                                    color: Colors.red,
                                  )
                                : Container(),
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            const Text("الوجهة",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ]),
                          controller.currentLocation != null &&
                                  controller.destinationLocation != null
                              ? ZoomTapAnimation(
                                  onTap: () {
                                    controller.getAvailableTrips();
                                  },
                                  child: Container(
                                    height: Get.height * 0.08,
                                    width: Get.width * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.purple,
                                    ),
                                    child: const Center(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          Text("بحث",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          Row(children: [
                            controller.currentLocation != null
                                ? const Icon(
                                    Icons.done_all_sharp,
                                    color: Colors.blue,
                                  )
                                : Container(),
                            const Icon(
                              Icons.location_on,
                              color: Colors.blue,
                            ),
                            const Text("موقعي",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                          ]),
                        ],
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("نتائج البحث", style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    const Divider(),
                  ],
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                              position: controller.currentLocation!,
                              distance: controller.distance,
                              placemarks: controller.placemarks,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              bottom: -35,
              child: AvailableTrip(controller: controller),
            )
          ],
        );
      }),
    );
  }
}
