import 'package:get/get.dart';
import 'package:hire_any_thing/constants_file/app_vendor_side_urls.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/models/vender_side_model/booking_payment_model.dart'; // Ensure this import is correct
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class BookingController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxList<Booking> bookings = <Booking>[].obs; // Revert to bookings
  final RxString errorMessage = ''.obs;
  final ApiServiceVenderSide _apiService = ApiServiceVenderSide();
  final SessionVendorSideManager _sessionManager = SessionVendorSideManager();
  final RxString selectedFilter = 'pending'.obs; // Match bookingServiceStatus

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      String? token = await _sessionManager.getToken();
      if (token == null || token.isEmpty) {
        errorMessage.value = 'Authentication token not found';
        isLoading.value = false;
        return;
      }

      _apiService.setRequestHeaders({'Authorization': 'Bearer $token'});
      final response = await _apiService.getApi(AppUrlsVendorSide.vendorBookingsUrl);

      final bookingModel = BookingPaymentModel.fromJson(response); // Use existing model
      bookings.assignAll(bookingModel.bookings);
    } on ApiException catch (e) {
      errorMessage.value = e.message ?? 'Failed to load bookings';
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  void refreshBookings() => fetchBookings();
}