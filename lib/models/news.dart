class Organization {
  final int id;
  final String name;
  final String logo;
  final String country;
  final String city;
  final String type;
  final String sector;
  final String size;
  final String website;
  final String foundedAt;

  Organization({
    required this.id,
    required this.name,
    required this.logo,
    required this.country,
    required this.city,
    required this.type,
    required this.sector,
    required this.size,
    required this.website,
    required this.foundedAt,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      country: json['country'],
      city: json['city'],
      type: json['type'],
      sector: json['sector'],
      size: json['size'],
      website: json['website'],
      foundedAt: json['founded_at'],
    );
  }
}
class News {
  final int id;
  final String title;
  final String details;
  final String image;
  final String newsDate;
  final Organization organization;

  News({
    required this.id,
    required this.title,
    required this.details,
    required this.image,
    required this.newsDate,
    required this.organization,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      details: json['details'],
      image: json['image'],
      newsDate: json['news_date'],
      organization: Organization.fromJson(json['organization']),
    );
  }
}
