// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
// import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coupanController.dart';
// import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
// import 'package:hire_any_thing/constants_file/uk_cities.dart';
// import 'package:hire_any_thing/utilities/colors.dart';
// import '../models/service_image.dart';

// class BoatHireController extends GetxController {
//   // Observable states
//   var currentStep = 1.obs;
//   var isLoading = false.obs;
//   var isNavigating = false.obs;
//   var completedSteps = <int>{}.obs;
  
//   // Form key
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
//   // Text controllers
//   final TextEditingController listingTitleController = TextEditingController();
//   final TextEditingController boatTypeController = TextEditingController();
//   final TextEditingController makeModelController = TextEditingController();
//   final TextEditingController numberOfSeatsController = TextEditingController();
//   final TextEditingController luggageCapacityController = TextEditingController();
//   final TextEditingController serviceCoverageController = TextEditingController();
//   final TextEditingController serviceRadiusController = TextEditingController();
//   final TextEditingController hourlyRateController = TextEditingController();
//   final TextEditingController perMileRateController = TextEditingController();
//   final TextEditingController tenHourDayRateController = TextEditingController();
//   final TextEditingController halfDayRateController = TextEditingController();
//   final TextEditingController searchCitiesController = TextEditingController();
  
//   // Observable selections
//   var selectedHireType = 'Skippered Only'.obs;
//   var selectedDeparturePoint = 'London Bridge City Pier'.obs;
//   var firstRegistrationDate = DateTime.now().obs;
  
//   // Areas management
//   RxList<String> selectedAreas = <String>[].obs;
//   RxList<String> filteredCities = <String>[].obs;
  
//   // Features
//   var features = {
//     'leatherInterior': false,
//     'wifiAccess': false,
//     'airConditioning': false,
//     'complimentaryDrinks': false,
//     'onboardEntertainment': false,
//     'bluetoothUsb': false,
//     'redCarpetService': false,
//     'onboardRestroom': false,
//   }.obs;
  
//   // Images
//   RxList<ServiceImage> serviceImages = <ServiceImage>[].obs;
  
//   // Terms
//   var isAccurateInfo = false.obs;
//   var noContactDetailsShared = false.obs;
//   var agreeCookiesPolicy = false.obs;
//   var agreePrivacyPolicy = false.obs;
//   var agreeCancellationPolicy = false.obs;
  
//   // Static data
//   final List<String> hireTypes = ['Skippered Only'];
//   final List<String> departurePoints = [
//     'London Bridge City Pier',
//     'Westminster Pier',
//     'Greenwich Pier',
//     'Tower Bridge Pier',
//     'Canary Wharf Pier'
//   ];
  
//   // Service controllers
//   final ImageController imageController = Get.put(ImageController());
//   final CouponController couponController = Get.put(CouponController());
//   final CalendarController calenderController = Get.put(CalendarController());

//   @override
//   void onInit() {
//     super.onInit();
//     _initializeData();
//     _setupListeners();
//   }

//   void _initializeData() {
//     filteredCities.value = Cities.ukCities;
//   }

//   void _setupListeners() {
//     searchCitiesController.addListener(_filterCities);
//   }

//   void _filterCities() {
//     final query = searchCitiesController.text.toLowerCase();
//     if (query.isEmpty) {
//       filteredCities.value = Cities.ukCities;
//     } else {
//       filteredCities.value = Cities.ukCities
//           .where((city) => city.toLowerCase().contains(query))
//           .toList();
//     }
//   }

//   // Navigation methods
//   Future<void> nextStep() async {
//     if (currentStep.value < 10) {
//       if (await _validateCurrentStep()) {
//         isNavigating.value = true;
//         await Future.delayed(const Duration(milliseconds: 200));
        
//         completedSteps.add(currentStep.value);
//         currentStep.value++;
        
//         isNavigating.value = false;
//         _showStepCompletedFeedback();
//       }
//     }
//   }

//   Future<void> previousStep() async {
//     if (currentStep.value > 1) {
//       isNavigating.value = true;
//       await Future.delayed(const Duration(milliseconds: 150));
//       currentStep.value--;
//       isNavigating.value = false;
//     }
//   }

//   void _showStepCompletedFeedback() {
//     HapticFeedback.selectionClick();
//   }

//   // Validation methods
//   Future<bool> _validateCurrentStep() async {
//     switch (currentStep.value) {
//       case 2: return await _validateStep2();
//       case 3: return await _validateStep3();
//       case 4: return await _validateStep4();
//       case 5: return await _validateStep5();
//       case 6: return await _validateStep6();
//       case 10: return await _validateStep10();
//       default: return true;
//     }
//   }

//   Future<bool> _validateStep2() async {
//     if (listingTitleController.text.trim().isEmpty) {
//       _showError('Please enter a listing title');
//       return false;
//     }
//     if (listingTitleController.text.trim().length < 10) {
//       _showError('Title must be at least 10 characters');
//       return false;
//     }
//     if (boatTypeController.text.trim().isEmpty) {
//       _showError('Please enter boat type');
//       return false;
//     }
//     return true;
//   }

//   Future<bool> _validateStep3() async {
//     if (makeModelController.text.trim().isEmpty ||
//         numberOfSeatsController.text.trim().isEmpty ||
//         luggageCapacityController.text.trim().isEmpty) {
//       _showError('All vehicle information fields are required');
//       return false;
//     }
    
//     final seats = int.tryParse(numberOfSeatsController.text.trim()) ?? 0;
//     if (seats < 1 || seats > 50) {
//       _showError('Number of seats must be between 1 and 50');
//       return false;
//     }
    
//     return true;
//   }

