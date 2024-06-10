import 'package:intl/intl.dart';

class WaitedReservations {
  int id;
  int bookDonationsId;
  String userName;
  String level;
  String semester;
  String createdAt;

  WaitedReservations({
    required this.id,
    required this.bookDonationsId,
    required this.userName,
    required this.level,
    required this.semester,
    required this.createdAt,
  });

  factory WaitedReservations.fromJson(Map<String, dynamic> json) {
    String createdAt = json['created_at'] ?? '';

    // Format the date to display only the date portion
    String formattedCreatedAt = '';

    if (createdAt.isNotEmpty) {
      try {
        DateTime dateTime = DateTime.parse(createdAt);
        formattedCreatedAt = DateFormat('yyyy-MM-dd').format(dateTime);
      } catch (e) {
        // Handle parsing error, if any
        print('Error parsing created_at date: $e');
      }
    }


    return WaitedReservations(
      id: json['id'] ?? 0, // Assuming 0 is a safe default for id
      bookDonationsId: json['book_donations_id'], // Assuming 0 is a safe default for beneficiary_id
      userName: json['userName'] ?? '', // Providing default empty string
      level: json['level'] ?? '',
      semester: json['semester'] ?? '',
      createdAt: formattedCreatedAt,
    );
  }
}
