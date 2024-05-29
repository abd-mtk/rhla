class TripOrder {
  String tripId;
  String userId;
  String status;
  String driverId;
  List<dynamic> destination;
  List<dynamic> source;

  TripOrder({
    required this.tripId,
    required this.userId,
    required this.driverId,
    this.status = "pending",
    required this.destination,
    required this.source,
  });
// QChO7NOTy3kIINXJin5n
// BoQC9Y26iLXaHhB1ev5PrOuoYNJ2
  Map<String, dynamic> toJson() {
    return {
      "tripId": tripId,
      "uid": userId,
      "status": status,
      "driverId": driverId,
      "destination": destination,
      "source": source,
    };
  }

  factory TripOrder.fromJson(Map<String, dynamic> json) {
    return TripOrder(
      tripId: json["tripId"],
      userId: json["uid"],
      status: json["status"],
      driverId: json["driverId"],
      destination: json["destination"],
      source: json["source"],
    );
  }
}
