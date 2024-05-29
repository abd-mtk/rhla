import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../Models/order.dart';
import '../../Models/user.dart' as user;

class OrderController extends GetxController {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  List<TripOrder> orders = [];
  List<TripOrder> acceptedOrders = [];
  List<TripOrder> waitingOrders = [];
  List<TripOrder> rejectedOrders = [];
  List<TripOrder> pendingOrders = [];

  List<user.User> users = [];
  List<user.User> acceptedUsers = [];
  List<user.User> waitingUsers = [];
  List<user.User> rejectedUsers = [];
  List<user.User> pendingUsers = [];

// QChO7NOTy3kIINXJin5n
// BoQC9Y26iLXaHhB1ev5PrOuoYNJ2

// get all order for current user from collection orders using listener

  void clear() {
    orders.clear();
    acceptedOrders.clear();
    waitingOrders.clear();
    rejectedOrders.clear();
    pendingOrders.clear();
    users.clear();
    acceptedUsers.clear();
    waitingUsers.clear();
    rejectedUsers.clear();
    pendingUsers.clear();
  }

  void getOrders() {
    clear();
    FirebaseFirestore.instance
        .collection('orders')
        .where('driverId', isEqualTo: uid)
        .snapshots()
        .listen((event) {
      clear();
      if (event.docs.isEmpty) {
        return;
      } else {
        for (var element in event.docChanges) {
          // print(element.doc.data()!);
          TripOrder order = TripOrder.fromJson(element.doc.data()!);
          orders.add(order);
          if (order.status == 'accepted' ||
              order.status == 'waiting' ||
              order.status == "completed") {
            acceptedOrders.add(order);
          } else if (order.status == 'rejected') {
            rejectedOrders.add(order);
          } else if (order.status == 'pending') {
            pendingOrders.add(order);
          }
        }
        getUsers();
      }
    });
  }

  // get all users info by userId in the orders
  void getUsers() {
    for (var element in orders) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(element.userId)
          .get()
          .then((value) {
        if (value.data()!.isNotEmpty) {
          users.add(user.User.fromJson(value.data()!));
          if (element.status == 'accepted' ||
              element.status == 'waiting' ||
              element.status == "completed") {
            acceptedUsers.add(user.User.fromJson(value.data()!));
          } else if (element.status == 'rejected') {
            rejectedUsers.add(user.User.fromJson(value.data()!));
          } else if (element.status == 'pending') {
            pendingUsers.add(user.User.fromJson(value.data()!));
          }
        }
        update();
      });
    }
  }

  void updateOrderStatus(String status, TripOrder tripId) {
    FirebaseFirestore.instance
        .collection('orders')
        .where('uid', isEqualTo: uid)
        .where('tripId', isEqualTo: tripId.tripId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('orders')
            .doc(value.docs.first.id)
            .update({"status": status});
      }
    });
  }

  void acceptedOrder(String status, String tripId) {
    if (status == "waiting") {
      FirebaseFirestore.instance
          .collection('trips')
          .where('uid', isEqualTo: uid).where('id',isEqualTo: tripId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          FirebaseFirestore.instance
              .collection('trips')
              .doc(value.docs.first.id)
              .update({"availableSeats": FieldValue.increment(-1)});
        }
      }).then((value) => {
                // updade the availableSeats in driver trips
                FirebaseFirestore.instance
                    .collection('drivers')
                    .doc(uid)
                    .collection("trips")
                    .doc(tripId)
                    .update({"availableSeats": FieldValue.increment(-1)})
              });
      FirebaseFirestore.instance
          .collection('orders')
          .where('uid', isEqualTo: uid)
          .where('tripId', isEqualTo: tripId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          FirebaseFirestore.instance
              .collection('orders')
              .doc(value.docs.first.id)
              .update({"status": status});
        }
      });
    } else {
       FirebaseFirestore.instance
          .collection('orders')
          .where('uid', isEqualTo: uid)
          .where('tripId', isEqualTo: tripId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          FirebaseFirestore.instance
              .collection('orders')
              .doc(value.docs.first.id)
              .update({"status": status});
        }
      });
    }
  }

  @override
  void onInit() {
    getOrders();
    super.onInit();
  }
}
