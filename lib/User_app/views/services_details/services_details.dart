// lib/User_app/views/services_details/services_details.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/book_service.dart';
import 'package:hire_any_thing/User_app/views/services_details/controller/ServiceDetailsController.dart';
import 'package:hire_any_thing/data/models/user_side_model/CouponSharedModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/LimousineServiceDetailModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/ServiceRatingsModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/horse_partners_details_model.dart';
import 'package:intl/intl.dart';

class ServicesDetails extends StatelessWidget {
  const ServicesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ServiceDetailsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F9FF),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Colors.teal));
        }

        final dynamic service = controller.serviceDetail;
        if (service == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.sentiment_dissatisfied, size: 80, color: Colors.grey[400]),
                const SizedBox(height: 20),
                Text(
                  "Service not found",
                  style: TextStyle(fontSize: 20, color: Colors.grey[700], fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        }

        final bool isLimousine = service is LimousineServiceDetail;
        final bool isHorse = service is HorsePartnersDetails;

        final List<String> images = service.serviceImage ?? [];
        final List<String> areas = service.areasCovered ?? [];
        final List<dynamic> packages = service.packageDeals ?? [];
        final List<String> hireTypes = (service.hireTypes ?? []).cast<String>();
        final List<Coupon> coupons = service.coupons ?? [];
        final ratingData = controller.ratings;

        // Safe category & subcategory names
        String categoryName = "Category";
        if (service.categoryId is Map<String, dynamic>) {
          categoryName = service.categoryId['categoryName'] ?? "Category";
        }

        String subcategoryName = "Subcategory";
        if (service.subcategoryId is Map<String, dynamic>) {
          subcategoryName = service.subcategoryId['subcategory_name'] ?? service.subcategoryId['subcategoryName'] ?? "Subcategory";
        } else if (isHorse) {
          subcategoryName = "Horse & Carriage";
        } else if (isLimousine) {
          subcategoryName = "Limousine Hire";
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xFFF5F9FF),
              floating: true,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Get.back(),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      _buildTag(categoryName),
                      const SizedBox(width: 8),
                      _buildTag(subcategoryName),
                    ],
                  ),
                ),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Hero Card
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.grey[200],
                                backgroundImage: images.isNotEmpty
                                    ? NetworkImage(images[0])
                                    : const AssetImage('assets/images/placeholder.png') as ImageProvider,
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      service.listingTitle ?? "Luxury Service",
                                      style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                                      softWrap: true,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      isHorse
                                          ? "Elegant horse-drawn carriage service"
                                          : isLimousine
                                              ? "Premium limousine transportation"
                                              : "Professional coach transportation services",
                                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                                      softWrap: true,
                                    ),
                                    const SizedBox(height: 12),
                                    Row(
                                      children: [
                                        const Icon(Icons.star, color: Colors.amber, size: 22),
                                        const SizedBox(width: 6),
                                        Text(
                                          "${ratingData?.averageRating?.toStringAsFixed(1) ?? 5.0}",
                                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          " (${ratingData?.ratings?.length ?? 0} reviews)",
                                          style: TextStyle(color: Colors.grey[600], fontSize: 15),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {}, // Share functionality
                                    icon: Icon(Icons.share_outlined, color: Colors.grey[700]),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => BookServices(
                                            id: service.id ?? "",
                                            categoryId: service.categoryId is String
                                                ? service.categoryId
                                                : service.categoryId?.id ?? "",
                                            subcategoryId: service.subcategoryId is Map
                                                ? service.subcategoryId['_id'] ?? ""
                                                : service.subcategoryId?.id ?? "",
                                            fromDate: service.bookingDateFrom?.toIso8601String() ?? "",
                                            todate: service.bookingDateTo?.toIso8601String() ?? "",
                                            capacity: isHorse
                                                ? "${service.carriageDetails?.seats ?? 0} seats"
                                                : isLimousine
                                                    ? service.numberOfLimousines?.toString() ?? ""
                                                    : service.fleetInfo?.seats?.toString() ?? "",
                                            ServiceCities: areas.join(", "),
                                            makeModel: isHorse
                                                ? service.carriageDetails?.carriageType
                                                : isLimousine
                                                    ? service.fleetType
                                                    : service.fleetInfo?.makeAndModel,
                                          ));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      elevation: 5,
                                    ),
                                    child: const Text("Book Now", style: TextStyle(fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Quick Info Grid
                          LayoutBuilder(
                            builder: (context, constraints) {
                              final crossCount = constraints.maxWidth > 600 ? 4 : 2;
                              return GridView.count(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                crossAxisCount: crossCount,
                                childAspectRatio: crossCount == 4 ? 3.5 : 2.8,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                children: [
                                  _quickInfo(
                                    Icons.directions_car,
                                    "Type",
                                    isHorse
                                        ? service.carriageDetails?.carriageType ?? "Carriage"
                                        : isLimousine
                                            ? "${service.numberOfLimousines ?? 0} Limousines"
                                            : service.fleetInfo?.makeAndModel ?? "N/A",
                                  ),
                                  _quickInfo(
                                    Icons.event_seat,
                                    "Capacity",
                                    isHorse
                                        ? "${service.carriageDetails?.seats ?? 0} Seats"
                                        : isLimousine
                                            ? service.fleetType ?? "Standard"
                                            : "${service.fleetInfo?.seats ?? 0} Seats",
                                  ),
                                  if (isHorse)
                                    _quickInfo(Icons.pets, "Horses", "${service.carriageDetails?.horseCount ?? 0} Horses"),
                                  _quickInfo(Icons.location_on, "Coverage", "${areas.length} Areas"),
                                  _quickInfo(Icons.verified, "Status", "Verified"),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Service Gallery
                  if (images.isNotEmpty) ...[
                    Text(
                      "Service Gallery (${images.length} Photos)",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 340,
                      child: PageView.builder(
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 12, offset: const Offset(0, 6)),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Image.network(
                                    images[index],
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      return progress == null ? child : const Center(child: CircularProgressIndicator());
                                    },
                                    errorBuilder: (context, error, stack) => Container(
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.broken_image, size: 80, color: Colors.white),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 16,
                                    right: 16,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(30)),
                                      child: Text("${index + 1}/${images.length}", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // HORSE SPECIFIC SECTIONS
                  if (isHorse) ...[
                    _buildSection(
                      title: "Carriage & Horse Details",
                      icon: Icons.pets,
                      color: Colors.brown,
                      children: [
                        _infoCard("Carriage", [
                          _detailRow("Type", service.carriageDetails?.carriageType ?? "N/A"),
                          _detailRow("Number of Carriages", "${service.carriageDetails?.numberOfCarriages ?? 0}"),
                          _detailRow("Seating", "${service.carriageDetails?.seats ?? 0} passengers"),
                        ]),
                        const SizedBox(height: 16),
                        _infoCard("Horses", [
                          _detailRow("Number of Horses", "${service.carriageDetails?.horseCount ?? 0}"),
                          _detailRow("Breeds", service.carriageDetails?.horseBreeds?.join(", ") ?? "N/A"),
                          if (service.carriageDetails?.otherHorseBreed?.isNotEmpty == true)
                            _detailRow("Other Breed", service.carriageDetails!.otherHorseBreed!),
                          _detailRow("Colors", service.carriageDetails?.horseColors?.join(", ") ?? "N/A"),
                        ]),
                      ],
                    ),
                  ],

                  // Limousine Specific: Fleet Features
                  if (isLimousine && service.fleetFeatures != null && service.fleetFeatures.isNotEmpty)
                    _buildSection(
                      title: "Fleet Features",
                      icon: Icons.star,
                      color: Colors.purple,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: service.fleetFeatures.map<Widget>((feature) => Chip(
                            label: Text(feature),
                            backgroundColor: Colors.purple[50],
                          )).toList(),
                        ),
                      ],
                    ),

                  // Fleet Information (for coach/minibus only)
                  if (!isLimousine && !isHorse)
                    _buildSection(
                      title: "Fleet Information",
                      icon: Icons.directions_bus,
                      color: Colors.blue,
                      children: [
                        _infoCard("Vehicle Details", [
                          _detailRow("Make & Model", service.fleetInfo?.makeAndModel ?? "N/A"),
                          _detailRow("Seating Capacity", "${service.fleetInfo?.seats ?? 0} passengers"),
                          _detailRow("First Registered", service.fleetInfo?.firstRegistered?.split('T')[0] ?? "N/A"),
                        ]),
                        const SizedBox(height: 16),
                        _infoCard("Luggage Capacity", [
                          _detailRow("Large Suitcases", "${service.fleetInfo?.largeSuitcases ?? 0}"),
                          _detailRow("Medium Suitcases", "${service.fleetInfo?.mediumSuitcases ?? 0}"),
                          _detailRow("Small Suitcases", "${service.fleetInfo?.smallSuitcases ?? 0}"),
                        ]),
                      ],
                    ),

                  // Pricing & Rates - FIXED: Safe access based on model type
                  _buildSection(
                    title: "Pricing & Rates",
                    icon: Icons.attach_money,
                    color: Colors.green,
                    children: [
                      _infoCard("Rates", [
                        _detailRow(
                          "Hourly Rate",
                          isHorse
                              ? "£${service.pricing?.hourlyRate ?? 0}/hr"
                              : "£${service.pricingDetails?.hourlyRate ?? 0}/hr",
                        ),
                        _detailRow(
                          "Half Day Rate",
                          isHorse
                              ? "£${service.pricing?.halfDayRate ?? 0}"
                              : "£${service.pricingDetails?.halfDayRate ?? 0}",
                        ),
                        _detailRow(
                          "Full Day Rate",
                          isHorse
                              ? "£${service.pricing?.fullDayRate ?? 0}"
                              : "£${service.pricingDetails?.fullDayRate ?? 0}",
                        ),
                      ]),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text("Prices include VAT. Additional charges may apply outside base radius.", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                      ),
                    ],
                  ),

                  // Package Deals & Hire Types
                  _buildSection(
                    title: "Package Deals & Hire Types",
                    icon: Icons.card_giftcard,
                    color: Colors.teal,
                    children: [
                      if (hireTypes.isNotEmpty)
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: hireTypes.map((type) => Chip(
                            label: Text(type, style: const TextStyle(fontSize: 13)),
                            backgroundColor: Colors.teal[50],
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                          )).toList(),
                        ),
                      const SizedBox(height: 20),
                      ...packages.map((pkg) => _packageCard(pkg)),
                    ],
                  ),

                  // Special Events & Add-ons (Limousine only)
                  if (isLimousine && service.events != null)
                    _buildSection(
                      title: "Special Events & Add-ons",
                      icon: Icons.celebration,
                      color: Colors.orange,
                      children: [
                        if (service.events!.weddingDecor == true)
                          _detailRow("Wedding Decor", "Available (£${service.events!.weddingDecorPrice ?? 0})"),
                        if (service.events!.partyLightingSystem == true)
                          _detailRow("Party Lighting System", "Included"),
                        if (service.events!.champagnePackages == true)
                          _detailRow("Champagne Package", "Available"),
                        if (service.events!.photographyPackages == true)
                          _detailRow("Photography Package", "Available"),
                      ],
                    ),

                  // Booking Availability
                  _buildSection(
                    title: "Booking Availability",
                    icon: Icons.calendar_month,
                    color: Colors.purple,
                    children: [
                      Row(
                        children: [
                          Expanded(child: _availabilityCard("Available From", _formatDate(service.bookingDateFrom), Colors.green[100]!)),
                          const SizedBox(width: 12),
                          Expanded(child: _availabilityCard("Available Until", _formatDate(service.bookingDateTo), Colors.blue[100]!)),
                        ],
                      ),
                    ],
                  ),

                  // Comfort & Amenities (only for non-horse)
                  if (!isHorse)
                    _buildSection(
                      title: "Comfort & Amenities",
                      icon: Icons.favorite,
                      color: Colors.pink,
                      children: [
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: [
                            _amenityTile("Leather Interior", Icons.event_seat, service.comfort?.leatherInterior == true),
                            _amenityTile("WiFi Access", Icons.wifi, service.comfort?.wifiAccess == true),
                            _amenityTile("Air Conditioning", Icons.ac_unit, service.comfort?.airConditioning == true),
                            _amenityTile("Entertainment", Icons.tv, service.comfort?.inCarEntertainment == true),
                            _amenityTile("Red Carpet", Icons.star, service.comfort?.redCarpetService == true),
                            _amenityTile("Bluetooth/USB", Icons.bluetooth_audio, service.comfort?.bluetoothUsb == true),
                            _amenityTile("Reclining Seats", Icons.airline_seat_recline_normal, service.comfort?.recliningSeats == true),
                            _amenityTile("Starlights", Icons.lightbulb, service.comfort?.starlights == true),
                            _amenityTile("Massaging Seats", Icons.spa, service.comfort?.massagingSeats == true),
                            _amenityTile("Onboard Restroom", Icons.wc, service.comfort?.onboardRestroom == true),
                          ],
                        ),
                      ],
                    ),

                  // Accessibility
                  _buildSection(
                    title: "Accessibility & Special Needs",
                    icon: Icons.accessible,
                    color: Colors.indigo,
                    children: [
                      _featureTile("Wheelchair Access", "Fully accessible with ramp", service.accessibility?.wheelchairAccessVehicle == true || (isHorse && service.features?.accessibility?.wheelchairAccess == true)),
                      _featureTile("Child Car Seats", "Available", service.accessibility?.childCarSeats == true || (isHorse && service.features?.accessibility?.childSafeSeating == true)),
                      _featureTile("Pet Friendly", "Allowed", service.accessibility?.petFriendlyService == true),
                    ],
                  ),

                  // Security & Safety
                  _buildSection(
                    title: "Security & Safety",
                    icon: Icons.security,
                    color: Colors.green,
                    children: [
                      Row(
                        children: [
                          Expanded(child: _safetyTile("GPS Tracking", "Real-time location tracking", service.security?.vehicleTrackingGps == true)),
                          const SizedBox(width: 12),
                          Expanded(child: _safetyTile("CCTV Fitted", "Onboard cameras for safety", service.security?.cctvFitted == true)),
                        ],
                      ),
                    ],
                  ),

                  // Cancellation Policy
                  _buildSection(
                    title: "Cancellation Policy",
                    icon: Icons.cancel,
                    color: Colors.orange,
                    children: [
                      _policyCard("Flexible Cancellation", "Full refund if cancelled 24+ hours before booking. 50% refund within 24 hours."),
                    ],
                  ),

                  // Coupons
                  if (coupons.isNotEmpty)
                    _buildSection(
                      title: "Coupons & Offers",
                      icon: Icons.local_offer,
                      color: Colors.amber,
                      children: coupons.map((c) => _couponCard(c)).toList(),
                    ),

                  const SizedBox(height: 32),
                  const Text("Customer Reviews", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.teal)),
                  const SizedBox(height: 16),
                  if (controller.isLoadingRatings.value)
                    const Center(child: CircularProgressIndicator())
                  else if (ratingData?.ratings?.isEmpty ?? true)
                    const Text("No reviews yet", style: TextStyle(fontSize: 16, color: Colors.grey))
                  else
                    ...ratingData!.ratings!.map((r) => _reviewCard(r)),

                  const SizedBox(height: 60),

                  // Final Book Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => BookServices(
                              id: service.id ?? "",
                              categoryId: service.categoryId is String ? service.categoryId : service.categoryId?.id ?? "",
                              subcategoryId: service.subcategoryId is Map ? service.subcategoryId['_id'] ?? "" : service.subcategoryId?.id ?? "",
                              fromDate: service.bookingDateFrom?.toIso8601String() ?? "",
                              todate: service.bookingDateTo?.toIso8601String() ?? "",
                              capacity: isHorse
                                  ? "${service.carriageDetails?.seats ?? 0} seats"
                                  : isLimousine
                                      ? service.numberOfLimousines?.toString() ?? ""
                                      : service.fleetInfo?.seats?.toString() ?? "",
                              ServiceCities: areas.join(", "),
                              makeModel: isHorse
                                  ? service.carriageDetails?.carriageType
                                  : isLimousine
                                      ? service.fleetType
                                      : service.fleetInfo?.makeAndModel,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        elevation: 10,
                      ),
                      child: Text(
                        isHorse ? "Book This Carriage Now" : isLimousine ? "Book This Limousine Now" : "Book This Coach Now",
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),
                ]),
              ),
            ),
          ],
        );
      }),
    );
  }

  // ALL YOUR ORIGINAL HELPER METHODS BELOW (UNCHANGED)
  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return DateFormat('EEE, dd MMM yyyy').format(date);
  }

  Widget _buildSection({required String title, required IconData icon, required Color color, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color), overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: children),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _infoCard(String title, List<Widget> rows) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          const SizedBox(height: 12),
          ...rows,
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 15)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              textAlign: TextAlign.end,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickInfo(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.teal[50], borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Icon(icon, color: Colors.teal, size: 32),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(30)),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
    );
  }

  Widget _amenityTile(String label, IconData icon, bool enabled) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: enabled ? Colors.teal[50] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: enabled ? Colors.teal : Colors.transparent),
      ),
      child: Column(
        children: [
          Icon(icon, size: 36, color: enabled ? Colors.teal : Colors.grey),
          const SizedBox(height: 12),
          Text(label, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: enabled ? Colors.teal[800] : Colors.grey)),
          if (enabled) const Icon(Icons.check_circle, color: Colors.teal, size: 24),
        ],
      ),
    );
  }

  Widget _packageCard(dynamic pkg) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(pkg.packageName ?? "Package", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                Text("£${pkg.packageRate ?? 0}", style: const TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Text(pkg.packageDescription ?? "", style: TextStyle(color: Colors.grey[700], fontSize: 14)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (pkg.inclusions ?? []).map<Widget>((i) => Chip(
                label: Text(i, style: const TextStyle(fontSize: 12)),
                backgroundColor: Colors.teal[50],
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _availabilityCard(String label, String date, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 8),
          Text(date, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _featureTile(String title, String desc, bool enabled, {String? price}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: enabled ? Colors.blue[50] : Colors.grey[100], borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Icon(enabled ? Icons.check_circle : Icons.radio_button_unchecked, color: enabled ? Colors.blue : Colors.grey, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(desc, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
              ],
            ),
          ),
          if (price != null) Text(price, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _safetyTile(String title, String desc, bool enabled) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(enabled ? Icons.check_circle : Icons.radio_button_unchecked, color: Colors.green),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10),
          Text(desc, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _policyCard(String title, String desc) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.info, color: Colors.green, size: 28),
              SizedBox(width: 12),
              Text("Flexible Cancellation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            ],
          ),
          const SizedBox(height: 12),
          Text(desc, style: TextStyle(color: Colors.grey[800], fontSize: 15)),
        ],
      ),
    );
  }

  Widget _couponCard(Coupon c) {
    return Card(
      color: Colors.amber[50],
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.local_offer, color: Colors.orange, size: 28),
                const SizedBox(width: 12),
                Text(c.couponCode ?? "COUPON", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text("${c.discountValue ?? 0}% OFF", style: const TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            Text("• Min ${c.minimumDays ?? 0} days booking", style: TextStyle(color: Colors.grey[700])),
            Text("• Min ${c.minimumVehicles ?? 0} vehicles", style: TextStyle(color: Colors.grey[700])),
            Text("• Valid until ${c.expiryDate ?? "N/A"}", style: TextStyle(color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _reviewCard(Rating r) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("${r.userId?.firstName ?? "User"} ${r.userId?.lastName ?? ""}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                const Spacer(),
                Row(
                  children: List.generate(5, (i) => Icon(Icons.star, size: 20, color: i < (r.rating ?? 0) ? Colors.amber : Colors.grey[300])),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(r.comment ?? "Excellent service!", style: TextStyle(color: Colors.grey[800], fontSize: 15)),
            const SizedBox(height: 10),
            Text(
              r.createdAt != null ? DateFormat('dd MMMM yyyy').format(r.createdAt!) : "Date unknown",
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}