//   Future<bool> _validateStep4() async {
//     if (serviceCoverageController.text.trim().isEmpty) {
//       _showError('Please enter service coverage area');
//       return false;
//     }
//     if (selectedAreas.isEmpty) {
//       _showError('Please select at least one coverage area');
//       return false;
//     }
//     return true;
//   }

//   Future<bool> _validateStep5() async {
//     final hourlyRate = double.tryParse(hourlyRateController.text.trim()) ?? 0;
//     final tenHourRate = double.tryParse(tenHourDayRateController.text.trim()) ?? 0;
//     final halfDayRate = double.tryParse(halfDayRateController.text.trim()) ?? 0;
    
//     if (hourlyRate == 0 && tenHourRate == 0 && halfDayRate == 0) {
//       _showError('At least one pricing field is required');
//       return false;
//     }
    
//     if (hourlyRate > 0 && hourlyRate < 10) {
//       _showError('Hourly rate seems too low. Please check the amount.');
//       return false;
//     }
    
//     return true;
//   }

//   Future<bool> _validateStep6() async {
//     if (serviceImages.length < 3) {
//       _showError('Minimum 3 high-quality images are required');
//       return false;
//     }
//     return true;
//   }

//   Future<bool> _validateStep10() async {
//     if (!isAccurateInfo.value ||
//         !noContactDetailsShared.value ||
//         !agreeCookiesPolicy.value ||
//         !agreePrivacyPolicy.value ||
//         !agreeCancellationPolicy.value) {
//       _showError('Please agree to all terms and conditions to continue');
//       return false;
//     }
//     return true;
//   }

//   void _showError(String message) {
//     Get.snackbar(
//       'Validation Error',
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.error,
//       colorText: AppColors.white,
//       icon: const Icon(Icons.error_outline, color: AppColors.white),
//       duration: const Duration(seconds: 4),
//       margin: const EdgeInsets.all(16),
//       borderRadius: 8,
//     );
//     HapticFeedback.lightImpact();
//   }

//   // Form submission
//   Future<void> submitForm() async {
//     if (!await _validateStep10()) return;
    
//     isLoading.value = true;
//     try {
//       _showSubmissionProgress();
//       await _simulateSubmission();
//       Get.back(); // Close progress dialog
//       _showSubmissionSuccess();
//       await Future.delayed(const Duration(seconds: 2));
//       Get.back();
//     } catch (e) {
//       Get.back(); // Close progress dialog
//       _showSubmissionError(e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> _simulateSubmission() async {
//     await Future.delayed(const Duration(seconds: 2));
//   }

//   void _showSubmissionProgress() {
//     Get.dialog(
//       WillPopScope(
//         onWillPop: () async => false,
//         child: AlertDialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 16),
//               const CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Submitting Your Service',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'Please wait while we process your boat hire service...',
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: AppColors.grey600,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     );
//   }

//   void _showSubmissionSuccess() {
//     Get.snackbar(
//       'Success!',
//       'Your boat hire service has been submitted successfully! Our team will review it and publish within 24 hours.',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.success,
//       colorText: AppColors.white,
//       icon: const Icon(Icons.check_circle, color: AppColors.white),
//       duration: const Duration(seconds: 5),
//       margin: const EdgeInsets.all(16),
//       borderRadius: 8,
//     );
//     HapticFeedback.heavyImpact();
//   }

//   void _showSubmissionError(String error) {
//     Get.snackbar(
//       'Submission Failed',
//       'Failed to submit your service. Please try again.\nError: $error',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.error,
//       colorText: AppColors.white,
//       icon: const Icon(Icons.error, color: AppColors.white),
//       duration: const Duration(seconds: 6),
//       margin: const EdgeInsets.all(16),
//       borderRadius: 8,
//     );
//     HapticFeedback.heavyImpact();
//   }

//   // Area management
//   void selectAllAreas() {
//     selectedAreas.clear();
//     selectedAreas.addAll(filteredCities.isNotEmpty ? filteredCities : Cities.ukCities);
//   }

//   void clearAllAreas() {
//     selectedAreas.clear();
//   }

//   void toggleArea(String area) {
//     if (selectedAreas.contains(area)) {
//       selectedAreas.remove(area);
//     } else {
//       selectedAreas.add(area);
//     }
//   }

//   // Image management
//   Future<void> addServiceImage(String imagePath) async {
//     if (serviceImages.length >= 10) {
//       _showError('Maximum 10 images allowed');
//       return;
//     }
    
//     serviceImages.add(ServiceImage(
//       path: imagePath,
//       uploadTime: DateTime.now(),
//       isUploaded: false,
//     ));
//   }

//   void removeServiceImage(int index) {
//     if (index < serviceImages.length) {
//       serviceImages.removeAt(index);
//     }
//   }

//   // Progress calculation
//   double get progressPercentage => currentStep.value / 10;
//   String get progressText => '${(progressPercentage * 100).toInt()}% Complete';

//   // Step titles
//   String getStepTitle(int step) {
//     final titles = [
//       'Service Overview',
//       'Listing Details',
//       'Vehicle Information',
//       'Coverage Areas',
//       'Pricing Details',
//       'Photos & Media',
//       'Features & Services',
//       'Calendar & Availability',
//       'Coupons & Discounts',
//       'Terms & Submit'
//     ];
//     return titles[step - 1];
//   }

//   @override
//   void onClose() {
//     // Dispose controllers
//     listingTitleController.dispose();
//     boatTypeController.dispose();
//     makeModelController.dispose();
//     numberOfSeatsController.dispose();
//     luggageCapacityController.dispose();
//     serviceCoverageController.dispose();
//     serviceRadiusController.dispose();
//     hourlyRateController.dispose();
//     perMileRateController.dispose();
//     tenHourDayRateController.dispose();
//     halfDayRateController.dispose();
//     searchCitiesController.dispose();
    
//     super.onClose();
//   }
// }
