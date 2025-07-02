import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/user_bookings_api.dart';
import 'package:hire_any_thing/data/models/user_side_model/user_booking_model.dart';


class UserBookingController extends GetxController {
  final UserBookingApi _bookingApi = UserBookingApi();

  // Observable variables
  var bookings = <BookingDetails>[].obs;
  var isLoading = false.obs;
  var isCreating = false.obs;
  var isCancelling = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserBookings();
  }

 
  Future<void> fetchUserBookings() async {
    try {
      isLoading.value = true;
      final result = await _bookingApi.getUserBookings();
      print("API Response: $result");
      bookings.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  // Create a new booking
  // Future<bool> createBooking(Map<String, dynamic> bookingData) async {
  //   try {
  //     isCreating.value = true;
  //     final success = await _bookingApi.createBooking(bookingData);
  //     if (success) {
  //       await fetchUserBookings(); // Refresh bookings after creation
  //     }
  //     return success;
  //   } finally {
  //     isCreating.value = false;
  //   }
  // }


  Future<bool> cancelBooking(String bookingId) async {
    try {
      isCancelling.value = true;
      final success = await _bookingApi.cancelBooking(bookingId);
      if (success) {
        await fetchUserBookings(); 
      }
      return success;
    } finally {
      isCancelling.value = false;
    }
  }
}