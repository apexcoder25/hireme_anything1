import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/views/Book_Service/controllers/your_service_booking.dart';

class OrderSummary extends StatefulWidget {
  final YourServicesViewModel viewModel;

  const OrderSummary({super.key, required this.viewModel});

  @override
  State<OrderSummary> createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  // Function to show a dialog with all cities
  void _showAllCitiesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'All Service Areas',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.viewModel.service.value!.cityName
                  .map<Widget>((String city) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    city,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Order Summary Title
        Text(
          'Order Summary'.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),

        // Service Availability Section
        const Text(
          'Service Availability',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),

        // Distance Range
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Distance Range:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              '${widget.viewModel.service.value!.minimumDistance} - ${widget.viewModel.service.value!.maximumDistance} miles',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Available From
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Available From:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              widget.viewModel.service.value!.bookingDateFrom,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Available Until
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Available Until:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              widget.viewModel.service.value!.bookingDateTo,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Maximum Capacity
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Maximum Capacity:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              '${widget.viewModel.service.value!.noOfSeats} seats',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Service Areas
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Service Areas:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  ...widget.viewModel.service.value!.cityName.take(3).map(
                        (city) => Chip(
                          label: Text(
                            city,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black87),
                          ),
                          backgroundColor: Colors.blue[100],
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                  if (widget.viewModel.service.value!.cityName.length > 3)
                    GestureDetector(
                      onTap: () {
                        _showAllCitiesDialog(context); // Show dialog on tap
                      },
                      child: Chip(
                        label: Text(
                          '+${widget.viewModel.service.value!.cityName.length - 3} more',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.green),
                        ),
                        backgroundColor: Colors.green[100],
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Cost Breakdown
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Price per mile × Distance:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              '£${(widget.viewModel.service.value!.kilometerPrice).toStringAsFixed(0)} × ${widget.viewModel.distance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Base Price:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              '£${((widget.viewModel.service.value!.kilometerPrice) * widget.viewModel.distance).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Subtotal with Cars:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              '£${((widget.viewModel.service.value!.kilometerPrice) * widget.viewModel.distance).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Platform Fee:',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const Text(
              '£0.00',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'VAT (20%):',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              '£${(((widget.viewModel.service.value!.kilometerPrice) * widget.viewModel.distance) * 0.2).toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Obx(() {
          if (widget.viewModel.discountAmount.value > 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Coupon Discount:',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  '-£${widget.viewModel.discountAmount.value.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        }),
        if (widget.viewModel.discountAmount.value > 0)
          const SizedBox(height: 8),

        const Divider(),
        const SizedBox(height: 8),

        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Amount:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '£${widget.viewModel.totalAmount.value.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
