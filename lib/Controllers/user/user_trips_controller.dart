import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/car.dart';
import '../../Models/trip.dart';

class UserTripsController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  LatLng? currentLocation;
  LatLng? destinationLocation;
  List<Trip> pendingTrips = [];
  List<Car> pendingCars = [];
  Trip? currentTrip;
  Car? car;

  void getCurrentTripListener() async {
    FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .where('status', whereIn: ['accepted', 'waiting'])
        .snapshots()
        .listen((event) {
          if (event.docs.isNotEmpty) {
            FirebaseFirestore.instance
                .collection('trips')
                .where("id", isEqualTo: event.docs.first.data()['tripId'])
                .snapshots()
                .listen((event) {
              currentTrip = Trip.fromJson(event.docs.first.data());
              FirebaseFirestore.instance
                  .collection('drivers')
                  .doc(currentTrip!.uid)
                  .snapshots()
                  .listen((event) {
                car = Car.fromJson(event.data()!["car"]);
                update();
              });
            });
          }
        });
  }

  void getRequestTripListener() async {
    FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .where('status', whereIn: ['pending'])
        .snapshots()
        .listen((event) {
          if (event.docs.isNotEmpty) {
            for (var doc in event.docs) {
              FirebaseFirestore.instance
                  .collection('trips')
                  .where("id", isEqualTo: doc.data()['tripId'])
                  .snapshots()
                  .listen((event) {
                pendingTrips.add(Trip.fromJson(event.docs.first.data()));
                FirebaseFirestore.instance
                    .collection('drivers')
                    .doc(pendingTrips.last.uid)
                    .snapshots()
                    .listen((event) {
                  pendingCars.add(Car.fromJson(event.data()!["car"]));
                  update();
                });
              });
            }
          }
        });
  }

  @override
  void onInit() {
    getCurrentTripListener();
    super.onInit();
  }
}
