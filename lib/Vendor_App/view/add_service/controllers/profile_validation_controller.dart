import 'package:get/get.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class ProfileValidationController extends GetxController {
  final ApiServiceVenderSide _apiService = ApiServiceVenderSide();
  
  final RxBool isLoading = true.obs;
  final RxBool hasCompanyInfo = false.obs;
  final RxBool hasBankDetails = false.obs;
  final RxString errorMessage = ''.obs;
  
  @override
  void onInit() {
    super.onInit();
    checkProfileCompletion();
  }
  
  Future<void> checkProfileCompletion() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      // Get vendor ID from session
      final vendorId = await SessionVendorSideManager().getVendorId();
      
      if (vendorId == null || vendorId.isEmpty) {
        errorMessage.value = 'Vendor ID not found. Please login again.';
        isLoading.value = false;
        return;
      }
      
      // Check company info
      await _checkCompanyInfo();
      
      // Check bank details
      await _checkBankDetails(vendorId);
      
    } catch (e) {
      errorMessage.value = 'Failed to check profile status: ${e.toString()}';
      print('Error checking profile completion: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> _checkCompanyInfo() async {
    try {
      final token = await SessionVendorSideManager().getToken();
      if (token == null || token.isEmpty) {
        hasCompanyInfo.value = false;
        return;
      }

      final response = await _apiService.getCompanyInfo(token);
      
      if (response != null && response['success'] == true) {
        final companyData = response['companyData'];
        
        // Check if company data exists and has required fields
        hasCompanyInfo.value = companyData != null && 
                               companyData is Map && 
                               companyData.isNotEmpty &&
                               companyData['companyName'] != null &&
                               companyData['companyName'].toString().trim().isNotEmpty;
        
        print('Company info check result: ${hasCompanyInfo.value}');
        print('Company data: $companyData');
      } else {
        hasCompanyInfo.value = false;
      }
    } catch (e) {
      print('Error checking company info: $e');
      // If 404, it means no company info exists yet
      if (e.toString().contains('404')) {
        hasCompanyInfo.value = false;
      } else {
        hasCompanyInfo.value = false;
      }
    }
  }
  
  Future<void> _checkBankDetails(String vendorId) async {
    try {
      final response = await _apiService.getApi('check-bank-details/$vendorId');
      
      if (response != null) {
        // Check if hasAccountDetails is true or result is "true"
        hasBankDetails.value = (response['hasAccountDetails'] == true) || 
                              (response['result'] == 'true');
      } else {
        hasBankDetails.value = false;
      }
    } catch (e) {
      print('Error checking bank details: $e');
      hasBankDetails.value = false;
    }
  }
  
  bool get isProfileComplete => hasCompanyInfo.value && hasBankDetails.value;
  bool get needsCompanyInfo => !hasCompanyInfo.value;
  bool get needsBankDetails => !hasBankDetails.value;
  
  void retryCheck() {
    checkProfileCompletion();
  }
}
