// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../Controllers/driver/create_trip_controller.dart';
import '../../../Controllers/driver/get_location_controller.dart';
import '../../Widgets/Buttons/zoom_tap_button.dart';
import '../../Widgets/Inputs/input_field.dart';
import '../../Widgets/custom/confirm_dialog.dart';
import '../../Widgets/custom/title_with_icon.dart';
import 'get_location_screen.dart';

// ignore: must_be_immutable
class CreateTripScreen extends StatelessWidget {
  CreateTripScreen({super.key});
  static const String routeName = '/CreateTripScreen';
  GetLocationController controller =
      Get.put(GetLocationController(), permanent: true);
  CreateTripController createTripController =
      Get.put(CreateTripController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        title: const Text('انشاء رحلة جديدة'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                  title: 'تأكيد الرحلة',
                  content: ConfirmTripDialog(
                    onCancel: () {
                      Get.back();
                    },
                    onConfirm: () {
                      createTripController.uploadTrip();
                      controller.update();
                    },
                  ));
            },
            icon: const Icon(Icons.card_travel, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: GetBuilder<GetLocationController>(builder: (_) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/images/destination.png',
                height: Get.height * 0.3,
                width: Get.width,
                fit: BoxFit.scaleDown,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const Gap(5),
              const TitleWithIcon(
                text: 'اكتب عنوان الرحلة',
                icon: Icon(
                  Icons.trip_origin,
                  color: Colors.blue,
                ),
              ),
              InputField(
                inputController: createTripController.title,
                maxchar: 30,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const TitleWithIcon(
                text: 'اكتب وصف الرحلة',
                icon: Icon(
                  Icons.description,
                  color: Colors.blue,
                ),
              ),
              InputField(
                inputController: createTripController.description,
                maxchar: 150,
                maxLines: 3,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const TitleWithIcon(
                text: 'حدد سعر الرحلة',
                icon: Icon(
                  Icons.attach_money,
                  color: Colors.green,
                ),
              ),
              InputField(
                inputController: createTripController.price,
                maxchar: 5,
                keyboardType: TextInputType.number,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              const TitleWithIcon(
                text: 'حدد  عدد الركاب',
                icon: Icon(
                  Icons.people,
                  color: Colors.green,
                ),
              ),
              InputField(
                inputController: createTripController.availableSeats,
                maxchar: 2,
                keyboardType: TextInputType.number,
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              TitleWithIcon(
                text: 'قم بتحديد بيانات المواقع',
                icon: createTripController.destination != null &&
                        createTripController.source != null
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 30,
                      )
                    : const Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 30,
                      ),
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ZoomTapButton(
                    image: 'assets/images/place.png',
                    text: 'تحديد نقطة البداية و الوصول',
                    onTap: () {
                      Get.toNamed(GetLocationScreen.routeName);
                    },
                  ),
                  
                ],
              ),
           
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
            ],
          ),
        );
      }),
    );
  }
}
