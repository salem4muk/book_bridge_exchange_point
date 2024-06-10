import 'package:intl/intl.dart';

class WaitedDonations {
  int id;
  String level;
  String semester;
  String donorName;
  String createdAt;
  String donor;

  WaitedDonations({
    required this.id,
    required this.level,
    required this.semester,
    required this.donorName,
    required this.createdAt,
    required this.donor,
  });

  factory WaitedDonations.fromJson(Map<String, dynamic> json) {
    String createdAt = json['created_at'] ?? '';
    // String startLeadTimeDateForDonor = json['startLeadTimeDateForDonor'] ?? '';

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

    // if (startLeadTimeDateForDonor.isNotEmpty) {
    //   try {
    //     DateTime dateTime = DateTime.parse(startLeadTimeDateForDonor);
    //     formattedStartLeadTimeDateForDonor = DateFormat('yyyy-MM-dd').format(dateTime);
    //   } catch (e) {
    //     // Handle parsing error, if any
    //     print('Error parsing startLeadTimeDateForDonor date: $e');
    //   }
    // }

    return WaitedDonations(
      id: json['id'] ?? 0, // Assuming 0 is a safe default for id
      level: json['level'] ?? '',
      semester: json['semester'] ?? '',
      donorName: json['donorName'] ?? '',
      createdAt: formattedCreatedAt,
      donor: json['donor'] ?? '',
    );
  }
}
