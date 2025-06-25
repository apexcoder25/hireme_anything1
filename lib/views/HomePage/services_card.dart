import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';
import 'package:hire_any_thing/views/Book_Service/book_service.dart';
import 'package:hire_any_thing/views/services_details/services_details.dart';

class ServiceCard extends StatelessWidget {
  final dynamic service;

  ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    double rating =
        service is VendorServiceModel ? service.rating?.toDouble() : 0.0;
    // : service is TutorHireService
    //     ? service.rating?.toDouble() ?? 0.0
    //     : service is AutomotiveHireService
    //         ? service.rating?.toDouble() ?? 0.0
    //         : 0.0;

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
                    offset: Offset(0, 3)),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image.network(
                      service is VendorServiceModel
                          ? (service.serviceImage.isNotEmpty
                              ? service.serviceImage[0]
                              : "https://hireanything.com/image/about.png")
                          : service is TutorHireService
                              ? service.profilePicture ??
                                  "https://hireanything.com/image/about.png"
                              : service is AutomotiveHireService
                                  ? (service.automotiveServiceImage.isNotEmpty
                                      ? service.automotiveServiceImage[0]
                                      : "https://hireanything.com/image/about.png")
                                  : "https://hireanything.com/image/about.png",
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service is VendorServiceModel
                            ? service.serviceName ?? "Unknown Service"
                            : service is TutorHireService
                                ? "Unknown Vendor"
                                : service is AutomotiveHireService
                                    ? "Unknown Service"
                                    : "Unknown Category",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: rating,
                            itemBuilder: (context, index) =>
                                Icon(Icons.star, color: Colors.amber),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(width: 5),
                          Text(
                            rating > 0 ? rating.toStringAsFixed(1) : "N/A",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        service is VendorServiceModel
                            ? service.categoryId?.categoryName ??
                                "Unknown Category"
                            : service is TutorHireService
                                ? service.categoryId?.categoryName ??
                                    "Unknown Category"
                                : service is AutomotiveHireService
                                    ? service.categoryId?.categoryName ??
                                        "Unknown Category"
                                    : "Unknown Category",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      Text(
                        service is VendorServiceModel
                            ? service.subcategoryId?.subcategoryName ??
                                "Unknown Category"
                            : service is TutorHireService
                                ? service.subcategoryId?.subcategoryName ??
                                    "Unknown Category"
                                : service is AutomotiveHireService
                                    ? service.subcategoryId?.subcategoryName ??
                                        "Unknown Category"
                                    : "Unknown Category",
                        style: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange),
                            onPressed: () {
                              service is VendorServiceModel
                                  ? Get.to(() => BookServices(
                                     id: service.id ?? "",  
                                        categoryId: service.categoryId.id,
                                        subcategoryId: service.subcategoryId.id,
                                        fromDate: service.bookingDateFrom,
                                        todate: service.bookingDateTo,
                                        capacity: service.noOfSeats.toString(),
                                        minDistance: service.minimumDistance,
                                        maxDistsnce: service.maximumDistance,
                                        ServiceCities:
                                            service.cityName.toString(),
                                      ))
                                  : service is TutorHireService
                                      ? Get.to(() => BookServices(
                                            categoryId: service.categoryId.id,
                                            subcategoryId:
                                                service.subcategoryId.id,
                                          ))
                                      : service is AutomotiveHireService
                                          ? Get.to(() => BookServices(
                                                categoryId:
                                                    service.categoryId.id,
                                                subcategoryId:
                                                    service.subcategoryId.id,
                                              ))
                                          : Get.snackbar("Invalid Route",
                                              "No Route Found");
                            },
                            icon: Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Book Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.info_outline),
                           onPressed: () {
  if (service is VendorServiceModel) {
    if (service.categoryId != null && service.subcategoryId != null) {
      Get.to(() => ServicesDetails(
        categoryId: service.categoryId!.id,
        subcategoryId: service.subcategoryId!.id,
        categoryName: service.categoryId!.categoryName,
        subcategoryName: service.subcategoryId!.subcategoryName,
        cityNames: service.cityName.toString(),
        kmPrice: service.kilometerPrice.toString(),
        description: service.description,
        bookingDateFrom: service.bookingDateFrom,
        bookingDateTo: service.bookingDateTo,
        serviceName: service.serviceName,
        minDistance: service.minimumDistance,
        makeAndModel: service.makeAndModel,
        maxDistance: service.maximumDistance,
        airon_fitted: service.aironFitted,
        wheelChair: service.wheelChair,
        noOfSeats: service.noOfSeats,
        registration: service.registrationNo,
        serviceImage: service.serviceImage.isNotEmpty ? service.serviceImage[0] : "",
        service: service,
      ));
    } else {
      Get.snackbar("Error", "Category or Subcategory is missing");
    }
  } else if (service is TutorHireService) {
    if (service.categoryId != null && service.subcategoryId != null) {
      Get.to(() => BookServices(
        categoryId: service.categoryId!.id,
        subcategoryId: service.subcategoryId!.id,
      ));
    } else {
      Get.snackbar("Error", "Category or Subcategory is missing");
    }
  } else if (service is AutomotiveHireService) {
    if (service.categoryId != null && service.subcategoryId != null) {
      Get.to(() => BookServices(
        categoryId: service.categoryId!.id,
        subcategoryId: service.subcategoryId!.id,
      ));
    } else {
      Get.snackbar("Error", "Category or Subcategory is missing");
    }
  } else {
    Get.snackbar("Invalid Route", "No Route Found");
  }
},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
