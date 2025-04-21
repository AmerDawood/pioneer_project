// import 'news.dart';
//
// class Initiative {
//   final int id;
//   final String title;
//   final Organization organization;
//   final String description;
//   final int participants;
//   final String date;
//   final String imageUrl;
//
//   Initiative({
//     required this.id,
//     required this.title,
//     required this.organization,
//     required this.description,
//     required this.participants,
//     required this.date,
//     required this.imageUrl,
//   });
//
//
//   factory Initiative.fromJson(Map<String, dynamic> json) {
//     return Initiative(
//       id: json['id'],
//       title: json['title'],
//       details: json['description'],
//       image: json['image'],
//       newsDate: json['news_date'],
//       organization: Organization.fromJson(json['organization']),
//     );
//   }
//
//
//
//
// }

class Initiative {
  final int id;
  final String name;
  final int organizationId;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final int maxParticipants;
  final String details;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int hours;

  Initiative({
    required this.id,
    required this.name,
    required this.organizationId,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.maxParticipants,
    required this.details,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.hours,
  });

  factory Initiative.fromJson(Map<String, dynamic> json) {
    return Initiative(
      id: json['id'],
      name: json['name'],
      organizationId: json['organization_id'],
      location: json['location'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      maxParticipants: json['max_participants'],
      details: json['details'],
      image: json['image'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      hours: json['hours'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'organization_id': organizationId,
      'location': location,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'max_participants': maxParticipants,
      'details': details,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'hours': hours,
    };
  }
}
