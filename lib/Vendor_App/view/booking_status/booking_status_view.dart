import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/booking_status/controller/booking_status_controller.dart';
import 'package:intl/intl.dart';

import '../../../data/models/vender_side_model/booking_status_model.dart';

class BookingStatusScreen extends StatefulWidget {
  const BookingStatusScreen({super.key});

  @override
  State<BookingStatusScreen> createState() => _BookingStatusScreenState();
}

class _BookingStatusScreenState extends State<BookingStatusScreen> {
  final BookingController controller = Get.put(BookingController());

  @override
  void initState() {
    super.initState();
    controller.selectedFilter.value = 'pending';
  }

  // OTP Dialog for Mark Complete
  void _showOtpDialog(String bookingId) {
    final TextEditingController otpController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Enter 4-Digit OTP'),
        content: TextField(
          controller: otpController,
          keyboardType: TextInputType.number,
          maxLength: 4,
          decoration: const InputDecoration(
            hintText: '0000',
            counterText: '',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final otp = otpController.text.trim();
              if (otp.length == 4) {
                Get.back();
                controller.markCompleteBooking(bookingId, otp);
              } else {
                Get.snackbar('Invalid', 'Please enter 4 digits', backgroundColor: Colors.orange);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  // Confirmation Dialog for Cancel
  void _showCancelConfirmDialog(String bookingId) {
    Get.dialog(
      AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.cancelBooking(bookingId);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: RefreshIndicator(
        onRefresh: controller.refreshBookings,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final filteredBookings = controller.bookings
              .where((b) => b.displayStatus == controller.selectedFilter.value)
              .toList();

          final totalRevenue = controller.bookings.fold<double>(
            0.0,
            (sum, b) => sum + b.displayAmount,
          );

          return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 2 : (isTablet ? 3 : 4),
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          mainAxisExtent: isMobile ? 132 : 118,
                        ),
                        children: [
                          _summaryCard(
                            controller.pendingCount.toString(),
                            'Pending Bookings',
                            Icons.watch_later_outlined,
                            Colors.orange,
                          ),
                          _summaryCard(
                            controller.completedCount.toString(),
                            'Completed',
                            Icons.check_circle,
                            Colors.green,
                          ),
                          _summaryCard(
                            controller.cancelledCount.toString(),
                            'Cancelled',
                            Icons.cancel,
                            Colors.red,
                          ),
                          _summaryCard(
                            '£${totalRevenue.toStringAsFixed(2)}',
                            'Total Revenue',
                            Icons.account_balance_wallet,
                            Colors.indigo,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _filterChip('pending', 'Pending', Icons.watch_later_outlined),
                            const SizedBox(width: 12),
                            _filterChip('completed', 'Completed', Icons.check_circle),
                            const SizedBox(width: 12),
                            _filterChip('cancelled', 'Cancelled', Icons.cancel),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by customer, service, or order...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Text(
                        'Bookings (${filteredBookings.length})',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              filteredBookings.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.inbox_outlined, size: 80, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text(
                              'No ${controller.selectedFilter.value} bookings found',
                              style: TextStyle(fontSize: 17, color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: _bookingCard(filteredBookings[index], isMobile),
                          );
                        },
                        childCount: filteredBookings.length,
                      ),
                    ),

              const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
            ],
          );
        }),
      ),
    );
  }

