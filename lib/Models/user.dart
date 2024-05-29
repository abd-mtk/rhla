class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? gender;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.gender,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "gender": gender,
    };
  }
}
