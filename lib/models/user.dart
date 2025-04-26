// class User {
//   final int id;
//   final String name;
//   final String email;
//
//   User({
//     required this.id,
//     required this.name,
//     required this.email,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//     };
//   }
// }

class User {
  final int id;
  final String name;
  final String email;
  final String role; // 👈 إضافة role

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role, // 👈 إضافة role في البناء
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'], // 👈 إضافة role هنا
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role, // 👈 إضافة role هنا
    };
  }
}
