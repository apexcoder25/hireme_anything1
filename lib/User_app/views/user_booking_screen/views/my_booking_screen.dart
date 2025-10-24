import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/user_booking_model.dart';
import 'package:hire_any_thing/User_app/views/user_booking_screen/controller/user_booking_details_controller.dart';
import 'package:hire_any_thing/User_app/views/user_booking_screen/views/recipt_generator.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:intl/intl.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({super.key});

  @override
  State<MyBookingsScreen> createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final UserBookingController bookingController = Get.put(UserBookingController());
  final RxBool isPast = true.obs;

  @override
  void initState() {
    super.initState();
    bookingController.fetchUserBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Text(
              'View and manage your bookings',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
          Obx(() => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => isPast.value = false,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPast.value ? Colors.white : AppColors.btnColor,
                      foregroundColor: isPast.value ? AppColors.btnColor : Colors.white,
                      side: BorderSide(color: AppColors.btnColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Upcoming Bookings"),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => isPast.value = true,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPast.value ? AppColors.btnColor : Colors.white,
                      foregroundColor: isPast.value ? Colors.white : AppColors.btnColor,
                      side: BorderSide(color: AppColors.btnColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text("Past Bookings"),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() {
              if (bookingController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final now = DateTime.now();
              final bookings = bookingController.bookings.where((booking) {
                DateTime? pickupDateTime;
                if (booking.dateOfTravel != null &&
                    booking.bookingDetailPickupTime != null) {
                  try {
                    final timeParts =
                        booking.bookingDetailPickupTime!.split(':');
                    if (timeParts.length == 2) {
                      final hours = int.parse(
                          timeParts[0].replaceAll(RegExp(r'[^0-9]'), ''));
                      final minutes = int.parse(
                          timeParts[1].replaceAll(RegExp(r'[^0-9]'), ''));
                      pickupDateTime = DateTime(
                        booking.dateOfTravel!.year,
                        booking.dateOfTravel!.month,
                        booking.dateOfTravel!.day,
                        hours,
                        minutes,
                      );
                    }
                  } catch (e) {
                    print("Error parsing bookingDetailPickupTime: $e");
                    pickupDateTime = booking.dateOfTravel;
                  }
                } else if (booking.dateOfTravel != null) {
                  pickupDateTime = booking.dateOfTravel;
                }

                if (pickupDateTime == null) return false;

                return isPast.value
                    ? pickupDateTime.isBefore(now)
                    : pickupDateTime.isAfter(now) ||
                        pickupDateTime.isAtSameMomentAs(now);
              }).toList();

              if (bookings.isEmpty) {
                return Center(
                    child: Text(isPast.value
                        ? 'No past bookings found'
                        : 'No upcoming bookings found'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: bookings.length,
                itemBuilder: (context, index) => BookingCard(
                  booking: bookings[index],
                  isPast: isPast.value,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class BookingCard extends StatelessWidget {
  final BookingDetails booking;
  final bool isPast;
  const BookingCard({super.key, required this.booking, required this.isPast});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd, HH:mm');
    final pickupDateTime = booking.dateOfTravel != null
        ? dateFormat.format(booking.dateOfTravel!)
        : 'N/A';
    final pickupTime = booking.bookingDetailPickupTime ?? 'N/A';
    final formattedDateTime = '$pickupDateTime, $pickupTime';

    final bookingId = booking.id != null && booking.id!.length >= 8
        ? booking.id!.substring(booking.id!.length - 8).toUpperCase()
        : 'N/A';

    final imageUrl = booking.serviceId?.serviceImage != null &&
            booking.serviceId!.serviceImage.isNotEmpty
        ? booking.serviceId!.serviceImage[0]
        : 'https://via.placeholder.com/50';

    return Card(
      color: AppColors.blueLighten5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row: Image + Title + Booking Info
            Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColors.blueLighten4,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.serviceId?.serviceName ?? 'Booking Service',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.3),
                      ),
                      Text(
                        'ID: $bookingId • Order #${booking.orderNo ?? 'N/A'}',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Text(
                  booking.dateOfTravel != null
                      ? DateFormat('EEE, dd MMM yyyy')
                          .format(booking.dateOfTravel!)
                      : 'Booking Date',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 24),

            /// Locations
            _infoRow("Pick up Location", booking.pickupLocation ?? 'N/A'),
            const SizedBox(height: 4),
            _infoRow("Drop Location", booking.dropLocation ?? 'N/A'),
            const SizedBox(height: 4),
            _infoRow(
                "Distance",
                booking.distance != null
                    ? "${booking.distance!.toStringAsFixed(1)} km"
                    : "0.0 km"),
            const Divider(height: 24),

            /// Date + Amount + OTP
            _infoRow("Pick up Date & Time", formattedDateTime),
            const SizedBox(height: 4),
            _infoRow("Total Amount",
                '£${booking.grandTotal != null ? booking.grandTotal!.toStringAsFixed(2) : '0.00'}'),
            const SizedBox(height: 4),
            _infoRow("OTP", booking.otp?.toString() ?? 'N/A'),
            const SizedBox(height: 15),

            /// Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await PdfGenerator.generateAndSaveReceipt(booking);
                  },
                  icon: const Icon(Icons.download),
                  label: const Text('Download Receipt'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.btnColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                  ),
                ),
                if (!isPast && booking.id != null) ...[
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      _showCancelConfirmationDialog(context, booking.id!);
                    },
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancel Booking'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.error,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 6,
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _showCancelConfirmationDialog(BuildContext context, String bookingId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              Get.back();
              final controller = Get.find<UserBookingController>();
              await controller.cancelBooking(bookingId);
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
