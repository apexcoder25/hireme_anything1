// passenger_service_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/vendor_home_Page.dart';
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/city_fetch_controller.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class PassengerServiceViewModel extends GetxController {
  final vendorServiceModel = VendorServiceModel(
    categoryId: Category(id: "", categoryName: ""),
    subcategoryId: Subcategory(id: "", subcategoryName: ""),
    vendorId: Vendor(id: "", companyName: "", name: "", cityName: ""),
    kilometerPrice: 0,
    serviceImage: [],
    cityName: [],
    noOfSeats: 0,
    registrationNo: "",
    wheelChair: "",
    makeAndModel: "",
    toiletFacility: "",
    aironFitted: "",
    minimumDistance: "0",
    maximumDistance: "0",
    bookingTime: "",
    serviceStatus: "open",
    serviceApproveStatus: "",
    favouriteStatus: "",
    bookingDateFrom: "",
    bookingDateTo: "",
    numberOfService: "",
    rating: 0,
    noOfBooking: 0,
    offeringPrice: 0,
    specialPriceDays: [],
    oneDayPrice: 0,
    weeklyDiscount: 0,
    monthlyDiscount: 0,
    extraTimeWaitingCharge: 0,
    extraMilesCharges: 0,
    cancellationPolicyType: "FLEXIBLE",
    coupons: [],
    createdAt: "",
    updatedAt: "",
  ).obs;

  final formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final RxList<String> selectedCities = <String>[].obs;
  final RxBool isOneDayHire = false.obs;
  final RxBool isTnc = false.obs;
  final RxBool isContact = false.obs;
  final RxBool isCookies = false.obs;
  final RxBool isPvc = false.obs;

  // Controllers
  final CityFetchController cityFetchController = Get.put(CityFetchController());
  final ImageController imageController = Get.put(ImageController());
  final CouponController couponController = Get.put(CouponController());
  final CalendarController calendarController = Get.put(CalendarController());

  @override
  void onInit() {
    super.onInit();
    _loadVendorId();
    calendarController.setDefaultPrice(0.0);
  }

  Future<void> _loadVendorId() async {
    final vendorId = await SessionVendorSideManager().getVendorId();
    vendorServiceModel.update((val) {
      val!.vendorId = Vendor(id: vendorId ?? "", companyName: "", name: "", cityName: "");
    });
  }

  // Updated to accept nullable VendorServiceModel?
  void updateField<T>(T value, void Function(VendorServiceModel?) updater) {
    vendorServiceModel.update(updater);
  }

  void setSpecialPrice(DateTime date, int price) {
    calendarController.setSpecialPrice(date, price.toDouble());
    vendorServiceModel.update((val) {
      val!.specialPriceDays = [
        ...val.specialPriceDays,
        {"date": date.toIso8601String(), "price": price}
      ];
    });
  }

  void submitForm(String categoryId, String subCategoryId) async {
    if (!formKey.currentState!.validate() ||
        !isTnc.value ||
        !isContact.value ||
        !isCookies.value ||
        !isPvc.value ||
        selectedCities.isEmpty) {
      _showValidationError();
      return;
    }

    isLoading.value = true;
    vendorServiceModel.update((val) {
      val!.serviceImage = imageController.uploadedUrls;
      val.cityName = selectedCities;
      val.coupons = couponController.coupons.map((e) => Coupon.fromJson(e)).toList();
      val.specialPriceDays = calendarController.specialPrices
          .map((e) => {"date": (e['date'] as DateTime).toIso8601String(), "price": e['price']})
          .toList();
      val.categoryId = Category(id: categoryId, categoryName: "");
      val.subcategoryId = Subcategory(id: subCategoryId, subcategoryName: "");
      val.bookingDateFrom = calendarController.bookingDateFrom;
      val.bookingDateTo = calendarController.bookingDateTo;
    });

    final isAdded = await apiServiceVenderSide.addServiceVendor(vendorServiceModel.value.toJson());

    isLoading.value = false;
    if (isAdded) {
      Get.off(() => HomePageAddService());
    } else {
      Get.snackbar("Error", "Add Service Failed. Please try again.",
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  void _showValidationError() {
    if (vendorServiceModel.value.serviceName?.isEmpty ?? true) {
      Get.snackbar("Error", "Service Name is required", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    } else if (selectedCities.isEmpty) {
      Get.snackbar("Error", "Please select at least one city", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    } else if (vendorServiceModel.value.kilometerPrice == 0) {
      Get.snackbar("Error", "Price per mile is required", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    } else if (!isTnc.value || !isContact.value || !isCookies.value || !isPvc.value) {
      Get.snackbar("Error", "Please agree to all terms and policies", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.redAccent);
    }
  }

  @override
  void onClose() {
    cityFetchController.clearSearch();
    cityFetchController.placeList.clear();
    selectedCities.clear();
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
    couponController.coupons.clear();
    calendarController.specialPrices.clear();
    calendarController.visibleDates.clear();
    super.onClose();
  }
}