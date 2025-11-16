import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/filter_model_services.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/book_service.dart';
import 'package:hire_any_thing/User_app/views/services_details/services_details.dart';
import 'package:intl/intl.dart';

class ServiceCard extends StatefulWidget {
  final Datum service;

  const ServiceCard({required this.service, super.key});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  @override
  Widget build(BuildContext context) {
    const double rating = 0.0; // Placeholder; update if rating is added to Datum
    print("Rendering card for: ${widget.service.serviceName}, _sourceModel: ${widget.service.sourceModel}");

    // Date formatting
    final DateFormat dateFormat = DateFormat('d MMM yyyy');
    String formattedFromDate = widget.service.sourceModel == "horse"
        ? (widget.service.availabilityPeriod?.from != null ? dateFormat.format(widget.service.availabilityPeriod!.from!.toLocal()) : 'Start')
        : widget.service.sourceModel == "funeral"
            ? (widget.service.bookingAvailabilityDateFrom != null ? dateFormat.format(widget.service.bookingAvailabilityDateFrom!.toLocal()) : 'Start')
            : (widget.service.datumBookingDateFrom != null ? dateFormat.format(widget.service.datumBookingDateFrom!.toLocal()) : 'Start');
    String formattedToDate = widget.service.sourceModel == "horse"
        ? (widget.service.availabilityPeriod?.to != null ? dateFormat.format(widget.service.availabilityPeriod!.to!.toLocal()) : 'End')
        : widget.service.sourceModel == "funeral"
            ? (widget.service.bookingAvailabilityDateTo != null ? dateFormat.format(widget.service.bookingAvailabilityDateTo!.toLocal()) : 'End')
            : (widget.service.datumBookingDateTo != null
                ? dateFormat.format(DateTime.parse(widget.service.datumBookingDateTo!).toLocal())
                : 'End');

    // Determine banner content
    String bannerText = (widget.service.coupons?.isNotEmpty ?? false)
        ? "Special Offer"
        : widget.service.sourceModel == "funeral"
            ? "Hourly: £${widget.service.pricingDetails?.hourlyRate?.toStringAsFixed(2) ?? 'N/A'}"
            : widget.service.sourceModel == "horse"
                ? "Hourly: £${widget.service.pricing?.hourlyRate?.toStringAsFixed(2) ?? 'N/A'} (incl. Fuel)"
                : "Hourly: £${widget.service.pricingDetails?.hourlyRate?.toStringAsFixed(2) ?? 'N/A'} (per Seat)";

    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    widget.service.serviceImage.isNotEmpty
                        ? widget.service.serviceImage[0]
                        : "https://hireanything.com/image/about.png",
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Image.network(
                      "https://hireanything.com/image/about.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black87],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                if (widget.service.categoryId?.categoryName != null)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: _buildLabel(widget.service.categoryId!.categoryName!, Colors.green),
                  ),
                if ((widget.service.coupons?.isNotEmpty ?? false))
                  Positioned(
                    top: 10,
                    right: 10,
                    child: _buildLabel("Special Offer", Colors.redAccent),
                  ),
                // Hourly rate or special offer banner
                if (!(widget.service.coupons?.isNotEmpty ?? false))
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        bannerText,
                        style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.service.sourceModel == "horse"
                            ? (widget.service.serviceName ?? '')
                            : (widget.service.datumServiceName ?? widget.service.serviceName ?? 'Unknown Service'),
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      if (widget.service.fleetInfo?.seats != null)
                        Row(
                          children: [
                            Icon(Icons.event_seat, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              widget.service.fleetInfo!.seats.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (widget.service.subcategoryId?.subcategoryName != null)
                        _buildBadge(widget.service.subcategoryId!.subcategoryName!, Colors.blue),
                      if (widget.service.categoryId?.categoryName != null)
                        _buildBadge(widget.service.categoryId!.categoryName!, Colors.green),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.service.sourceModel == "horse"
                              ? "${widget.service.serviceAreas?.isNotEmpty == true ? widget.service.serviceAreas!.take(3).join(', ') : 'N/A'}${widget.service.serviceAreas?.length != null && widget.service.serviceAreas!.length > 3 ? ' +${widget.service.serviceAreas!.length - 3} more' : ''}"
                              : "${widget.service.areasCovered?.isNotEmpty == true ? widget.service.areasCovered!.take(3).join(', ') : 'N/A'}${widget.service.areasCovered?.length != null && widget.service.areasCovered!.length > 3 ? ' +${widget.service.areasCovered!.length - 3} more' : ''}",
                          style: TextStyle(fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text("New", style: TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        "$formattedFromDate - $formattedToDate",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Specific details and pricing based on _sourceModel
                  if (widget.service.sourceModel == "funeral")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vehicle Types: ${widget.service.funeralVehicleTypes?.join(', ') ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        Text("Packages: Standard: ${widget.service.funeralPackageOptions?.standard ?? 0}, VIP: ${widget.service.funeralPackageOptions?.vipExecutive ?? 0}", style: TextStyle(fontSize: 13)),
                        const SizedBox(height: 4),
                        Text("Pricing Details:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text("Day Rate: £${widget.service.pricingDetails?.dayRate?.toStringAsFixed(2) ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        Text("Half Day Rate: £${widget.service.pricingDetails?.halfDayRate?.toStringAsFixed(2) ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        Text("Hourly Rate: £${widget.service.pricingDetails?.hourlyRate?.toStringAsFixed(2) ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        Text("Mileage Limit: ${widget.service.pricingDetails?.mileageLimit?.toString() ?? 'N/A'} miles", style: TextStyle(fontSize: 13)),
                        Text("Extra Mileage: £${widget.service.pricingDetails?.extraMileageCharge?.toStringAsFixed(2) ?? 'N/A'}/mile", style: TextStyle(fontSize: 13)),
                        Text("Wait Time Fee: £${widget.service.pricingDetails?.waitTimeFeePerHour?.toStringAsFixed(2) ?? 'N/A'}/hr", style: TextStyle(fontSize: 13)),
                        Text("Floral Service Fee: £${widget.service.pricingDetails?.decoratingFloralServiceFee?.toStringAsFixed(2) ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  if (widget.service.sourceModel == "horse")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Carriage Types: ${widget.service.serviceDetails?.carriageTypes?.join(', ') ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        Text("Horse Types: ${widget.service.serviceDetails?.horseTypes?.join(', ') ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        Text("Number of Carriages: ${widget.service.serviceDetails?.numberOfCarriages?.toString() ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        const SizedBox(height: 4),
                        Text("Pricing Details:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text("Day Rate: £${widget.service.pricing?.fullDayRate?.toStringAsFixed(2) ?? 'N/A'} (incl. Fuel)", style: TextStyle(fontSize: 13)),
                        Text("Half Day Rate: £${widget.service.pricing?.halfDayRate?.toStringAsFixed(2) ?? 'N/A'} (incl. Fuel)", style: TextStyle(fontSize: 13)),
                        Text("Hourly Rate: £${widget.service.pricing?.hourlyRate?.toStringAsFixed(2) ?? 'N/A'} (incl. Fuel)", style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  if (widget.service.sourceModel == "chauffeur")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Vehicle Type: ${widget.service.vehicleType ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        Text("Make/Model: ${widget.service.fleetInfo?.makeAndModel ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        Text("Seats: ${widget.service.fleetInfo?.seats?.toString() ?? 'N/A'}", style: TextStyle(fontSize: 13)),
                        const SizedBox(height: 4),
                        Text("Pricing Details:", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        Text("Day Rate: £${widget.service.pricingDetails?.dayRate?.toStringAsFixed(2) ?? 'N/A'} (per Seat)", style: TextStyle(fontSize: 13)),
                        Text("Half Day Rate: £${widget.service.pricingDetails?.halfDayRate?.toStringAsFixed(2) ?? 'N/A'} (per Seat)", style: TextStyle(fontSize: 13)),
                        Text("Hourly Rate: £${widget.service.pricingDetails?.hourlyRate?.toStringAsFixed(2) ?? 'N/A'} (per Seat)", style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      if (widget.service.categoryId != null && widget.service.subcategoryId != null) {
                        if (widget.service.sourceModel == "funeral") {
                          Get.to(() => ServicesDetails(
                                categoryId: widget.service.categoryId!.id ?? "",
                                subcategoryId: widget.service.subcategoryId!.id ?? "",
                                categoryName: widget.service.categoryId!.categoryName ?? "",
                                subcategoryName: widget.service.subcategoryId!.subcategoryName ?? "",
                                serviceName: widget.service.serviceName ?? widget.service.datumServiceName ?? 'Unknown Service',
                                cityNames: widget.service.areasCovered.join(", "),
                                kmPrice: (widget.service.pricingDetails?.hourlyRate ?? 0.0).toStringAsFixed(2),
                                minDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? "0",
                                maxDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? "0",
                                description: widget.service.businessProfile?.description ?? "",
                                airon_fitted: widget.service.features?.comfort?.airConditioning == true ? "yes" : "no",
                                wheelChair: widget.service.features?.accessibility?.wheelchairAccessVehicle == true ? "yes" : "no",
                                bookingDateFrom: widget.service.bookingAvailabilityDateFrom?.toIso8601String() ?? "",
                                bookingDateTo: widget.service.bookingAvailabilityDateTo?.toIso8601String() ?? "",
                                makeAndModel: widget.service.fleetDetails?.makeModel ?? "",
                                registration: widget.service.fleetDetails?.notes ?? "",
                                noOfSeats: widget.service.fleetDetails?.capacity,
                                serviceImage: widget.service.serviceImage.isNotEmpty ? widget.service.serviceImage[0] : "",
                                service: widget.service,
                                vehicleTypes: widget.service.funeralVehicleTypes?.join(", ") ?? "",
                                packageOptions: "Standard: ${widget.service.funeralPackageOptions?.standard ?? 0}, VIP: ${widget.service.funeralPackageOptions?.vipExecutive ?? 0}",
                              ));
                        } else if (widget.service.sourceModel == "horse") {
                          Get.to(() => ServicesDetails(
                                categoryId: widget.service.categoryId!.id ?? "",
                                subcategoryId: widget.service.subcategoryId!.id ?? "",
                                categoryName: widget.service.categoryId!.categoryName ?? "",
                                subcategoryName: widget.service.subcategoryId!.subcategoryName ?? "",
                                serviceName: widget.service.serviceName ?? 'Unknown Service',
                                cityNames: widget.service.serviceAreas.join(", "),
                                kmPrice: (widget.service.pricing?.hourlyRate ?? 0.0).toStringAsFixed(2),
                                minDistance: "N/A",
                                maxDistance: "N/A",
                                description: widget.service.marketing?.description ?? "",
                                airon_fitted: "no", // Assuming no air conditioning for horses
                                wheelChair: "no", // Assuming no wheelchair access for horses
                                bookingDateFrom: widget.service.availabilityPeriod?.from?.toIso8601String() ?? "",
                                bookingDateTo: widget.service.availabilityPeriod?.to?.toIso8601String() ?? "",
                                makeAndModel: "",
                                registration: "",
                                noOfSeats: null,
                                serviceImage: widget.service.images.isNotEmpty ? widget.service.images[0] : "",
                                service: widget.service,
                                carriageTypes: widget.service.serviceDetails?.carriageTypes?.join(", ") ?? "",
                                horseTypes: widget.service.serviceDetails?.horseTypes?.join(", ") ?? "",
                              ));
                        } else if (widget.service.sourceModel == "chauffeur") {
                          Get.to(() => ServicesDetails(
                                categoryId: widget.service.categoryId!.id ?? "",
                                subcategoryId: widget.service.subcategoryId!.id ?? "",
                                categoryName: widget.service.categoryId!.categoryName ?? "",
                                subcategoryName: widget.service.subcategoryId!.subcategoryName ?? "",
                                serviceName: widget.service.serviceName ?? widget.service.datumServiceName ?? 'Unknown Service',
                                cityNames: widget.service.areasCovered.join(", "),
                                kmPrice: (widget.service.pricingDetails?.hourlyRate ?? 0.0).toStringAsFixed(2),
                                minDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? "0",
                                maxDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? "0",
                                description: widget.service.businessProfile?.description ?? "",
                                airon_fitted: widget.service.features?.comfort?.airConditioning == true ? "yes" : "no",
                                wheelChair: widget.service.features?.accessibility?.wheelchairAccessVehicle == true ? "yes" : "no",
                                bookingDateFrom: widget.service.datumBookingDateFrom?.toIso8601String() ?? "",
                                bookingDateTo: widget.service.datumBookingDateTo != null
                                    ? DateTime.tryParse(widget.service.datumBookingDateTo!)?.toIso8601String() ?? ""
                                    : "",
                                makeAndModel: widget.service.fleetInfo?.makeAndModel ?? "",
                                registration: widget.service.fleetInfo?.chauffeurName ?? "",
                                noOfSeats: widget.service.fleetInfo?.seats,
                                serviceImage: widget.service.serviceImage.isNotEmpty ? widget.service.serviceImage[0] : "",
                                service: widget.service,
                                vehicleType: widget.service.vehicleType ?? "",
                              ));
                        }
                      } else {
                        Get.snackbar("Error", "Category or Subcategory is missing");
                      }
                    },
                    child: Center(
                      child: Text(
                        "Show more details",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (widget.service.categoryId != null && widget.service.subcategoryId != null) {
                          if (widget.service.sourceModel == "funeral") {
                            Get.to(() => BookServices(
                                  id: widget.service.id ?? "",
                                  categoryId: widget.service.categoryId!.id ?? "",
                                  subcategoryId: widget.service.subcategoryId!.id ?? "",
                                  fromDate: widget.service.bookingAvailabilityDateFrom?.toIso8601String() ?? "",
                                  todate: widget.service.bookingAvailabilityDateTo?.toIso8601String() ?? "",
                                  capacity: widget.service.fleetDetails?.capacity?.toString() ?? "0",
                                  minDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? "0",
                                  maxDistsnce: widget.service.pricingDetails?.mileageLimit?.toString() ?? "0",
                                  ServiceCities: widget.service.areasCovered.join(", "),
                                  vehicleTypes: widget.service.funeralVehicleTypes?.join(", ") ?? "",
                                  packageOptions: "Standard: ${widget.service.funeralPackageOptions?.standard ?? 0}, VIP: ${widget.service.funeralPackageOptions?.vipExecutive ?? 0}",
                                ));
                          } else if (widget.service.sourceModel == "horse") {
                            Get.to(() => BookServices(
                                  id: widget.service.id ?? "",
                                  categoryId: widget.service.categoryId!.id ?? "",
                                  subcategoryId: widget.service.subcategoryId!.id ?? "",
                                  fromDate: widget.service.availabilityPeriod?.from?.toIso8601String() ?? "",
                                  todate: widget.service.availabilityPeriod?.to?.toIso8601String() ?? "",
                                  capacity: widget.service.serviceDetails?.numberOfCarriages?.toString() ?? "0",
                                  minDistance: "N/A",
                                  maxDistsnce: "N/A",
                                  ServiceCities: widget.service.serviceAreas.join(", "),
                                  carriageTypes: widget.service.serviceDetails?.carriageTypes?.join(", ") ?? "",
                                  horseTypes: widget.service.serviceDetails?.horseTypes?.join(", ") ?? "",
                                ));
                          } else if (widget.service.sourceModel == "chauffeur") {
                            Get.to(() => BookServices(
                                  id: widget.service.id ?? "",
                                  categoryId: widget.service.categoryId!.id ?? "",
                                  subcategoryId: widget.service.subcategoryId!.id ?? "",
                                  fromDate: widget.service.datumBookingDateFrom?.toIso8601String() ?? "",
                                  todate: widget.service.datumBookingDateTo != null
                                      ? DateTime.tryParse(widget.service.datumBookingDateTo!)?.toIso8601String() ?? ""
                                      : "",
                                  capacity: widget.service.fleetInfo?.seats?.toString() ?? "0",
                                  minDistance: widget.service.pricingDetails?.mileageLimit?.toString() ?? "0",
                                  maxDistsnce: widget.service.pricingDetails?.mileageLimit?.toString() ?? "0",
                                  ServiceCities: widget.service.areasCovered.join(", "),
                                  vehicleType: widget.service.vehicleType ?? "",
                                  makeModel: widget.service.fleetInfo?.makeAndModel ?? "",
                                ));
                          }
                        } else {
                          Get.snackbar("Error", "Category or Subcategory is missing");
                        }
                      },
                      icon: Icon(Icons.info_outline, color: Colors.black),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      label: Text(
                        "Booking & Details",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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

  Widget _buildLabel(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}