import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddEventInformation {
  String uid;
  String title;
  String description;
  String image;
  DateTime startDate;
  DateTime? endDate;
  LatLng? location;
  List<Placemark>? placemarks;

  AddEventInformation({
    required this.uid,
    required this.title,
    required this.description,
    required this.image,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.placemarks,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'title': title,
      'description': description,
      'image': image,
      'startDate': startDate,
      // if endDate is null, set it to startDate value + 1 day
      'endDate': endDate ?? startDate.add(const Duration(days: 1)),
      'location': location != null ? location!.toJson() : null,
      'placemarks': placemarks != null ? placemarks!.first.toJson() : null,
    };
  }

  factory AddEventInformation.fromJson(Map<String, dynamic> json) {
    return AddEventInformation(
      uid: json['uid'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      location: json['location'],
      placemarks: json['placemarks'],
    );
  }
}
