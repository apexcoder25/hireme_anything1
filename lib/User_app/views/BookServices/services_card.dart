import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/unifiedOfferingsModel.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/book_service.dart';
import 'package:hire_any_thing/User_app/views/services_details/services_details.dart';
import 'package:intl/intl.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class ServiceCard extends StatefulWidget {
  final Datum service;

  const ServiceCard({required this.service, super.key});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  
  String _getFuneralVehicleTypes(FuneralVehicleTypes? types) {
    if (types == null) return 'N/A';
    List<String> available = [];
    if (types.traditionalHearse == true) available.add('Traditional Hearse');
    if (types.horseDrawnHearse == true) available.add('Horse Drawn Hearse');
    if (types.limousine == true) available.add('Limousine');
    if (types.alternativeVehicle == true) available.add('Alternative Vehicle');
    if (available.isEmpty) return 'N/A';
    return available.join(', ');
  }

  String _getPriceString() {
    double? price;
    String unit = 'day';

    if (widget.service.offeringPrice != null) {
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

    if (price == null) return 'Price on Request';
    return '/';
  }

  String _getLocationString() {
    if (widget.service.city != null && widget.service.city!.isNotEmpty) {
      return widget.service.city!;
    }
    if (widget.service.baseLocationPostcode != null && widget.service.baseLocationPostcode!.isNotEmpty) {
      return widget.service.baseLocationPostcode!;
    }
    if (widget.service.basePostcode != null && widget.service.basePostcode!.isNotEmpty) {
      return widget.service.basePostcode!;
    }
    return 'Location N/A';
  }

  String _getAvailabilityString() {
    final DateFormat dateFormat = DateFormat('d MMM yyyy');
    DateTime? from;
    DateTime? to;

    if (widget.service.bookingAvailabilityDateFrom != null) {
      from = widget.service.bookingAvailabilityDateFrom;
      to = widget.service.bookingAvailabilityDateTo;
    } else {
      from = widget.service.bookingDateFrom;
      to = widget.service.bookingDateTo;
    }

    if (from == null) return 'Check Availability';
    String fromStr = dateFormat.format(from.toLocal());
    String toStr = to != null ? dateFormat.format(to.toLocal()) : '';
    
    return '';
  }

  void _navigateToDetails() {
    if (widget.service.categoryId != null && widget.service.subcategoryId != null) {
      if (widget.service.sourceModel == 'funeral') {
        Get.to(() => ServicesDetails(
              categoryId: widget.service.categoryId!.id ?? '',
              subcategoryId: widget.service.subcategoryId!.id,
              categoryName: widget.service.categoryId!.categoryName ?? '',
              subcategoryName: widget.service.subcategoryId!.subcategoryName,
              serviceName: widget.service.listingTitle ?? 'Unknown Service',
              cityNames: widget.service.areasCovered?.join(', ') ?? '',
              kmPrice: (widget.service.pricingDetails?.hourlyRate ?? 0).toDouble().toStringAsFixed(2),
              minDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? '0',
              maxDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? '0',
              description: widget.service.businessProfile?.promotionalDescription ?? '',
              airon_fitted: widget.service.features?.comfort?.airConditioning == true ? 'yes' : 'no',
              wheelChair: widget.service.features?.accessibility?.wheelchairAccessVehicle == true ? 'yes' : 'no',
              bookingDateFrom: widget.service.bookingAvailabilityDateFrom?.toIso8601String() ?? '',
              bookingDateTo: widget.service.bookingAvailabilityDateTo?.toIso8601String() ?? '',
              makeAndModel: widget.service.fleetDetails?.makeModel ?? '',
              registration: '',
              noOfSeats: widget.service.fleetDetails?.seats,
              serviceImage: (widget.service.serviceImage?.isNotEmpty ?? false) ? widget.service.serviceImage![0] : '',
              service: widget.service,
              vehicleTypes: _getFuneralVehicleTypes(widget.service.funeralVehicleTypes),
              packageOptions: 'Standard: , VIP: ',
            ));
      } else if (widget.service.sourceModel == 'horse') {
        Get.to(() => ServicesDetails(
              categoryId: widget.service.categoryId!.id ?? '',
              subcategoryId: widget.service.subcategoryId!.id,
              categoryName: widget.service.categoryId!.categoryName ?? '',
              subcategoryName: widget.service.subcategoryId!.subcategoryName,
              serviceName: widget.service.listingTitle ?? 'Unknown Service',
              cityNames: widget.service.serviceCoverage?.join(', ') ?? '',
              kmPrice: (widget.service.pricing?.hourlyRate ?? 0).toDouble().toStringAsFixed(2),
              minDistance: 'N/A',
              maxDistance: 'N/A',
              description: widget.service.marketing?.description ?? '',
              airon_fitted: 'no',
              wheelChair: 'no',
              bookingDateFrom: widget.service.bookingAvailabilityDateFrom?.toIso8601String() ?? '',
              bookingDateTo: widget.service.bookingAvailabilityDateTo?.toIso8601String() ?? '',
              makeAndModel: '',
              registration: '',
              noOfSeats: null,
              serviceImage: (widget.service.serviceImages?.isNotEmpty ?? false) ? widget.service.serviceImages![0] : '',
              service: widget.service,
              carriageTypes: widget.service.carriageDetails?.carriageType ?? '',
              horseTypes: widget.service.carriageDetails?.horseBreeds.join(', ') ?? '',
            ));
      } else if (widget.service.sourceModel == 'chauffeur') {
        Get.to(() => ServicesDetails(
              categoryId: widget.service.categoryId!.id ?? '',
              subcategoryId: widget.service.subcategoryId!.id,
              categoryName: widget.service.categoryId!.categoryName ?? '',
              subcategoryName: widget.service.subcategoryId!.subcategoryName,
              serviceName: widget.service.listingTitle ?? 'Unknown Service',
              cityNames: widget.service.areasCovered?.join(', ') ?? '',
              kmPrice: (widget.service.pricingDetails?.hourlyRate ?? 0).toDouble().toStringAsFixed(2),
              minDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? '0',
              maxDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? '0',
              description: widget.service.businessProfile?.promotionalDescription ?? '',
              airon_fitted: widget.service.features?.comfort?.airConditioning == true ? 'yes' : 'no',
              wheelChair: widget.service.features?.accessibility?.wheelchairAccessVehicle == true ? 'yes' : 'no',
              bookingDateFrom: widget.service.bookingDateFrom?.toIso8601String() ?? '',
              bookingDateTo: widget.service.bookingDateTo?.toIso8601String() ?? '',
              makeAndModel: widget.service.fleetInfo?.makeAndModel ?? '',
              registration: '',
              noOfSeats: widget.service.fleetInfo?.seats,
              serviceImage: (widget.service.serviceImage?.isNotEmpty ?? false) ? widget.service.serviceImage![0] : '',
              service: widget.service,
              vehicleType: widget.service.fleetType ?? '',
            ));
      } else {
         Get.to(() => ServicesDetails(
              categoryId: widget.service.categoryId?.id ?? '',
              subcategoryId: widget.service.subcategoryId?.id ?? '',
              categoryName: widget.service.categoryId?.categoryName ?? '',
              subcategoryName: widget.service.subcategoryId?.subcategoryName ?? '',
              serviceName: widget.service.listingTitle ?? widget.service.serviceName ?? 'Service',
              cityNames: widget.service.city ?? '',
              kmPrice: '0.00',
              description: widget.service.description ?? '',
              bookingDateFrom: widget.service.bookingDateFrom?.toIso8601String() ?? '',
              bookingDateTo: widget.service.bookingDateTo?.toIso8601String() ?? '',
              serviceImage: (widget.service.serviceImage?.isNotEmpty ?? false) ? widget.service.serviceImage![0] : '',
              service: widget.service,
            ));
      }
    } else {
      Get.snackbar('Error', 'Category or Subcategory is missing');
    }
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = (widget.service.serviceImage?.isNotEmpty ?? false)
        ? widget.service.serviceImage![0]
        : (widget.service.primaryImage?.isNotEmpty ?? false)
            ? widget.service.primaryImage!
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
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  ),
                ),
                // Verified Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.verified_user_outlined, color: Colors.white, size: 16),
                        SizedBox(width: 4),
                        Text(
                          'Verified',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Favorite Icon
                Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18,
                    child: Icon(Icons.favorite_border, color: Colors.grey, size: 20),
                  ),
                ),
                // Price Overlay
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Text(
                    _getPriceString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 1),
                          blurRadius: 3.0,
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (widget.service.categoryId?.categoryName != null)
                        _buildTag(widget.service.categoryId!.categoryName!),
                      if (widget.service.subcategoryId?.subcategoryName != null)
                        _buildTag(widget.service.subcategoryId!.subcategoryName!),
                    ],
                  ),
                  SizedBox(height: 12),
                  
                  // Title
                  Text(
                    widget.service.serviceName ?? widget.service.listingTitle ?? 'Service Name',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 16),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: Colors.grey[600], size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '  +682 more', // Hardcoded suffix as per image request
                          style: TextStyle(color: Colors.grey[600], fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Availability
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, color: Colors.grey[600], size: 18),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Available',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 14
                            ),
                          ),
                          Text(
                            _getAvailabilityString(),
                            style: TextStyle(color: Colors.grey[600], fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 12),

                  // Status
                  Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: Colors.green, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Available Now',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _navigateToDetails,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1976D2), // Blue color from image
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Booking and Details',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFE3F2FD), // Light blue
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF1976D2), // Blue text
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
