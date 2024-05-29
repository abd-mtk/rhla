import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/car.dart';
import '../../Models/trip.dart';
import '../../Views/User/Trip Screens/car_info_screen.dart';

class UserCurrentTripController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  List<Trip> currentTrips = [];
  List<Trip> historyTrips = [];
  Car? car;

  void showTripDetails(Trip trip) {
    // print(trip.toJson());
    FirebaseFirestore.instance
        .collection('drivers')
        .doc(trip.uid)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  car = Car.fromJson(value.data()!["car"]),
                }
            })
        .then((value) => {
              Get.toNamed(CarInfoScreen.routeName, arguments: [trip, car])
            });
  }

  void getCurrentTrip() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('status', whereIn: ['waiting', 'accepted', "completed"])
        .snapshots()
        .listen((event) {
          currentTrips.clear();
          for (var element in event.docs) {
            FirebaseFirestore.instance
                .collection('trips')
                .where('id', isEqualTo: element['tripId'])
                .get()
                .then((value) => {
                      if (value.docs.isNotEmpty)
                        {
                          value.docs.forEach((element) {
                            currentTrips.add(Trip.fromJson(element.data()));
                            update();
                          })
                        }
                    });
          }
        });
  }

  void getHistorytTrip() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('status', whereNotIn: ['waiting', 'accepted', "completed"])
        .snapshots()
        .listen((event) {
          historyTrips.clear();
          for (var element in event.docs) {
            FirebaseFirestore.instance
                .collection('trips')
                .where('id', isEqualTo: element['tripId'])
                .get()
                .then((value) => {
                      if (value.docs.isNotEmpty)
                        {
                          value.docs.forEach((element) {
                            historyTrips.add(Trip.fromJson(element.data()));
                            update();
                          })
                        }
                    });
          }
        });
  }

  void deleteMyOrder(String tripId) {
    FirebaseFirestore.instance
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('tripId', isEqualTo: tripId)
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance
                        .collection('orders')
                        .doc(element.id)
                        .delete();
                    historyTrips.removeWhere((element) => element.id == tripId);
                    update();
                  })
                }
            })
        .then((value) => {
              Get.snackbar('تم', 'تم حذف الطلب',
                  titleText: const Text(
                    'تم',
                    style: TextStyle(color: Colors.white),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                  messageText: const Text(
                    'تم حذف الطلب',
                    style: TextStyle(color: Colors.white),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                  ),
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.TOP)
            });
  }

  @override
  void onInit() {
    getCurrentTrip();
    getHistorytTrip();
    super.onInit();
  }
}
