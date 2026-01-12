// lib/User_app/views/services_details/controller/ServiceDetailsController.dart

import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:hire_any_thing/data/models/user_side_model/CoachServiceDetailModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/LimousineServiceDetailModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/ServiceRatingsModel.dart';
import 'package:hire_any_thing/data/models/user_side_model/horse_partners_details_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';

class ServiceDetailsController extends GetxController {
  final ApiServiceVenderSide _apiService = ApiServiceVenderSide();

  var isLoading = true.obs;
  var isLoadingRatings = true.obs;

  dynamic serviceDetail;
  ServiceRatings? ratings;

  String? serviceId;
  String? serviceType;

  Future<void> fetchServiceDetails(String id, String type) async {
    try {
      isLoading(true);
      String endpoint;

      switch (type.toLowerCase()) {
        case 'coach':
        case 'minibus':
          endpoint = '/$type/$id';
          break;
        case 'horse':
          endpoint = '/get-horse-partners/$id';
          break;
        case 'boat':
          endpoint = '/boat/$id';
          break;
        case 'limousine':
        case 'chauffeur':
          endpoint = '/get-limousine-partners/$id';
          break;
        default:
          endpoint = '/coach/$id';
      }

      print("Calling API: $endpoint");

      final response = await _apiService.getApi(endpoint);

      if (response != null && response is Map<String, dynamic>) {
        switch (type.toLowerCase()) {
          case 'limousine':
          case 'chauffeur':
            serviceDetail = LimousineServiceDetail.fromJson(response);
            break;
          case 'horse':
            serviceDetail = HorsePartnersDetails.fromJson(response);
            break;
          default:
            serviceDetail = CoachServiceDetail.fromJson(response);
        }
        print("Service loaded: ${serviceDetail?.listingTitle}");
      } else {
        Get.snackbar("Error", "Service not found");
      }
    } catch (e, s) {
      print("Error: $e\n$s");
      Get.snackbar("Error", "Failed to load service");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchRatings(String id) async {
    try {
      isLoadingRatings(true);
      final response = await _apiService.getApi('/rating/$id');
      if (response != null) {
        ratings = ServiceRatings.fromJson(response);
      }
    } catch (e) {
      print("Ratings error: $e");
    } finally {
      isLoadingRatings(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _extractArgs();
  }

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (serviceId == null || serviceId!.isEmpty || serviceType == null) {
        Get.snackbar("Error", "Invalid service");
        Get.back();
        return;
      }
      fetchServiceDetails(serviceId!, serviceType!);
      fetchRatings(serviceId!);
    });
  }

  void _extractArgs() {
    if (Get.arguments == null) return;
    if (Get.arguments is Map<String, dynamic>) {
      serviceId = Get.arguments['serviceId'];
      serviceType = Get.arguments['serviceType'] ?? 'coach';
    } else if (Get.arguments is String) {
      serviceId = Get.arguments;
      serviceType = 'coach';
    }
  }
}