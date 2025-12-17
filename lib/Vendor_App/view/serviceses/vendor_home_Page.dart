import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/delete_vendor_services_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_passenger_services/boat_hire_edit/boat_hire_edit.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/pricing_options_widget.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/service_feature_widget.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/vehicle_specifications_widget.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/Vendor_App/view/main_dashboard/controllers/vendor_dashboard_controller.dart';

class HomePageAddService extends StatefulWidget {
  @override
  State<HomePageAddService> createState() => _HomePageAddServiceState();
}

class _HomePageAddServiceState extends State<HomePageAddService> {
  late final ServiceController controller;

  @override
  void initState() {
    super.initState();
    // Try to find existing controller, or create new one
    try {
      controller = Get.find<ServiceController>();
      print("🔍 Found existing ServiceController");
    } catch (e) {
      controller = Get.put(ServiceController());
      print("🆕 Created new ServiceController");
    }
    
    // Add a small delay to ensure controller is fully initialized
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 500));
      print("🔄 Post-frame callback - checking controller state:");
      print("  - Initialized: ${controller.isInitialized.value}");
      print("  - Loading: ${controller.isLoading.value}");
      print("  - Services: ${controller.serviceList.length}");
      
      // If not loading and no services, try manual fetch
      if (!controller.isLoading.value && controller.serviceList.isEmpty && !controller.hasError.value) {
        print("🔄 No services found, attempting manual fetch...");
        await controller.fetchServices();
      }
    });
  }

  Future<void> _refreshServices() async {
    try {
      print("🔄 Manual refresh triggered");
      await controller.fetchServices();
      print("✅ Manual refresh completed. Services count: ${controller.serviceList.length}");
      print(
          "Service titles: ${controller.serviceList.map((s) => s.serviceName ?? s.listingTitle).toList()}");
    } catch (e) {
      print("❌ Error during manual refresh: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: Obx(() {
        print("🎭 UI Rebuild triggered - Controller state:");
        print("  - Loading: ${controller.isLoading.value}");
        print("  - Has Error: ${controller.hasError.value}");
        print("  - Error Message: '${controller.errorMessage.value}'");
        print("  - ServiceList Length: ${controller.serviceList.length}");
        print("  - Vendor ID: '${controller.vendorId.value}'");
        print("  - Has Auth Token: ${controller.authToken.value.isNotEmpty}");
        
        if (controller.isLoading.value) {
          print("🔄 Showing loading indicator");
          return Center(child: CircularProgressIndicator());
        }
        
        if (controller.hasError.value) {
          print("❌ Showing error state: ${controller.errorMessage.value}");
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Icon(Icons.error, size: 64, color: Colors.red),
               const SizedBox(height: 16),
                Text("Error: ${controller.errorMessage.value}"),
               const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.refreshServices(),
                  child: const Text("Retry"),
                ),
              ],
            ),
          );
        }
        
        print("📊 Final check - serviceList.isEmpty: ${controller.serviceList.isEmpty}");
        if (controller.serviceList.isEmpty) {
          print("📋 Showing empty state");
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Circle icon background
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(24),
                    child: const Icon(
                      Icons.inventory_2_outlined,
                      size: 48,
                      color: AppColors.blue,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "No Services Yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "Start building your business by creating your first service. It only takes a few minutes to get started.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ElevatedButton(
                      //   onPressed: () async {
                      //     await controller.debugFullFlow();
                      //   },
                      //   style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                      //   child: const Text("Debug Test", style: TextStyle(color: Colors.white)),
                      // ),
                      ElevatedButton(
                        onPressed: () async {
                          await _refreshServices();
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text("Manual Refresh", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Get the dashboard controller and navigate to Add Services tab
                          try {
                            final dashboardController = Get.find<VendorDashboardController>();
                            dashboardController.changeTab(2); // Index 2 is Add Services
                            
                            // Open the drawer to show the navigation
                            Scaffold.of(context).openDrawer();
                          } catch (e) {
                            // Fallback: direct navigation if controller not found
                            Get.toNamed(VendorRoutesName.vendorServicesScreen);
                          }
                        },
                        icon: const Icon(Icons.add, color: Colors.white),
                        label:const Text("Create Your First Service", style:  TextStyle(color: Colors.white),),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: AppColors.btnColor,
                          shadowColor: AppColors.btnColor.withOpacity(0.3),
                        ),
                        
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        List<Service> passengerTransportServices = controller.serviceList
            .where((service) =>
                service.categoryId.categoryName == CategoryName.PASSENGER_TRANSPORT)
            .toList();

        List<Service> displayedServices = passengerTransportServices;

        return RefreshIndicator(
          onRefresh: _refreshServices,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        const SizedBox(height: 10),
        ...services.map((service) => _buildServiceCard(service)).toList(),
      ],
    );
  }

  Widget _buildServiceCard(Service service) {
    // Debug service name

    String serviceName;

    serviceName = service.listingTitle;

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
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(15)),
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
                              child: const Center(
                                  child: Icon(Icons.error, color: Colors.red)),
                            );
                          },
                        )
                      : service.serviceType == "boat"
                          ? Image.network(
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
                                  child: const Center(
                                      child: Icon(Icons.error, color: Colors.red)),
                                );
                              },
                            )
                          : Image.network(
                              service.serviceImages?.isNotEmpty == true
                                  ? service.serviceImages!.first.trim()
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
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.7),
                        ],
                        stops: const [0.0, 0.5, 0.8, 1.0],
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
                          service.subcategoryId.subcategoryName,
                          style: const TextStyle(
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
                          _getPriceDisplay(service),
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
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                        backgroundColor: service.serviceApproveStatus == "0" ||
                                service.serviceApproveStatus == false
                            ? Colors.orange
                            : Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          _getLocationDisplay(service),
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Vehicle Specifications
                  VehicleSpecificationsWidget(service: service),

                  const SizedBox(height: 15),

                  // Pricing Options
                  PricingOptionsWidget(service: service),

                  const SizedBox(height: 15),

                  // Service Features
                  ServiceFeaturesWidget(service: service),

                  const SizedBox(height: 15),

                  // Edit/Delete buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // ElevatedButton.icon(
                      //   onPressed: () {
                      //     if (service.serviceType == "boat") {
                      //       Get.to(() =>
                      //           BoatHireEditScreen(serviceId: service.id));
                      //     }
                      //     if (service.serviceType == "horse") {
                      //       // Get.to(() => HorseCarriageEditScreen(
                      //       //     serviceId: service.id));
                      //     }
                      //     if (service.serviceType == "limousine") {
                      //       // Get.to(() =>
                      //       //     LimoHireEditScreen(serviceId: service.id));
                      //     }
                      //     if (service.serviceType == "funeral") {
                      //       // Get.to(() => FuneralCarHireEditScreen(
                      //       //     serviceId: service.id));
                      //     }
                      //   },
                      //   icon: const Icon(Icons.edit, size: 16),
                      //   label: const Text("Edit"),
                      //   style: ElevatedButton.styleFrom(
                      //     foregroundColor: Colors.blue,
                      //     backgroundColor: Colors.blue.shade50,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),

                      Spacer(),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (service.id.isEmpty) {
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
                                .deleteVendorService(service.id);

                            Get.back();

                            if (deleted) {
                              await _refreshServices();
                            }
                          }
                        },
                        icon: const Icon(Icons.delete, size: 16),
                        label: const Text("Delete"),
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

  String _getPriceDisplay(Service service) {
    switch (service.serviceType) {
      case "boat":
        if (service.boatRates?.fullDayRate != null) {
          return "£${service.boatRates!.fullDayRate!.toStringAsFixed(0)}/day";
        }
        if (service.boatRates?.halfDayRate != null) {
          return "£${service.boatRates!.halfDayRate!.toStringAsFixed(0)}/half day";
        }
        if (service.boatRates?.threeHourRate != null) {
          return "£${service.boatRates!.threeHourRate!.toStringAsFixed(0)}/3 hours";
        }
        if (service.boatRates?.hourlyRate != null) {
          return "£${service.boatRates!.hourlyRate!.toStringAsFixed(0)}/hour";
        }
        // Fallback to old fields
        if (service.boatRates?.tenHourDayHire != null) {
          return "£${service.boatRates!.tenHourDayHire!.toStringAsFixed(0)}/day";
        }
        if (service.boatRates?.halfDayHire != null) {
          return "£${service.boatRates!.halfDayHire!.toStringAsFixed(0)}/half day";
        }
        break;
      case "horse":
        if (service.pricing?.fullDayRate != null) {
          return "£${service.pricing!.fullDayRate}/day";
        }
        if (service.pricing?.halfDayRate != null) {
          return "£${service.pricing!.halfDayRate}/half day";
        }
        if (service.pricing?.hourlyRate != null) {
          return "£${service.pricing!.hourlyRate}/hour";
        }
        break;
      case "funeral":
        if (service.pricingDetails?.dayRate != null) {
          return "£${service.pricingDetails!.dayRate}/day";
        }
        if (service.pricingDetails?.hourlyRate != null) {
          return "£${service.pricingDetails!.hourlyRate}/hour";
        }
        break;
      case "minibus":
        if (service.miniBusRates?.fullDayRate != null) {
          return "£${service.miniBusRates!.fullDayRate}/day";
        }
        if (service.miniBusRates?.halfDayRate != null) {
          return "£${service.miniBusRates!.halfDayRate}/half day";
        }
        if (service.miniBusRates?.hourlyRate != null) {
          return "£${service.miniBusRates!.hourlyRate}/hour";
        }
        break;
      case "limousine":
        if (service.pricingDetails?.fullDayRate != null) {
          return "£${service.pricingDetails!.fullDayRate}/day";
        }
        if (service.pricingDetails?.halfDayRate != null) {
          return "£${service.pricingDetails!.halfDayRate}/half day";
        }
        if (service.pricingDetails?.hourlyRate != null) {
          return "£${service.pricingDetails!.hourlyRate}/hour";
        }
        break;
      case "chauffeur":
        if (service.pricingDetails?.dayRate != null) {
          return "£${service.pricingDetails!.dayRate}/day";
        }
        if (service.pricingDetails?.halfDayRate != null) {
          return "£${service.pricingDetails!.halfDayRate}/half day";
        }
        if (service.pricingDetails?.hourlyRate != null) {
          return "£${service.pricingDetails!.hourlyRate}/hour";
        }
        break;
      case "coach":
        if (service.pricingDetails?.fullDayRate != null) {
          return "£${service.pricingDetails!.fullDayRate}/day";
        }
        if (service.pricingDetails?.hourlyRate != null) {
          return "£${service.pricingDetails!.hourlyRate}/hour";
        }
        break;
    }
    return "Contact for price";
  }

  String _getLocationDisplay(Service service) {
    List<String> locations = [];
    
    switch (service.serviceType) {
      case 'boat':
        locations = service.serviceCoverage ?? service.areasCovered ?? [];
        break;
      case 'horse':
        locations = service.areasCovered ?? [];
        break;
      default:
        locations = service.areasCovered ?? [];
        break;
    }

    if (locations.isNotEmpty) {
      return "${locations.first}${locations.length > 1 ? ' + ${locations.length - 1} more' : ''}";
    } else {
      return service.postcode ?? service.basePostcode ?? service.baseLocationPostcode ?? "Location not specified";
    }
  }
}
