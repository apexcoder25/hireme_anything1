import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/book_service.dart';
import 'package:intl/intl.dart';

class ServicesDetails extends StatefulWidget {
  final dynamic service;
  final String categoryId;
  final String subcategoryId;
  final String categoryName;
  final String subcategoryName;
  final String? serviceName;
  final String cityNames;
  final String kmPrice;
  final String? minDistance;
  final String? maxDistance;
  final String description;
  final String? airon_fitted;
  final String? wheelChair;
  final String bookingDateFrom;
  final String bookingDateTo;
  final String? makeAndModel;
  final String? registration;
  final int? noOfSeats;
  final String serviceImage;
  final String? vehicleTypes; // For Funeral
  final String? packageOptions; // For Funeral
  final String? carriageTypes; // For Horse
  final String? horseTypes; // For Horse
  final String? vehicleType; // For Chauffeur

  const ServicesDetails({
    super.key,
    required this.categoryId,
    required this.subcategoryId,
    required this.categoryName,
    required this.subcategoryName,
    this.serviceName,
    required this.cityNames,
    required this.kmPrice,
    this.minDistance,
    this.maxDistance,
    required this.description,
    this.airon_fitted,
    this.wheelChair,
    required this.bookingDateFrom,
    required this.bookingDateTo,
    this.makeAndModel,
    this.registration,
    this.noOfSeats,
    required this.serviceImage,
    this.service,
    this.vehicleTypes,
    this.packageOptions,
    this.carriageTypes,
    this.horseTypes,
    this.vehicleType,
  });

  @override
  State<ServicesDetails> createState() => _ServicesDetailsState();
}

class _ServicesDetailsState extends State<ServicesDetails> {
  bool _showMoreDetails = false;

  String formatDateTime(String isoString) {
    DateTime dateTime = DateTime.parse(isoString).toLocal();
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateTime);
  }

  List<String> getCityList(String cityNames) {
    return cityNames
        .split(',')
        .map((city) => city.trim().replaceAll('[', '').replaceAll(']', ''))
        .where((city) => city.isNotEmpty)
        .toList();
  }

  void _showCityDialog() {
    final cities = getCityList(widget.cityNames);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.lightBlue[50],
        title: const Text('All Service Areas', style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.9,
              ),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                alignment: WrapAlignment.center,
                children: cities.map((city) => _buildCityTile(city, context)).toList(),
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildCityTile(String city, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Text(
        city,
        style: TextStyle(fontSize: 14, color: Colors.grey[600], overflow: TextOverflow.ellipsis),
        maxLines: 4,
        softWrap: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.lightBlue[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: [
                        _buildTag(widget.categoryName),
                        const SizedBox(width: 8.0),
                        _buildTag(widget.subcategoryName),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16.0),
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.serviceName ?? 'Unknown Service',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '£${widget.kmPrice}/mile',
                          style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Icon(Icons.location_on, color: Colors.green),
                    const SizedBox(height: 4.0),
                    GestureDetector(
                      onTap: _showCityDialog,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${getCityList(widget.cityNames).length} cities',
                            style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline),
                          ),
                          const SizedBox(width: 4.0),
                          Icon(Icons.arrow_drop_down, color: Colors.blue, size: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(widget.serviceImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Available Amenities',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (widget.airon_fitted?.toLowerCase() == 'yes')
                          _buildChip('Air Conditioning', Icons.ac_unit, Colors.blue),
                        if (widget.wheelChair?.toLowerCase() == 'yes')
                          _buildChip('Wheelchair Access', Icons.accessible, Colors.green),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'Service Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('Booking Date From', formatDateTime(widget.bookingDateFrom)),
                        _buildDetailRow('Booking Date To', formatDateTime(widget.bookingDateTo)),
                        _buildDetailRow('Make and Model', widget.makeAndModel ?? 'Not Provided'),
                        _buildDetailRow('Registration', widget.registration ?? 'Not Provided'),
                        _buildDetailRow('Seats', widget.noOfSeats?.toString() ?? 'Not Specified'),
                        _buildDetailRow('Distance Range', '${widget.minDistance} - ${widget.maxDistance} miles'),
                      ],
                    ),
                    if (_showMoreDetails) ...[
                      const SizedBox(height: 16.0),
                      if (widget.vehicleTypes != null)
                        _buildDetailRow('Vehicle Types', widget.vehicleTypes!),
                      if (widget.packageOptions != null)
                        _buildDetailRow('Package Options', widget.packageOptions!),
                      if (widget.carriageTypes != null)
                        _buildDetailRow('Carriage Types', widget.carriageTypes!),
                      if (widget.horseTypes != null)
                        _buildDetailRow('Horse Types', widget.horseTypes!),
                      if (widget.vehicleType != null)
                        _buildDetailRow('Vehicle Type', widget.vehicleType!),
                    ],
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showMoreDetails = !_showMoreDetails;
                        });
                      },
                      child: Center(
                        child: Text(
                          _showMoreDetails ? 'Show less details' : 'Show more details',
                          style: TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(() => BookServices(
                                id: widget.service is VendorServiceModel
                                    ? widget.service.id ?? ""
                                    : widget.service is TutorHireService
                                        ? widget.service.id ?? ""
                                        : widget.service is AutomotiveHireService
                                            ? widget.service.id ?? ""
                                            : "",
                                categoryId: widget.categoryId,
                                subcategoryId: widget.subcategoryId,
                                fromDate: widget.bookingDateFrom,
                                todate: widget.bookingDateTo,
                                capacity: widget.noOfSeats?.toString() ?? "",
                                minDistance: widget.minDistance ?? "",
                                maxDistsnce: widget.maxDistance ?? "",
                                ServiceCities: widget.cityNames,
                                vehicleTypes: widget.vehicleTypes,
                                packageOptions: widget.packageOptions,
                                carriageTypes: widget.carriageTypes,
                                horseTypes: widget.horseTypes,
                                vehicleType: widget.vehicleType,
                                makeModel: widget.makeAndModel,
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Book Now >',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12, overflow: TextOverflow.ellipsis),
      ),
    );
  }

  Widget _buildChip(String label, IconData icon, Color color) {
    return Chip(
      label: Text(label),
      avatar: Icon(icon, color: color),
      backgroundColor: Colors.grey[200],
    );
  }
}