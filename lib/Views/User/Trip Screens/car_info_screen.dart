import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../Controllers/user/display_available_trips_on_map_controller.dart';
import '../../../Models/car.dart';
import '../../../Models/trip.dart';
import '../../Constants/fonts/fonts.dart';
import '../../Widgets/custom/custom_text_section.dart';

// ignore: must_be_immutable
class CarInfoScreen extends StatelessWidget {
  CarInfoScreen({super.key});
  static const routeName = '/car-info-screen';
  Car? car = Get.arguments[1];
  Trip? trip = Get.arguments[0];
  List<String> cars = [
    "assets/images/car4p.png",
    "assets/images/bus.png",
    "assets/images/longbus.png"
  ];
  DisplayAvailableTripOnMapController controller =
      Get.put(DisplayAvailableTripOnMapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: const Text('معلومات الرحلة'),
        centerTitle: true,
      ),
      body: GetBuilder<DisplayAvailableTripOnMapController>(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.3,
                child: GoogleMap(
                  myLocationEnabled: true,
                  mapType: controller.currentCameraMode,
                  initialCameraPosition: CameraPosition(
                      target:
                          LatLng(trip!.destination[0], trip!.destination[1]),
                      zoom: 8),
                  markers: {
                    Marker(
                      markerId: const MarkerId('1'),
                      position: LatLng(trip!.source[0], trip!.source[1]),
                      infoWindow: const InfoWindow(title: 'نقطة الانطلاق'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                    ),
                    Marker(
                      markerId: const MarkerId('2'),
                      position:
                          LatLng(trip!.destination[0], trip!.destination[1]),
                      infoWindow: const InfoWindow(title: 'الوجهة'),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                    ),
                  },
                ),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                    child: car != null
                        ? Column(
                            children: [
                              TextSection(
                                text: 'عنوان الرحلة : ${trip!.title}',
                              ),
                              TextSection(
                                text: 'الوصف : ${trip!.description}',
                                lines: 4,
                              ),
                              Image.asset(
                                cars[car!.type == "سيارة"
                                    ? 0
                                    : car!.type == "باص"
                                        ? 1
                                        : 2],
                                fit: BoxFit.scaleDown,
                                width: 200,
                                height: 200,
                              ),
                              const Text(
                                'معلومات المركبة',
                                style: titleTextStyle,
                              ),
                              TextSection(
                                text:
                                    'النوع : ${car!.type == "سيارة" ? "صالون" : car!.type}',
                              ),
                              TextSection(
                                text: 'الموديل : ${car!.model}',
                              ),
                              TextSection(
                                text: 'اللون : ${car!.color}',
                              ),
                              TextSection(
                                text: 'رقم اللوحة : ${car!.plateNumber}',
                              ),
                              // capacity
                              TextSection(
                                text: 'السعة : ${car!.capacity} راكب',
                              ),
                              // driver gender
                              TextSection(
                                text:
                                    'جنس السائق : ${car!.driverGender == true ? "ذكر" : "أنثى"}',
                              ),
                              // add google map
                            ],
                          )
                        : const Center(
                            child: Text('لا يوجد معلومات مسجلة'),
                          )),
              ),
            ],
          ),
        );
      }),
    );
  }
}
