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

  // Convert ContactMessage to JSON for sending to API
  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'phone': phone,
      'subject': subject,
      'message': message,
    };
  }

  // Optional: Factory constructor if you plan on handling received data with id, createdAt, and updatedAt
  factory ContactMessage.fromJson(Map<String, dynamic> json) {
    return ContactMessage(
      fullName: json['full_name'],
      phone: json['phone'],
      subject: json['subject'],
      message: json['message'],
    );
  }
}
