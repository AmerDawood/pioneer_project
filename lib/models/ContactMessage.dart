class ContactMessage {
  final String fullName;
  final String phone;
  final String subject;
  final String message;

  ContactMessage({
    required this.fullName,
    required this.phone,
    required this.subject,
    required this.message,
  });

  Map<String, String> toJson() {
    return {
      'full_name': fullName,
      'phone': phone,
      'subject': subject,
      'message': message,
    };
  }
}
