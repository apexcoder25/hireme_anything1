import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/delete_vendor_services_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/boat_hire_edit/boat_hire_edit.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/horse_and_carriage_edit/horse_and_carriage_service_screen.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/limousine_hire_edit/limousine_hire_edit_screen.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/drawer.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart'; // Ensure this import is present

class HomePageAddService extends StatefulWidget {
  @override
  State<HomePageAddService> createState() => _HomePageAddServiceState();
}

class _HomePageAddServiceState extends State<HomePageAddService> {
  final ServiceController controller = Get.put(ServiceController());

  Future<void> _refreshServices() async {
    try {
      controller.fetchServices();
      print("Fetched services count: ${controller.serviceList.length}");
      print(
          "Fetched services: ${controller.serviceList.map((s) => s.serviceName ?? 'Unnamed').toList()}");
    } catch (e) {
      print("Error during refresh: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dashboard"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: "Drawer",
              barrierColor: Colors.black.withOpacity(0.5),
              transitionDuration: const Duration(milliseconds: 300),
              pageBuilder: (context, anim1, anim2) {
                return const CustomDrawer();
              },
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: Offset.zero,
                  ).animate(anim1),
                  child: child,
                );
              },
            );
          },
          icon: const Icon(Icons.menu, color: colors.white),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        print(
            "serviceList length in UI: ${controller.serviceList.length}"); // Debug
        if (controller.serviceList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.search_off, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text("No services available",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
          );
        }

        // Since all services are under "Passenger Transport," display all
        List<Service> passengerTransportServices = controller.serviceList
            .where((service) =>
                service.categoryId?.categoryName == "Passenger Transport")
            .toList();

        // Remove the take(4) limit to display all services
        List<Service> displayedServices = passengerTransportServices;

        return RefreshIndicator(
          onRefresh: _refreshServices,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(), // Ensure scrollability
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            children: [
              _buildServiceSection(
                "Passenger Transport Services",
                displayedServices,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildServiceSection(String title, List<Service> services) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        SizedBox(height: 10),
        ...services.map((service) => _buildServiceCard(service)).toList(),
      ],
    );
  }

  Widget _buildServiceCard(Service service) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header image with overlay text
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: service.serviceType == "funeral"
                      ? Image.network(
                          service.uploadedDocuments?.fleetPhotos.isNotEmpty ==
                                  true
                              ? (service.uploadedDocuments?.fleetPhotos[0]
                                      .trim() ??
                                  "https://via.placeholder.com/400x200")
                              : "https://via.placeholder.com/400x200", // Updated fallback URL
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print("Image load error: $error"); // Debug log
                            return Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.grey.shade300,
                              child: Center(
                                  child: Icon(Icons.error, color: Colors.red)),
                            );
                          },
                        )
                      : Image.network(
                          service.serviceImage?.isNotEmpty == true
                              ? service.serviceImage!.first.trim()
                              : "https://via.placeholder.com/400x200", // Updated fallback URL
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print("Image load error: $error"); // Debug log
                            return Container(
                              height: 200,
                              width: double.infinity,
                              color: Colors.grey.shade300,
                              child: Center(
                                  child: Icon(Icons.error, color: Colors.red)),
                            );
                          },
                        ),
                ),
                Positioned(
                  bottom: 10,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.serviceType == "limousine" ||
                                service.serviceType == "horse"
                            ? (service.serviceName ?? 'Unnamed Service')
                            : (service.serviceName2 ?? 'Unnamed Service'),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 3, color: Colors.black)],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        margin: EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          service.subcategoryId?.subcategoryName ?? 'Category',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price button & status row
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: StadiumBorder(),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: Text(
                          service.serviceType == "boat" &&
                                  service.boatRates?.fullDayRate != null
                              ? "£${service.boatRates!.fullDayRate}/day"
                              : service.serviceType == "horse" &&
                                      service.pricing?.fullDayRate != null
                                  ? "£${service.pricing!.fullDayRate}/day"
                                  : service.serviceType == "funeral" &&
                                          service.pricingDetails?.dayRate !=
                                              null
                                      ? "£${service.pricingDetails!.dayRate}/day"
                                      : service.serviceType == "minibus" &&
                                              service.miniBusRates
                                                      ?.fullDayRate !=
                                                  null
                                          ? "£${service.miniBusRates!.fullDayRate}/day"
                                          : service.serviceType ==
                                                      "limousine" &&
                                                  service.fullDayRate != null
                                              ? "£${service.fullDayRate}/day"
                                              : "Contact for price",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 10),
                      Chip(
                        label: Text(
                          service.serviceApproveStatus == "0" ||
                                  service.serviceApproveStatus == false
                              ? "Pending"
                              : "Approved",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        backgroundColor: service.serviceApproveStatus == "0" ||
                                service.serviceApproveStatus == false
                            ? Colors.orange
                            : Colors.green,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 16, color: Colors.grey),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          () {
                            final locations = service.serviceType == 'boat'
                                ? service.navigableRoutes ?? []
                                : service.serviceType == 'horse'
                                    ? service.serviceAreas ?? []
                                    : service.areasCovered ?? [];

                            if (locations.isNotEmpty) {
                              return "${locations.first}${locations.length > 1 ? ' + ${locations.length - 1} more' : ''}";
                            } else {
                              return "Unknown";
                            }
                          }(),
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  // Vehicle Specifications
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "🚤 Vehicle Specifications",
                      style: TextStyle(
                        color: Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Vehicle Specifications Details (Dynamic for each type)
                  if (service.fleetInfo != null ||
                      service.fleetDetails != null ||
                      service.serviceDetails != null ||
                      (service.serviceType == "limousine" &&
                          service.serviceFleetDetails.isNotEmpty))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (service.serviceType == "boat" &&
                            service.fleetInfo != null)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Boat Name",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(service.fleetInfo!.boatName ?? 'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Type",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(service.fleetInfo!.type ?? 'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Capacity",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      "${service.fleetInfo!.capacity ?? 'N/A'} passengers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Year",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      service.fleetInfo!.year?.toString() ??
                                          'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        if (service.serviceType == "horse" &&
                            service.serviceDetails != null)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Carriage Types",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        service.serviceDetails!.carriageTypes
                                                ?.join(", ") ??
                                            'N/A',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Horse Types",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        service.serviceDetails!.horseTypes
                                                ?.join(", ") ??
                                            'N/A',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.right,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Fleet Size",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      "${service.serviceDetails!.fleetSize ?? 'N/A'}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        if (service.serviceType == "funeral" &&
                            service.fleetDetails != null)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Make & Model",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(service.fleetDetails!.makeModel ?? 'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vehicle Type",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      service.fleetDetails!.vehicleType ??
                                          'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Capacity",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      "${service.fleetDetails!.capacity ?? 'N/A'} passengers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Year",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text("${service.fleetDetails!.year ?? 'N/A'}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        if (service.serviceType == "minibus" &&
                            service.fleetInfo != null)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Make & Model",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(service.fleetInfo!.makeAndModel ?? 'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Capacity",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      "${service.fleetInfo!.capacity ?? 'N/A'} passengers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Wheelchair Accessible",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      "${service.fleetInfo!.wheelchairAccessible ?? false ? 'Yes' : 'No'}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Year",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      service.fleetInfo!.year?.toString() ??
                                          'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        if (service.serviceType == "limousine" &&
                            service.serviceFleetDetails.isNotEmpty)
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Make & Model",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      service.serviceFleetDetails[0]
                                              .makeModel ??
                                          'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Vehicle Type",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      service.serviceFleetDetails[0].type ??
                                          'N/A',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Capacity",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      "${service.serviceFleetDetails[0].capacity ?? 'N/A'} passengers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Year",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                      "${service.serviceFleetDetails[0].year ?? 'N/A'}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                      ],
                    ),

                  SizedBox(height: 15),

                  // Pricing Options
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "💰 Pricing Options",
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Pricing Details (Dynamic for each type)
                  if (service.serviceType == "boat" &&
                      service.boatRates != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text(
                              "£${service.boatRates!.hourlyRate ?? 0} per hour",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text(
                              "£${service.boatRates!.halfDayRate ?? 0} half day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text(
                              "£${service.boatRates!.fullDayRate ?? 0} full day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ],
                    ),
                  if (service.serviceType == "horse" && service.pricing != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text("£${service.pricing!.hourlyRate ?? 0} per hour",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text("£${service.pricing!.halfDayRate ?? 0} half day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text("£${service.pricing!.fullDayRate ?? 0} full day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ],
                    ),
                  if (service.serviceType == "funeral" &&
                      service.pricingDetails != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text(
                              "£${service.pricingDetails!.hourlyRate ?? 0} per hour",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text(
                              "£${service.pricingDetails!.halfDayRate ?? 0} half day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text(
                              "£${service.pricingDetails!.dayRate ?? 0} full day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ],
                    ),
                  if (service.serviceType == "minibus" &&
                      service.miniBusRates != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text(
                              "£${service.miniBusRates!.hourlyRate ?? 0} per hour",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text(
                              "£${service.miniBusRates!.halfDayRate ?? 0} half day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text(
                              "£${service.miniBusRates!.fullDayRate ?? 0} full day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ],
                    ),
                  if (service.serviceType == "limousine")
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [
                          Text("£${service.hourlyRate ?? 0} per hour",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text("£${service.halfDayRate ?? 0} half day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                        Column(children: [
                          Text("£${service.fullDayRate ?? 0} full day",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500))
                        ]),
                      ],
                    ),

                  SizedBox(height: 15),

                  // Service Features
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.yellow.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      "⭐ Service Features",
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Service Features (Dynamic for each type)
                  if (service.serviceType == "boat")
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Icon(Icons.person, size: 16, color: Colors.green),
                          SizedBox(width: 5),
                          Text("Professional Boat",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700)),
                        ],
                      ),
                    ),
                  if (service.serviceType == "horse" &&
                      service.serviceDetails != null &&
                      service.serviceDetails!.occasionsCatered != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Icon(Icons.safety_check,
                              size: 16, color: Colors.green),
                          SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "Occasions Catered: ${service.serviceDetails!.occasionsCatered!.join(", ")}",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (service.serviceType == "funeral" &&
                      service.fleetDetails != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Icon(Icons.car_repair, size: 16, color: Colors.green),
                          SizedBox(width: 5),
                          Text("Classic Funeral Van",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700)),
                        ],
                      ),
                    ),
                  if (service.serviceType == "minibus" &&
                      service.fleetInfo != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Icon(Icons.accessible, size: 16, color: Colors.green),
                          SizedBox(width: 5),
                          Text("Wheelchair Accessible",
                              style: TextStyle(
                                  fontSize: 14, color: Colors.grey.shade700)),
                        ],
                      ),
                    ),
                  if (service.serviceType == "limousine" &&
                      service.features != null)
                    Column(
                      children: [
                        if (service.features!.comfortAndLuxury?.isNotEmpty ??
                            false)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Icon(Icons.star, size: 16, color: Colors.green),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Comfort & Luxury: ${service.features!.comfortAndLuxury!.join(", ")}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (service
                                .features!.eventsAndCustomization?.isNotEmpty ??
                            false)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Icon(Icons.event,
                                    size: 16, color: Colors.green),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Events & Customization: ${service.features!.eventsAndCustomization!.join(", ")}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (service
                                .features!.accessibilityServices?.isNotEmpty ??
                            false)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Icon(Icons.accessible,
                                    size: 16, color: Colors.green),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Accessibility: ${service.features!.accessibilityServices!.join(", ")}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (service.features!.safetyAndCompliance?.isNotEmpty ??
                            false)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Icon(Icons.security,
                                    size: 16, color: Colors.green),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Text(
                                    "Safety & Compliance: ${service.features!.safetyAndCompliance!.join(", ")}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade700),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),

                  // Edit/Delete buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          if (service.serviceType == "boat" &&
                              service.id != null) {
                            Get.to(() =>
                                BoatHireEditScreen(serviceId: service.id!));
                          }
                          if (service.serviceType == "horse" &&
                              service.id != null) {
                            Get.to(() => HorseCarriageEditScreen(
                                serviceId: service.id!));
                          }
                          if (service.serviceType == "limousine" &&
                              service.id != null) {
                            Get.to(() =>
                                LimoHireEditScreen(serviceId: service.id!));
                          }
                        },
                        icon: Icon(Icons.edit, size: 16),
                        label: Text("Edit"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.blue.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (service.id == null) {
                            Get.snackbar(
                              "Error",
                              "Service ID not found",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                            );
                            return;
                          }

                          final deleteApi = DeleteVendorServiceApi();

                          // Get service name for confirmation dialog
                          String serviceName =
                              service.serviceType == "limousine" ||
                                      service.serviceType == "horse"
                                  ? (service.serviceName ?? 'Unnamed Service')
                                  : (service.serviceName2 ?? 'Unnamed Service');

                          bool shouldDelete = await deleteApi
                              .showDeleteConfirmation(context, serviceName);

                          if (shouldDelete) {
                            // Call delete API
                            bool deleted = await deleteApi
                                .deleteVendorService(service.id!);

                            Get.back();

                            if (deleted) {
                              await _refreshServices();
                            }
                          }
                        },
                        icon: Icon(Icons.delete, size: 16),
                        label: Text("Delete"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.red.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
