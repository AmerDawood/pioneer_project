class News {
  final int id;
  final String title;
  final String details;
  final String? image;
  final String newsDate;
  final Organization organization;

  News({
    required this.id,
    required this.title,
    required this.details,
    this.image,
    required this.newsDate,
    required this.organization,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'] is String ? int.parse(json['id']) : json['id'], // handle string or int
      title: json['title'] ?? '',
      details: json['details'] ?? '',
      image: json['image'], // Nullable image
      newsDate: json['news_date'] ?? '', // Default empty string if null
      organization: json['organization'] != null
          ? Organization.fromJson(json['organization'])
          : Organization(  // Handle missing organization
        id: 0,
        name: 'Unknown',
        logo: null,
        country: 'Unknown',
        city: 'Unknown',
        type: 'Unknown',
        sector: 'Unknown',
        size: 'Unknown',
        website: 'Unknown',
        foundedAt: 'Unknown',
      ),
    );
  }
}

class Organization {
  final int id;
  final String name;
  final String? logo;
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
    this.logo,
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
      id: json['id'] is String ? int.parse(json['id']) : json['id'], // handle string or int
      name: json['name'] ?? 'Unknown',
      logo: json['logo'],
      country: json['country'] ?? 'Unknown',
      city: json['city'] ?? 'Unknown',
      type: json['type'] ?? 'Unknown',
      sector: json['sector'] ?? 'Unknown',
      size: json['size'] ?? 'Unknown',
      website: json['website'] ?? 'Unknown',
      foundedAt: json['founded_at'] ?? 'Unknown',
    );
  }
}
