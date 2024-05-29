import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controllers/driver/trips_controller.dart';
import '../../Widgets/custom/history_list.dart';

// ignore: must_be_immutable
class HistoryTripsScreen extends StatelessWidget {
  HistoryTripsScreen({super.key});
  TripsController tripsController = Get.put(TripsController());
  @override
  Widget build(BuildContext context) {
    return tripsController.finishedTrips.isEmpty
        ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لا يوجد رحلات سابقة',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        : ListView.builder(itemBuilder: (context, index) {
            return HistoryList(
              passengers: 1,
              distance: 22.5,
              price: '25',
              status: 'مكتملة',
              onDeleted: () {},
            );
          });
  }
}
