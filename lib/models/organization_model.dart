class Organization {
   String? logoPath;
   String? title;

  Organization({required this.logoPath, required this.title});

    Organization.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    logoPath = json['logo_path'];
  
  }
}