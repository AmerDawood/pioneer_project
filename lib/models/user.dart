class User {
  String? first_name;
  String? last_name;
  String? email;
  String? type;
  String? updatedAt;
  String? createdAt;
  String? token;
  String? phone;
  String? place;
  String? image;
  int? id;

  User.fromJson(Map<String, dynamic> json) {
    first_name = json['first_name'];
    last_name = json['last_name'];
    email = json['email'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    phone = json['phone'];
    place = json['place'];
    token = json['token'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'type': type,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'phone': phone,
      'place': place,
      'token': token,
      'image': image,
    };
  }
}