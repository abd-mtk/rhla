import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Models/trip.dart';

class TripsController extends GetxController {
  String? uid = FirebaseAuth.instance.currentUser!.uid;
  Trip? currenTrip;
  List<Trip> trips = [];
  List<Trip> pendingTrips = [];
  List<Trip> startedTrips = [];
  List<Trip> finishedTrips = [];
  LatLng? tripLocation;

  void getCurrentTrip() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        // "started" || "stopped"
        .where("status", whereIn: ["started", "stopped"])
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  currenTrip = Trip.fromJson(value.docs.first.data()),
                  currenTrip!.id = value.docs.first.id,
                  update()
                }
              else
                {currenTrip = null, update()}
            });
  }

  // write a function to get the current trip with listener
  void getCurrentTripWithListener() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .where("status", whereIn: ["started", "stopped"])
        .snapshots()
        .listen((event) {
          if (event.docs.isNotEmpty) {
            currenTrip = Trip.fromJson(event.docs.first.data());
            currenTrip!.id = event.docs.first.id;
            update();
          } else {
            currenTrip = null;
            update();
          }
        });
  }

  void getAllTrips() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  for (var doc in value.docs)
                    {trips.add(Trip.fromJson(doc.data())..id = doc.id)},
                  update()
                }
            });
  }

  // write a function to convert the status of the trip to started
  // and update the all trips in the database to be pending
  void startTrip(String id) async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .doc(id)
        .update({"status": "started"});

    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  for (var doc in value.docs)
                    {
                      if (doc.id != id && doc.data()["status"] != "finished")
                        {
                          FirebaseFirestore.instance
                              .collection('drivers')
                              .doc(uid)
                              .collection("trips")
                              .doc(doc.id)
                              .update({"status": "pending"})
                        }
                    },
                  update()
                }
            });
    await FirebaseFirestore.instance.collection("trips").get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              for (var doc in value.docs)
                {
                  if (doc.data()["uid"] == uid &&
                      doc.data()["id"] != id &&
                      doc.data()["status"] != "finished")
                    {
                      FirebaseFirestore.instance
                          .collection("trips")
                          .doc(doc.id)
                          .update({"status": "pending"})
                    }
                }
            }
        });
    await FirebaseFirestore.instance.collection("trips").get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              for (var doc in value.docs)
                {
                  if (doc.data()["uid"] == uid && doc.data()["id"] == id)
                    {
                      FirebaseFirestore.instance
                          .collection("trips")
                          .doc(doc.id)
                          .update({"status": "started"})
                    }
                }
            }
        });

    getCurrentTrip();
  }

  // stop the trip
  void stopTrip(String id) async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .doc(id)
        .update({"status": "stopped"});
    await FirebaseFirestore.instance.collection("trips").get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              for (var doc in value.docs)
                {
                  if (doc.data()["uid"] == uid && doc.data()["id"] == id)
                    {
                      FirebaseFirestore.instance
                          .collection("trips")
                          .doc(doc.id)
                          .update({"status": "stopped"})
                    }
                }
            }
        });
    getCurrentTrip();
  }

  // write a function to convert the status of the trip to finished and update in the database
  void finishTrip(String id) async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .doc(id)
        .update({"status": "finished"});
    await FirebaseFirestore.instance.collection("trips").get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              for (var doc in value.docs)
                {
                  if (doc.data()["uid"] == uid && doc.data()["id"] == id)
                    {
                      FirebaseFirestore.instance
                          .collection("trips")
                          .doc(doc.id)
                          .update({"status": "finished"})
                    }
                }
            }
        });
    getCurrentTrip();
  }

// get location of the trip and go to the map
  void goToMap(String id) async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .doc(id)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  tripLocation = LatLng(value.data()!["destination"][0],
                      value.data()!["destination"][1]),
             
                }
            });
  }

  // get all finished trips
  void getFinishedTrips() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .where("status", isEqualTo: "finished")
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  for (var doc in value.docs)
                    {finishedTrips.add(Trip.fromJson(doc.data())..id = doc.id)},
                  update()
                }
            });
  }

  // get all started trips
  void getStartedTrips() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .where("status", isEqualTo: "started")
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  for (var doc in value.docs)
                    {startedTrips.add(Trip.fromJson(doc.data())..id = doc.id)},
                  update()
                }
            });
  }

  // get all pending trips
  void getPendingTrips() async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .where("status", isEqualTo: "pending")
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  for (var doc in value.docs)
                    {pendingTrips.add(Trip.fromJson(doc.data())..id = doc.id)},
                  update()
                }
            });
  }

  // write function seats in the trip and send accept request to the user and  subtract one from the number of
  void subtractSeat(String id, String userId, String orderId) async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .doc(id)
        .update({"availableSeats": FieldValue.increment(-1)});
    await FirebaseFirestore.instance.collection("trips").get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              for (var doc in value.docs)
                {
                  if (doc.data()["uid"] == uid && doc.data()["id"] == id)
                    {
                      FirebaseFirestore.instance
                          .collection("trips")
                          .doc(doc.id)
                          .update({"availableSeats": FieldValue.increment(-1)})
                    }
                }
            }
        });
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("orders")
        .doc(orderId)
        .update({"status": "accepted"});
  }

  // write function seats in the trip and send reject request to the user
  void rejectSeat(String userId, String orderId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection("orders")
        .doc(orderId)
        .update({"status": "rejected"});
  }

  // delete trip from the database and delete all orders in this trip
  void deleteTrip(String id) async {
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .doc(id)
        .delete();
    await FirebaseFirestore.instance.collection("trips").get().then((value) => {
          if (value.docs.isNotEmpty)
            {
              for (var doc in value.docs)
                {
                  if (doc.data()["uid"] == uid && doc.data()["id"] == id)
                    {
                      FirebaseFirestore.instance
                          .collection("trips")
                          .doc(doc.id)
                          .delete()
                    }
                }
            }
        });
    await FirebaseFirestore.instance
        .collection('drivers')
        .doc(uid)
        .collection("trips")
        .doc(id)
        .collection("orders")
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  for (var doc in value.docs)
                    {
                      FirebaseFirestore.instance
                          .collection('drivers')
                          .doc(uid)
                          .collection("trips")
                          .doc(id)
                          .collection("orders")
                          .doc(doc.id)
                          .delete()
                    }
                }
            });

    // and delete all orders have same tripId
    await FirebaseFirestore.instance
        .collection("orders")
        .get()
        .then((value) => {
              if (value.docs.isNotEmpty)
                {
                  for (var doc in value.docs)
                    {
                      if (doc.data()["tripId"] == id)
                        {
                          FirebaseFirestore.instance
                              .collection("orders")
                              .doc(doc.id)
                              .delete()
                        }
                    }
                }
            });
  }

  @override
  void onInit() {
    getCurrentTrip();
    getCurrentTripWithListener();
    getAllTrips();
    getFinishedTrips();
    getStartedTrips();
    getPendingTrips();
    super.onInit();
  }
}
