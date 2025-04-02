import 'package:pioneer_project/api/api_settings.dart';

class News {
  final int id;
  final String title;
  final String details;
  final String? image;
  final DateTime newsDate;
  final int organizationId;
  final Organization? organization;

  News({
    required this.id,
    required this.title,
    required this.details,
    this.image,
    required this.newsDate,
    required this.organizationId,
    this.organization,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      details: json['details'],
      image: json['image'],
      newsDate: DateTime.parse(json['news_date']),
      organizationId: json['organization_id'],
      organization: json['organization'] != null
          ? Organization.fromJson(json['organization'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'image': image,
      'news_date': newsDate.toIso8601String(),
      'organization_id': organizationId,
      'organization': organization?.toJson(),
    };
  }

  String get fullImageUrl {
    if (image == null) return '';
    if (image!.startsWith('http')) return image!;
    return '/storage/$image';
  }
}

class Organization {
  final int id;
  final String name;
  final String? logo;
  final String? description;

  Organization({
    required this.id,
    required this.name,
    this.logo,
    this.description,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'description': description,
    };
  }

  String get fullLogoUrl {
    if (logo == null) return '';
    if (logo!.startsWith('http')) return logo!;
    return '/storage/$logo';
  }
}