  Widget _summaryCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.85)]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 26, color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String value, String label, IconData icon) {
    return Obx(() {
      final isSelected = controller.selectedFilter.value == value;
      final count = value == 'pending'
          ? controller.pendingCount
          : value == 'completed'
              ? controller.completedCount
              : controller.cancelledCount;

      return ChoiceChip(
        selected: isSelected,
        onSelected: (_) => controller.selectedFilter.value = value,
        avatar: Icon(icon, size: 18),
        label: Text('$label ($count)'),
        selectedColor: Colors.indigo.shade100,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.indigo : Colors.black87,
        ),
        shape: StadiumBorder(
          side: BorderSide(color: isSelected ? Colors.indigo : Colors.grey.shade300),
        ),
      );
    });
  }

  Widget _bookingCard(Booking booking, bool isMobile) {
    final bool isConfirmed = (booking.bookingStatus ?? '').toLowerCase() == 'confirmed';
    final bool isPendingOperator = (booking.bookingServiceStatus ?? '').toLowerCase() == 'pending';
    final bool isFullyPaid = (booking.paymentStatus ?? '').toLowerCase().contains('paid') ||
        (booking.paymentStatus ?? '').toLowerCase().contains('completed');

    final String statusTag1 = isConfirmed
        ? 'Confirmed'
        : isPendingOperator
            ? 'Pending'
            : booking.displayStatus.toUpperCase();
    final String statusTag2 = isFullyPaid ? 'Paid' : 'Fully Paid';

    final Color tag1Color = isConfirmed || isPendingOperator ? Colors.orange : Colors.green;
    final Color tag2Color = Colors.green;

    final bool showAcceptCancel = isPendingOperator && !(booking.isAcceptedByVendor ?? false);
    final bool showMarkComplete = booking.displayStatus == 'pending' && !showAcceptCancel;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    booking.confirmationCode ?? '#${booking.displayOrderNo}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _statusTag(statusTag1, tag1Color),
                    _statusTag(statusTag2, tag2Color),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              booking.displayServiceName,
              style: TextStyle(color: Colors.grey.shade700),
            ),

            const Divider(height: 24),

            _infoRow(Icons.person_outline, 'Customer',
                '${booking.userId?.firstName ?? ''} ${booking.userId?.lastName ?? ''}'),
            _infoRow(Icons.email_outlined, 'Email', booking.userId?.email ?? 'N/A'),
            _infoRow(Icons.phone_outlined, 'Phone',
                '${booking.userId?.countryCode ?? ''}${booking.userId?.mobileNo ?? ''}'),

            if (booking.eventDetails != null) ...[
              _infoRow(Icons.event, 'Event Type', booking.eventDetails!.eventType ?? 'N/A'),
              _infoRow(Icons.people, 'Guests', '${booking.eventDetails!.guestCount ?? 'N/A'}'),
              _infoRow(Icons.access_time, 'Time',
                  '${booking.eventDetails!.startTime ?? ''} - ${booking.eventDetails!.endTime ?? ''}'),
            ],

            if (booking.displayDate != null)
              _infoRow(Icons.calendar_today, 'Date',
                  DateFormat('dd MMM yyyy').format(booking.displayDate!)),

            if (booking.pickupLocation != null || booking.deliveryAddress != null)
              _infoRow(Icons.location_on, 'Location',
                  booking.pickupLocation ?? booking.deliveryAddress ?? 'N/A'),

            if (booking.displaySpecialRequest != 'N/A')
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.amber.shade300),
                ),
                child: Text(
                  booking.displaySpecialRequest,
                  style: TextStyle(color: Colors.amber.shade900),
                ),
              ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '£${booking.displayAmount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo.shade700,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.end,
              children: [
                if (showAcceptCancel) ...[
                  SizedBox(
                    width: isMobile ? double.infinity : 160,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await controller.acceptBooking(booking.id!);
                      },
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Accept'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : 160,
                    child: ElevatedButton.icon(
                      onPressed: () => _showCancelConfirmDialog(booking.id!),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Cancel'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ] else if (showMarkComplete) ...[
                  SizedBox(
                    width: isMobile ? double.infinity : 170,
                    child: ElevatedButton.icon(
                      onPressed: () => _showOtpDialog(booking.id!),
                      icon: const Icon(Icons.done_all, size: 18),
                      label: const Text('Mark Complete'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: isMobile ? double.infinity : 160,
                    child: OutlinedButton.icon(
                      onPressed: () => _showCancelConfirmDialog(booking.id!),
                      icon: const Icon(Icons.close, size: 18),
                      label: const Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
                SizedBox(
                  width: isMobile ? double.infinity : 160,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // TODO: Download invoice
                    },
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text('Invoice'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.indigo.shade600),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$label: ',
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black87),
                children: [
                  TextSpan(
                    text: value,
                    style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}