import 'package:get/get.dart';
import 'package:hire_any_thing/data/models/user_side_model/allvendorServicesList.dart';
import 'package:hire_any_thing/User_app/views/Book_Service/controllers/service_fetch_id_controller.dart';

class YourServicesViewModel {
  final double distance;
  final String fromLocation; // Added
  final String toLocation;   // Added
  final VendorServiceController serviceController = Get.put(VendorServiceController());
  Rx<VendorServiceModel?> service = Rx<VendorServiceModel?>(null);
  RxString selectedCoupon = ''.obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble discountAmount = 0.0.obs;
  RxBool showCoupons = false.obs;
  RxBool isLoading = true.obs;
  final double vatPercentage = 0.20;

  YourServicesViewModel(String serviceId, this.distance, this.fromLocation, this.toLocation) {
    fetchService(serviceId);
  }

  void fetchService(String id) async {
    isLoading.value = true;
    if (serviceController.vendorServices.isEmpty) {
      await serviceController.fetchVendorServices();
    }

    service.value = serviceController.getServiceById(id);

    if (service.value == null) {
      service.value = await serviceController.fetchServiceById(id);
    }

    isLoading.value = false;
    if (service.value != null) {
      calculateTotal();
    }
  }

  void calculateTotal() {
    if (service.value == null) return;

    double basePricePerMile = service.value!.kilometerPrice.toDouble();
    double baseTotal = basePricePerMile * distance;

     discountAmount.value = 0.0;
    if (selectedCoupon.value.isNotEmpty) {
      final coupon = service.value!.coupons.firstWhere(
        (c) => c.couponCode == selectedCoupon.value,
        orElse: () => Coupon(
          couponCode: '',
          discountType: '',
          discountValue: 0,
          expiryDate: '',
          usageLimit: 0,
          currentUsageCount: 0,
          isGlobal: false,
          id: '',
        ),
      );
      if (coupon.couponCode.isNotEmpty && coupon.discountType == 'PERCENTAGE') {
        double discount = baseTotal * (coupon.discountValue / 100);
        discountAmount.value = discount;
        baseTotal -= discount;
      }
    }

    totalAmount.value = (basePricePerMile * distance + basePricePerMile * distance * vatPercentage) - discountAmount.value;
    print('Total calculated: ${totalAmount.value}');
  }

  bool isCouponExpired(DateTime expiryDate) {
    final now = DateTime.now();
    return expiryDate.isBefore(now);
  }

  void applyCoupon(String couponCode) {
    selectedCoupon.value = couponCode;
    calculateTotal();
  }

  void toggleCoupons() {
    showCoupons.value = !showCoupons.value;
  }
}