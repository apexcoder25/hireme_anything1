import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/booking_status/controller/booking_status_controller.dart';
import 'package:intl/intl.dart';

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
    controller.selectedFilter.value = 'pending'; // Default filter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Management Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
       controller.refreshBookings();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final filteredBookings = controller.bookings
              .where((booking) =>
                  (booking.bookingServiceStatus ?? '').toLowerCase() ==
                  controller.selectedFilter.value.toLowerCase())
              .toList();
          print('Filtered bookings count: ${filteredBookings.length}'); // Debug log

          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _summaryCard(
                  controller.bookings
                      .where((e) =>
                          (e.bookingServiceStatus ?? '').toLowerCase() == 'pending')
                      .length
                      .toString(),
                  'Pending',
                  Colors.orange,
                ),
                const SizedBox(height: 10),
                _summaryCard(
                  controller.bookings
                      .where((e) =>
                          (e.bookingServiceStatus ?? '').toLowerCase() == 'completed')
                      .length
                      .toString(),
                  'Completed',
                  Colors.green,
                ),
                const SizedBox(height: 10),
                _summaryCard(
                  controller.bookings
                      .where((e) =>
                          (e.bookingServiceStatus ?? '').toLowerCase() == 'cancelled')
                      .length
                      .toString(),
                  'Cancelled',
                  Colors.red,
                ),
                const SizedBox(height: 10),
                _summaryCard(
                  '£${controller.bookings
                      .fold(0.0, (sum, b) => sum + (b.grandTotal ?? 0.0))
                      .toStringAsFixed(2)}',
                  'Total Revenue',
                  Colors.indigo,
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _filterButton('Pending', Colors.orange),
                      _filterButton('Completed', Colors.green),
                      _filterButton('Cancelled', Colors.red),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: "Search bookings...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    DropdownButton<String>(
                      value: 'All Time',
                      items: ['All Time', 'Today', 'This Week']
                          .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                          .toList(),
                      onChanged: (_) {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text('Order No')),
                      DataColumn(label: Text('Customer Name')),
                      DataColumn(label: Text('Email')),
                      DataColumn(label: Text('Mobile')),
                      DataColumn(label: Text('Service Name')),
                      DataColumn(label: Text('Category')),
                      DataColumn(label: Text('Pickup Location')),
                      DataColumn(label: Text('Drop Location')),
                      DataColumn(label: Text('Special Request')),
                      DataColumn(label: Text('Pickup Date')),
                      DataColumn(label: Text('Pickup Time')),
                      DataColumn(label: Text('Distance')),
                      DataColumn(label: Text('Total Amount')),
                      DataColumn(label: Text('Payment Status')),
                      DataColumn(label: Text('Action')),
                      DataColumn(label: Text('Invoice')),
                      DataColumn(label: Text('Date')),
                    ],
                    rows: filteredBookings.isEmpty
                        ? [
                            DataRow(cells: [
                              for (int i = 0; i < 16; i++) DataCell(Text('')), // 16 empty cells
                              DataCell(Text(
                                'No ${controller.selectedFilter.value.toLowerCase()} bookings available.',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, color: Colors.grey),
                              )),
                            ]),
                          ]
                        : filteredBookings.map((booking) {
                            return DataRow(cells: [
                              DataCell(Text('#${booking.orderNo ?? ''}')),
                              DataCell(Text(
                                  '${booking.userId?.firstName ?? ''} ${booking.userId?.lastName ?? ''}')),
                              DataCell(Text(booking.userId?.email ?? '')),
                              DataCell(Text(booking.userId?.mobileNo ?? '')),
                              DataCell(Text(booking.serviceId?.serviceName ?? '')),
                              DataCell(Text(booking.serviceId?.categoryId?.categoryName ?? '')),
                              DataCell(Text(booking.pickupLocation ?? '')),
                              DataCell(Text(booking.dropLocation ?? '')),
                              DataCell(Text(booking.bookingSpecialRequests?.isNotEmpty == true
                                  ? booking.bookingSpecialRequests!
                                  : 'N/A')),
                              DataCell(Text(booking.dateOfTravel != null
                                  ? DateFormat('MM/dd/yyyy').format(booking.dateOfTravel!)
                                  : '')),
                              DataCell(Text(booking.pickupTime ?? '')),
                              DataCell(Text('${booking.distance ?? 0} km')),
                              DataCell(Text('£${booking.grandTotal?.toStringAsFixed(2) ?? '0.00'}')),
                              DataCell(Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(booking.paymentStatus ?? ''),
                              )),
                              DataCell(ElevatedButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Mark Complete',
                                    style: TextStyle(fontSize: 12),
                                  ))),
                              DataCell(OutlinedButton(
                                  onPressed: () {},
                                  child: const Text('Download', style: TextStyle(fontSize: 12)))),
                              DataCell(Text(booking.createdAt != null
                                  ? DateFormat('d MMM yyyy').format(booking.createdAt!)
                                  : '')),
                            ]);
                          }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(onPressed: () {}, child: const Text('Previous')),
                    const SizedBox(width: 10),
                    const Text('Page 1 of 1'),
                    const SizedBox(width: 10),
                    OutlinedButton(onPressed: () {}, child: const Text('Next')),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _summaryCard(String count, String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(count,
              style: const TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _filterButton(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Obx(() {
        final isSelected = controller.selectedFilter.value == label.toLowerCase();
        final count = controller.bookings
            .where((b) =>
                (b.bookingServiceStatus ?? '').toLowerCase() == label.toLowerCase())
            .length;
        return ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? color : Colors.grey.shade300,
            foregroundColor: isSelected ? Colors.white : Colors.black,
          ),
          onPressed: () {
            controller.selectedFilter.value = label.toLowerCase();
          },
          icon: Icon(_getIcon(label)),
          label: Text('$label ($count)'),
        );
      }),
    );
  }

  IconData _getIcon(String label) {
    switch (label.toLowerCase()) {
      case 'pending':
        return Icons.watch_later;
      case 'completed':
        return Icons.check_circle;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
}