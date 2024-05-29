import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../Controllers/driver/create_trip_controller.dart';
import '../../../Controllers/driver/get_location_controller.dart';
import '../../Constants/style/style.dart';
import '../../Widgets/custom/location_info.dart';

// ignore: must_be_immutable
class GetLocationScreen extends StatelessWidget {
  GetLocationScreen({super.key});
  static const String routeName = '/GetLocationScreen';
  GetLocationController controller = Get.find();
  CreateTripController createTripController = Get.find();

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
                        indoorViewEnabled: true,
                        mapType: controller.currentCameraMode,
                        initialCameraPosition: controller.cameraPosition,
                        onLongPress: controller.onLongMapTap,
                        markers: controller.markers,
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
            ZoomTapAnimation(
              child: Container(
                height: Get.height * 0.1,
                width: Get.width,
                color: Colors.blueGrey[900],
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.arrow_back_ios,
                        color: Colors.blueAccent, size: 30),
                    Text(
                      'تاكيد الموقع المحدد ',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                createTripController.destination = controller.destination;
                createTripController.source = controller.source;
                controller.update();
                Get.back();
              },
            ),
          ],
        );
      }),
    );
  }
}
