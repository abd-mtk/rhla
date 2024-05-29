class Trip {
  String? uid;
  String? id;
  String title;
  String price;
  String description;
  int availableSeats;
  String status;
  List<dynamic> destination;
  List<dynamic> source = [];

  Trip({
     this.uid,
     this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.availableSeats,
    required this.status,
    required this.destination,
    required this.source,
  });

  Trip.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        id = json['id'],
        title = json['title'],
        price = json['price'],
        description = json['description'],
        availableSeats = json['availableSeats'],
        status = json['status'],
        destination = json['destination'],
        source = json['source'];
        

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'id': id,
        'title': title,
        'price': price,
        'description': description,
        'availableSeats': availableSeats,
        'status': status,
        'destination': destination,
        'source': source,
      };
}
