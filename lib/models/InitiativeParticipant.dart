class InitiativeParticipant {
  final int id;
  final int initiativeId;
  final int userId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  InitiativeParticipant({
    required this.id,
    required this.initiativeId,
    required this.userId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory InitiativeParticipant.fromJson(Map<String, dynamic> json) {
    return InitiativeParticipant(
      id: json['id'],
      initiativeId: json['initiative_id'],
      userId: json['user_id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'initiative_id': initiativeId,
      'user_id': userId,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'user': user.toJson(),
    };
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? profilePicture;
  final String? emailVerifiedAt;
  final String phone;
  final String role;
  final String? profileImage;
  final int volunteerHours;
  final int participatedInitiatives;
  final String? provider;
  final String? providerId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? organizationId;
  final String? jobTitle;
  final String? preferredLanguage;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePicture,
    this.emailVerifiedAt,
    required this.phone,
    required this.role,
    this.profileImage,
    required this.volunteerHours,
    required this.participatedInitiatives,
    this.provider,
    this.providerId,
    required this.createdAt,
    required this.updatedAt,
    this.organizationId,
    this.jobTitle,
    this.preferredLanguage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePicture: json['profile_picture'],
      emailVerifiedAt: json['email_verified_at'],
      phone: json['phone'],
      role: json['role'],
      profileImage: json['profile_image'],
      volunteerHours: json['volunteer_hours'],
      participatedInitiatives: json['participated_initiatives'],
      provider: json['provider'],
      providerId: json['provider_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      organizationId: json['organization_id'],
      jobTitle: json['job_title'],
      preferredLanguage: json['preferred_language'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_picture': profilePicture,
      'email_verified_at': emailVerifiedAt,
      'phone': phone,
      'role': role,
      'profile_image': profileImage,
      'volunteer_hours': volunteerHours,
      'participated_initiatives': participatedInitiatives,
      'provider': provider,
      'provider_id': providerId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'organization_id': organizationId,
      'job_title': jobTitle,
      'preferred_language': preferredLanguage,
    };
  }
}
