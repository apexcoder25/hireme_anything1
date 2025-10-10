import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/cancellation_policy.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/coupon_section.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/extra_charges.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/location_header.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/order_summary.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/payment_buttons.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/service_details.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/service_image.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/components/vehicle_features.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/controllers/your_service_booking.dart';

class YourServicesBooking extends StatefulWidget {
  final String id;
  final double distance;
  final String fromLocation; // Defined here
  final String toLocation;   // Defined here
  final String pickupTime;
   final String pickupDate;


  const YourServicesBooking({
    super.key,
    required this.id,
    required this.distance,
    required this.fromLocation,
    required this.toLocation,
     required this.pickupTime, required this.pickupDate,
  });

  @override
  State<YourServicesBooking> createState() => _YourServicesBookingState();
}

class _YourServicesBookingState extends State<YourServicesBooking> {
  @override
  Widget build(BuildContext context) {
    // Pass fromLocation and toLocation to YourServicesViewModel
    final viewModel = YourServicesViewModel(
      widget.id,
      widget.distance,
      widget.fromLocation,
      widget.toLocation,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'YOUR SERVICE',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: TextButton(
              onPressed: () {
                navigator?.pop(context);
              },
              child: const Text(
                'Back to Offerings',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.service.value == null) {
          return const Center(child: Text('No service data available'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocationHeader(
                fromLocation: widget.fromLocation,
                toLocation: widget.toLocation,
                distance: widget.distance,
              ),
              const SizedBox(height: 16),
              ServiceImage(service: viewModel.service.value!),
              ServiceDetails(service: viewModel.service.value!),
              const SizedBox(height: 16),
              VehicleFeatures(service: viewModel.service.value!),
              CancellationPolicy(service: viewModel.service.value!),
              const SizedBox(height: 16),
              ExtraCharges(service: viewModel.service.value!, distance: widget.distance),
              const SizedBox(height: 16),
              OrderSummary(viewModel: viewModel),
              CouponSection(viewModel: viewModel),
              const SizedBox(height: 16),
              PaymentButtons(viewModel: viewModel,pickupDate: widget.pickupDate,pickupTime: widget.pickupTime,),
            ],
          ),
        );
      }),
    );
  }
}