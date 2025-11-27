import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/models/account_deatils_model.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class AccountsAndManagementController extends GetxController with GetSingleTickerProviderStateMixin {
  final accountNumberController = TextEditingController();
  final bankNameController = TextEditingController();
  final sortCodeController = TextEditingController();
  final ibanNumberController = TextEditingController();
  final accountHolderNameController = TextEditingController();
  final swiftCodeController = TextEditingController();
  final paypalIdController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var hasAccountDetails = false.obs;
  var isEditing = false.obs;
  var accountDetails = Rxn<AccountDetailsModel>();
  var vendorId = "".obs;
  var selectedTab = 0.obs; 
  var isAnimationInitialized = false.obs;

  final SessionVendorSideManager sessionManager = SessionVendorSideManager();
  final ApiServiceVenderSide apiService = ApiServiceVenderSide();

  late AnimationController animationController;
  late Animation<double> slideAnimation;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    fetchVendorId();
    fetchAccountDetails();
  }

  void _initializeAnimations() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    slideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOutCubic,
    ));

    animationController.forward();
    isAnimationInitialized.value = true;
  }

  @override
  void onClose() {
    if (isAnimationInitialized.value) {
      animationController.dispose();
    }
    accountNumberController.dispose();
    bankNameController.dispose();
    sortCodeController.dispose();
    ibanNumberController.dispose();
    accountHolderNameController.dispose();
    swiftCodeController.dispose();
    paypalIdController.dispose();
    super.onClose();
  }

  Future<void> fetchVendorId() async {
    String? id = await sessionManager.getVendorId();
    if (id != null) {
      vendorId.value = id;
      print("Vendor ID fetched: $id");
    } else {
      vendorId.value = "Unable to fetch Vendor ID";
      print("Failed to fetch Vendor ID");
    }
  }

  bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;
      final payload = jsonDecode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final exp = payload['exp'] as int?;
      if (exp == null) return true;
      final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return expirationDate.isBefore(DateTime.now());
    } catch (e) {
      print("Error decoding token: $e");
      return true;
    }
  }

  Future<void> fetchAccountDetails() async {
    isLoading.value = true;

    try {
      String? token = await sessionManager.getToken();
      if (token == null || vendorId.value.isEmpty) {
        _showErrorSnackbar("Unable to fetch authentication details");
        return;
      }

      if (isTokenExpired(token)) {
        _showErrorSnackbar("Session expired. Please log in again.");
        return;
      }

      apiService.setRequestHeaders({'Authorization': 'Bearer $token'});
      final response = await apiService.getApi('/${vendorId.value}/account');

      print("GET Response: $response");

      if (response != null) {
        try {
          final data = response is Map<String, dynamic> ? response : response['data'];
          print("Parsing data: $data");
          accountDetails.value = AccountDetailsModel.fromJson(data);
          hasAccountDetails.value = true;
          _populateControllers();
          print("Account details loaded successfully");
        } catch (parseError) {
          print("Error parsing account details: $parseError");
          hasAccountDetails.value = false;
          _clearControllers();
          _showErrorSnackbar("Error parsing account details");
        }
      } else {
        print("No response data received");
        hasAccountDetails.value = false;
        _clearControllers();
      }
    } on ApiException catch (e) {
      print("API Exception: ${e.message}");
      _showErrorSnackbar("Failed to fetch account details: ${e.message}");
    } catch (e) {
      print("Unexpected error: $e");
      _showErrorSnackbar("An error occurred while fetching account details");
    } finally {
      isLoading.value = false;
    }
  }

  void _populateControllers() {
    if (accountDetails.value != null) {
      accountNumberController.text = accountDetails.value!.accountNumber;
      bankNameController.text = accountDetails.value!.bankName;
      sortCodeController.text = accountDetails.value!.ifscCode;
      ibanNumberController.text = accountDetails.value!.ibanNumber;
      accountHolderNameController.text = accountDetails.value!.bankAccountHolderName;
      swiftCodeController.text = accountDetails.value!.swiftCode;
      paypalIdController.text = accountDetails.value!.paypalId;
    }
  }

  void _clearControllers() {
    accountNumberController.clear();
    bankNameController.clear();
    sortCodeController.clear();
    ibanNumberController.clear();
    accountHolderNameController.clear();
    swiftCodeController.clear();
    paypalIdController.clear();
  }

  bool validateForm() {
    if (selectedTab.value == 0) {
      // Bank validation
      if (accountNumberController.text.trim().isEmpty) {
        _showValidationError("Account Number is required");
        return false;
      }
      if (bankNameController.text.trim().isEmpty) {
        _showValidationError("Bank Name is required");
        return false;
      }
      if (sortCodeController.text.trim().isEmpty) {
        _showValidationError("Sort Code is required");
        return false;
      }
      if (ibanNumberController.text.trim().isEmpty) {
        _showValidationError("IBAN Number is required");
        return false;
      }
      if (accountHolderNameController.text.trim().isEmpty) {
        _showValidationError("Account Holder Name is required");
        return false;
      }
      if (swiftCodeController.text.trim().isEmpty) {
        _showValidationError("SWIFT Code is required");
        return false;
      }
    } else {
      // PayPal validation
      if (paypalIdController.text.trim().isEmpty) {
        _showValidationError("PayPal ID is required");
        return false;
      }
      if (!GetUtils.isEmail(paypalIdController.text.trim())) {
        _showValidationError("Please enter a valid PayPal email address");
        return false;
      }
    }
    return true;
  }

  void _showValidationError(String message) {
    Get.snackbar(
      "Validation Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      borderRadius: 12.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error_outline, color: Colors.white, size: 20),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      borderRadius: 12.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.error_outline, color: Colors.white, size: 20),
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.btnColor,
      colorText: Colors.white,
      borderRadius: 12.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
    );
  }

  Future<void> submitAccountDetails() async {
    if (!validateForm()) {
      return;
    }

    isLoading.value = true;
    bool isUpdateOperation = false;

    try {
      String? token = await sessionManager.getToken();
      if (token == null || vendorId.value.isEmpty) {
        _showErrorSnackbar("Unable to fetch authentication details");
        return;
      }

      if (isTokenExpired(token)) {
        _showErrorSnackbar("Session expired. Please log in again.");
        return;
      }

      final payload = {
        'accountNumber': accountNumberController.text.trim(),
        'bankName': bankNameController.text.trim(),
        'ifscCode': sortCodeController.text.trim(),
        'ibanNumber': ibanNumberController.text.trim(),
        'bankAccountHolderName': accountHolderNameController.text.trim(),
        'swiftCode': swiftCodeController.text.trim(),
        'paypalId': paypalIdController.text.trim(),
      };

      apiService.setRequestHeaders({'Authorization': 'Bearer $token'});
      isUpdateOperation = hasAccountDetails.value && isEditing.value;

      final responseData = isUpdateOperation
          ? await apiService.putApi('/${vendorId.value}/account', payload)
          : await apiService.postApi('/${vendorId.value}/account', payload);

      if (responseData != null) {
        Map<String, dynamic>? accountData;
        
        if (responseData is Map<String, dynamic>) {
          if (responseData.containsKey('error') && responseData['error'] == true) {
            throw Exception(responseData['message'] ?? 'Unknown error occurred');
          }
          if (responseData.containsKey('success') && responseData['success'] == false) {
            throw Exception(responseData['message'] ?? 'Operation failed');
          }
          
          accountData = responseData.containsKey('data') ? responseData['data'] : responseData;
        } else {
          accountData = responseData['data'];
        }

        if (accountData != null && accountData.isNotEmpty) {
          try {
            accountDetails.value = AccountDetailsModel.fromJson(accountData);
          } catch (modelError) {
            print("Error creating AccountDetailsModel: $modelError");
          }
        }

        hasAccountDetails.value = true;
        isEditing.value = false;

        String successMessage = isUpdateOperation
            ? "Account details updated successfully"
            : "Account details added successfully";

        _showSuccessSnackbar(successMessage);
      } else {
        throw Exception("No response received from server");
      }
    } on ApiException catch (e) {
      String errorMessage = isUpdateOperation
          ? "Failed to update account details"
          : "Failed to add account details";
      if (e.message.isNotEmpty) {
        errorMessage = e.message;
      }
      _showErrorSnackbar(errorMessage);
    } catch (e) {
      String errorMessage = "An error occurred while ${isUpdateOperation ? 'updating' : 'submitting'} account details";
      
      if (e.toString().contains('No response received') || 
          e.toString().contains('Unknown error occurred') ||
          e.toString().contains('Operation failed')) {
        errorMessage = e.toString();
      }
      
      _showErrorSnackbar(errorMessage);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleEditMode() {
    print("Toggle edit mode called. Current state: ${isEditing.value}");
    isEditing.value = !isEditing.value;
    print("New edit state: ${isEditing.value}");
    
    if (isEditing.value) {
      if (isAnimationInitialized.value) {
        animationController.reset();
        animationController.forward();
      }
      print("Edit mode enabled - form should show");
    } else {
      print("Edit mode disabled - view should show");
    }
  }

  void cancelEdit() {
    isEditing.value = false;
    _populateControllers(); // Reset to original values
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }
}
