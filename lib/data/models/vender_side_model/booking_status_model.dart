// booking_model.dart
class BookingModel {
  final List<Booking> bookings;

  BookingModel({required this.bookings});

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookings: List<Booking>.from(
          json['bookings'].map((x) => Booking.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'bookings': List<dynamic>.from(bookings.map((x) => x.toJson())),
      };
}

class Booking {
  final String id;
  final String serviceName;
  final String status;
  final DateTime date;

  Booking({
    required this.id,
    required this.serviceName,
    required this.status,
    required this.date,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'] ?? '',
      serviceName: json['serviceName'] ?? 'Unknown Service',
      status: json['status'] ?? 'Pending',
      date: DateTime.tryParse(json['date'] ?? DateTime.now().toIso8601String()) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'serviceName': serviceName,
        'status': status,
        'date': date.toIso8601String(),
      };
}