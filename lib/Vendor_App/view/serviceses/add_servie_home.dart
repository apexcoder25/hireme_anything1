import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/drawer.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/service_controller.dart';

class HomePageAddService extends StatefulWidget {
  @override
  State<HomePageAddService> createState() => _HomePageAddServiceState();
}

class _HomePageAddServiceState extends State<HomePageAddService> {
  final ServiceController controller = Get.put(ServiceController());

  Future<void> _refreshServices() async {
    controller.fetchServices();
    print("Fetched services: ${controller.serviceList.map((s) => s.category.categoryName).toList()}");

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

     
        var generalServices = controller.serviceList.where(
          (service) => service.category.categoryName != "Automotive Electricity",
        ).toList();

        var automotiveServices = controller.serviceList.where(
          (service) => service.category.categoryName == "Automotive Electricity",
        ).toList();

        return RefreshIndicator(
          onRefresh: _refreshServices,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            children: [
              if (generalServices.isNotEmpty)
                _buildServiceSection("General Services", generalServices),
              if (automotiveServices.isNotEmpty)
                _buildServiceSection("Automotive Electricity Services", automotiveServices, isAutomotive: true),
            ],
          ),
        );
      }),
    );
  }


  Widget _buildServiceSection(String title, List<dynamic> services, {bool isAutomotive = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
        SizedBox(height: 10),
        ...services.map((service) => _buildServiceCard(service, isAutomotive)).toList(),
      ],
    );
  }


  Widget _buildServiceCard(service, bool isAutomotive) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
              
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    service.serviceImage.isNotEmpty
                        ? service.serviceImage.first.trim()
                        : "https://example.com/default-image.jpg",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.broken_image, size: 90),
                  ),
                ),
                SizedBox(width: 15),

           
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service.serviceName,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5),

          
                      if (isAutomotive) ...[
                        Text(
                          "Experience: ${service.automotiveYearsOfExperience} years",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Skills: ${service.automotiveKeySkills.join(", ")}",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],

                      if (!isAutomotive) ...[
                        Text(
                          "€${service.kilometerPrice}/mile",
                          style: TextStyle(color: Colors.blue, fontSize: 14),
                        ),
                        SizedBox(height: 5),
                        Text(
                          service.cityName.join(", "),
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5),
                        Text(
                          "${service.noOfSeats} Seats",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),


          Positioned(
            top: 10,
            right: 10,
            child: Chip(
              label: Text(
                service.serviceApproveStatus == "0" ? "Pending" : "Accepted",
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: service.serviceApproveStatus == "0"
                  ? Colors.yellow.shade600
                  : Colors.green.shade400,
            ),
          ),

    
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
            
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
      
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
