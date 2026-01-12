// lib/User_app/views/BookServices/service_card.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:hire_any_thing/data/models/user_side_model/unifiedOfferingsModel.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:intl/intl.dart';

class ServiceCard extends StatefulWidget {
  final Datum service;

  const ServiceCard({required this.service, super.key});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  String _getPriceString() {
    double? price;
    String unit = 'day';

    if (widget.service.offeringPrice != null && widget.service.offeringPrice! > 0) {
      price = widget.service.offeringPrice!.toDouble();
    } else if (widget.service.pricingDetails?.hourlyRate != null) {
      price = widget.service.pricingDetails!.hourlyRate.toDouble();
      unit = 'hour';
    } else if (widget.service.pricing?.hourlyRate != null) {
      price = widget.service.pricing!.hourlyRate!.toDouble();
      unit = 'hour';
    } else if (widget.service.pricingDetails?.dayRate != null) {
      price = widget.service.pricingDetails!.dayRate!.toDouble();
      unit = 'day';
    }

    if (price == null || price <= 0) return 'Price on Request';
    return '£${price.toStringAsFixed(0)}/$unit';
  }

  String _getLocationString() {
    if (widget.service.city?.isNotEmpty == true) return widget.service.city!;
    if (widget.service.baseLocationPostcode?.isNotEmpty == true) return widget.service.baseLocationPostcode!;
    if (widget.service.basePostcode?.isNotEmpty == true) return widget.service.basePostcode!;
    return 'Location not specified';
  }

  String _getAvailabilityString() {
    final DateFormat dateFormat = DateFormat('d MMM yyyy');
    DateTime? from = widget.service.bookingAvailabilityDateFrom ?? widget.service.bookingDateFrom;
    DateTime? to = widget.service.bookingAvailabilityDateTo ?? widget.service.bookingDateTo;

    if (from == null) return 'Check Availability';

    String fromStr = dateFormat.format(from.toLocal());
    if (to != null) {
      String toStr = dateFormat.format(to.toLocal());
      return 'Available: $fromStr - $toStr';
    }
    return 'From $fromStr';
  }

  void _navigateToDetails() {
    final String serviceId = widget.service.id ?? '';

    if (serviceId.isEmpty) {
      Get.snackbar('Error', 'Service ID is missing');
      return;
    }

    // Correctly detect service type from sourceModel or category/subcategory
    final String sourceModel = (widget.service.sourceModel ?? '').toLowerCase();
    final String category = (widget.service.categoryId?.categoryName ?? '').toLowerCase();
    final String subcategory = (widget.service.subcategoryId?.subcategoryName ?? '').toLowerCase();

    String serviceType = 'coach'; // default

    if (sourceModel.contains('horse') || subcategory.contains('horse') || category.contains('horse')) {
      serviceType = 'horse';
    } else if (sourceModel.contains('boat') || subcategory.contains('boat') || category.contains('boat')) {
      serviceType = 'boat';
    } else if (sourceModel.contains('limousine') || 
               sourceModel.contains('chauffeur') || 
               subcategory.contains('limousine') || 
               subcategory.contains('chauffeur')) {
      serviceType = 'limousine';
    } else if (sourceModel.contains('minibus') || subcategory.contains('minibus')) {
      serviceType = 'minibus';
    }
    // coach is default

    print("Navigating to details | ID: $serviceId | Type: $serviceType | Source: $sourceModel");

    Get.toNamed(
      UserRoutesName.serviceDetails,
      arguments: {
        'serviceId': serviceId,
        'serviceType':sourceModel,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = (widget.service.serviceImage?.isNotEmpty == true)
        ? widget.service.serviceImage![0]
        : (widget.service.primaryImage?.isNotEmpty == true)
            ? widget.service.primaryImage!
            : (widget.service.serviceImages?.isNotEmpty == true)
                ? widget.service.serviceImages![0]
                : 'https://hireanything.com/image/about.png';

    return Padding(
      padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, color: Colors.grey, size: 50),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0x80000000),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.verified_user_outlined, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Verified',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(Icons.favorite_border, color: Colors.grey[700], size: 20),
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _getPriceString(),
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (widget.service.categoryId?.categoryName?.trim().isNotEmpty == true)
                        _buildTag(widget.service.categoryId!.categoryName!.trim()),
                      if (widget.service.subcategoryId?.subcategoryName?.trim().isNotEmpty == true)
                        _buildTag(widget.service.subcategoryId!.subcategoryName!.trim()),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Text(
                    widget.service.serviceName?.trim().isNotEmpty == true
                        ? widget.service.serviceName!
                        : widget.service.listingTitle?.trim().isNotEmpty == true
                            ? widget.service.listingTitle!
                            : 'Service Name',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _getLocationString(),
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, color: Colors.grey[600], size: 18),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _getAvailabilityString(),
                          style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 14),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Available Now',
                        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToDetails,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976D2),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 2,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Booking and Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF1976D2), fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }
}