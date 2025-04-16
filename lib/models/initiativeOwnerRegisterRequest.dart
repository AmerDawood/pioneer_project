class InitiativeOwnerRegisterRequest {
  final String orgName;
  final String? orgLogoPath; // مسار الصورة من الجهاز
  final String country;
  final String city;
  final String type;
  final String sector;
  final String size;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String email;
  final String password;
  final String confirmPassword;
  final String preferredLanguage;
  final String foundedAt;
  final String website;

  InitiativeOwnerRegisterRequest({
    required this.orgName,
    this.orgLogoPath,
    required this.country,
    required this.city,
    required this.type,
    required this.sector,
    required this.size,
    required this.firstName,
    required this.lastName,
    required this.jobTitle,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.preferredLanguage,
    required this.foundedAt,
    required this.website,
  });
}
