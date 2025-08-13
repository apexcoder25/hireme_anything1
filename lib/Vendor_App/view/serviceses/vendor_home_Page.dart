import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/delete_vendor_services_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/boat_hire_edit/boat_hire_edit.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/horse_and_carriage_edit/horse_and_carriage_service_screen.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/limousine_hire_edit/limousine_hire_edit_screen.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/drawer.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/pricing_options_widget.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/service_feature_widget.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/vehicle_specifications_widget.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';

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
        print("serviceList length in UI: ${controller.serviceList.length}");
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

        List<Service> passengerTransportServices = controller.serviceList
            .where((service) =>
                service.categoryId?.categoryName == "Passenger Transport")
            .toList();

        List<Service> displayedServices = passengerTransportServices;

        return RefreshIndicator(
          onRefresh: _refreshServices,
          child: ListView(
            physics: AlwaysScrollableScrollPhysics(),
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
    // Debug service name
    print('asdfgh ${service.serviceName2}');

    String serviceName =
        service.serviceType == "limousine" || service.serviceType == "horse"
            ? (service.serviceName2 ?? 'Unnamed Service')
            : (service.serviceName2 ?? 'Unnamed Service');

    print("Service Name Debug: $serviceName for type: ${service.serviceType}");

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
            // Header image with gradient overlay for better text visibility
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
                              : "https://via.placeholder.com/400x200",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print("Image load error: $error");
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
                              : "https://via.placeholder.com/400x200",
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print("Image load error: $error");
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

                // Gradient overlay for better text visibility
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: [0.0, 0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                ),

                // Service name and category with improved styling
                Positioned(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service Name with better visibility
                      Text(
                        serviceName,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6),
                      // Category container
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          service.subcategoryId?.subcategoryName ?? 'Category',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
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
                  VehicleSpecificationsWidget(service: service),

                  SizedBox(height: 15),

                  // Pricing Options
                  PricingOptionsWidget(service: service),

                  SizedBox(height: 15),

                  // Service Features
                  ServiceFeaturesWidget(service: service),

                  SizedBox(height: 15),

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

                          bool shouldDelete = await deleteApi
                              .showDeleteConfirmation(context, serviceName);

                          if (shouldDelete) {
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
