class Car {
  String type;
  String model;
  int capacity;
  String color;
  String plateNumber;
  bool driverGender;

  Car({
    required this.type,
    required this.model,
    required this.capacity,
    required this.color,
    required this.plateNumber,
    required this.driverGender,
  });

  Map<String, dynamic> toJson() {
    return {
      "carType": type,
      "carModel": model,
      "carCapacity": capacity,
      "carColor": color,
      "carNumber": plateNumber,
      "driverGender": driverGender,
    };
  }

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      type: json["carType"],
      model: json["carModel"],
      capacity: json["carCapacity"],
      color: json["carColor"],
      plateNumber: json["carNumber"],
      driverGender: json["driverGender"] == "ذكر" ? true : false,
    );
  }
}
