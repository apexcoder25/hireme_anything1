import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/controller/delete_vendor_services_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/main_dashboard/controllers/vendor_dashboard_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/pricing_options_widget.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/service_feature_widget.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/home_page_widget.dart/vehicle_specifications_widget.dart';
import 'package:hire_any_thing/constants_file/app_vendor_side_urls.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';
import 'package:hire_any_thing/data/models/vender_side_model/vendor_home_page_services_model.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class HomePageAddService extends StatefulWidget {
  @override
  State<HomePageAddService> createState() => _HomePageAddServiceState();
}

class _HomePageAddServiceState extends State<HomePageAddService> {
  late final ServiceController controller;
  final AppUrlsVendorSide appUrlsVendorSide = AppUrlsVendorSide();

  @override
  void initState() {
    super.initState();
    try {
      controller = Get.find<ServiceController>();
      print("🔍 Found existing ServiceController");
    } catch (e) {
      controller = Get.put(ServiceController());
      print("🆕 Created new ServiceController");
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(Duration(milliseconds: 500));
      if (!controller.isLoading.value && controller.serviceList.isEmpty && !controller.hasError.value) {
        await controller.fetchServices();
      }
    });
  }

  Future<void> _refreshServices() async {
    await controller.fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey50,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text("Error: ${controller.errorMessage.value}"),
                const SizedBox(height: 16),
                ElevatedButton(onPressed: () => controller.refreshServices(), child: const Text("Retry")),
              ],
            ),
          );
        }

        if (controller.serviceList.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                    padding: const EdgeInsets.all(24),
                    child: const Icon(Icons.inventory_2_outlined, size: 48, color: AppColors.blue),
                  ),
                  const SizedBox(height: 24),
                  const Text("No Services Yet", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      "Start building your business by creating your first service. It only takes a few minutes to get started.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _refreshServices,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Refresh", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      try {
                        final dashboardController = Get.find<VendorDashboardController>();
                        dashboardController.changeTab(2);
                        Scaffold.of(context).openDrawer();
                      } catch (e) {
                        Get.toNamed(VendorRoutesName.vendorServicesScreen);
                      }
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text("Create Your First Service", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      backgroundColor: AppColors.btnColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Sort services by createdAt (most recent first)
        final sortedServices = controller.serviceList.toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        return RefreshIndicator(
          onRefresh: _refreshServices,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            itemCount: sortedServices.length,
            itemBuilder: (context, index) {
              final service = sortedServices[index];
              return _buildServiceCard(service);
            },
          ),
        );
      }),
    );
  }

  Widget _buildServiceCard(Service service) {
    // Determine service name
    String serviceName = "";
    if (service.listingTitle?.isNotEmpty == true) {
      serviceName = service.listingTitle!;
    } else if (service.serviceName?.isNotEmpty == true) {
      serviceName = service.serviceName!;
    } else if (service.venueName?.isNotEmpty == true) {
      serviceName = service.venueName!;
    } else {
      serviceName = "Untitled Service";
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 6, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    _resolveImageUrl(service),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey.shade300,
                        child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                      );
                    },
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.transparent, Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.7)],
                        stops: const [0.0, 0.5, 0.8, 1.0],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  left: 15,
                  right: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        serviceName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, shadows: [
                          Shadow(offset: Offset(1, 1), blurRadius: 3, color: Colors.black87),
                        ]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(6)),
                        child: Text(
                          service.subcategoryId?.subcategoryName ?? "General Service",
                          style: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
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
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed



: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        child: Text(_getPriceDisplay(service), style: const TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(width: 10),
                      Chip(
                        label: Text(
                          service.serviceApproveStatus == "0" || service.serviceApproveStatus == false ? "Pending" : "Approved",
                          style: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        backgroundColor: service.serviceApproveStatus == "0" || service.serviceApproveStatus == false ? Colors.orange : Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          _getLocationDisplay(service),
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  VehicleSpecificationsWidget(service: service),
                  const SizedBox(height: 15),
                  PricingOptionsWidget(service: service),
                  const SizedBox(height: 15),
                  ServiceFeaturesWidget(service: service),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (service.id.isEmpty) {
                            Get.snackbar("Error", "Service ID not found", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
                            return;
                          }
                          final deleteApi = DeleteVendorServiceApi();
                          bool shouldDelete = await deleteApi.showDeleteConfirmation(context, serviceName);
                          if (shouldDelete) {
                            bool deleted = await deleteApi.deleteVendorService(service.id);
                            if (deleted) await _refreshServices();
                          }
                        },
                        icon: const Icon(Icons.delete, size: 16),
                        label: const Text("Delete"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.red.shade50,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

  String _resolveImageUrl(Service service) {
    const String placeholder = "https://via.placeholder.com/400x200?text=No+Image";

    List<String>? images;

    // Try different possible image fields from real API
    if (service.service_image != null && service.service_image!.isNotEmpty) {
      images = service.service_image;
    } else if (service.serviceImage != null && service.serviceImage!.isNotEmpty) {
      images = service.serviceImage;
    } else if (service.serviceImages != null && service.serviceImages!.isNotEmpty) {
      images = service.serviceImages;
    }

    if (images == null || images.isEmpty) return placeholder;

    String url = images.first.trim();

    // Handle Cloudinary URLs with < > wrappers
    url = url.replaceAll("<", "").replaceAll(">", "").trim();

    if (url.startsWith("http")) return url;

    url = url.replaceAll("\\", "/");
    if (url.startsWith("/")) url = url.substring(1);

    return "${appUrlsVendorSide.baseUrlImages}$url";
  }

  String _getPriceDisplay(Service service) {
    // Simplified fallback - can be enhanced per type later
    return "Contact for price";
  }

  String _getLocationDisplay(Service service) {
    if (service.areasCovered?.isNotEmpty == true) {
      final first = service.areasCovered!.first;
      return service.areasCovered!.length > 1 ? "$first + ${service.areasCovered!.length - 1} more" : first;
    }
    return service.baseLocationPostcode ?? service.postcode ?? service.basePostcode ?? "Location not specified";
  }
}