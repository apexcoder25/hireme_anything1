import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/models/account_deatils_model.dart';
import 'package:hire_any_thing/data/exceptions/api_exception.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';


class AccountsAndManagementController extends GetxController {
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

  final SessionVendorSideManager sessionManager = SessionVendorSideManager();
  final ApiServiceVenderSide apiService = ApiServiceVenderSide();

  @override
  void onInit() {
    super.onInit();
    fetchVendorId();
    fetchAccountDetails();
  }

  @override
  void onClose() {
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
        Get.snackbar(
          "Error",
          "Unable to fetch token or vendor ID",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (isTokenExpired(token)) {
        Get.snackbar(
          "Error",
          "Session expired. Please log in again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return;
      }

      apiService.setRequestHeaders({'Authorization': 'Bearer $token'});
      final response = await apiService.getApi('/${vendorId.value}/account');

      print("GET Response: $response");

      if (response != null) {
        final data = response is Map<String, dynamic> ? response : response['data'];
        accountDetails.value = AccountDetailsModel.fromJson(data);
        hasAccountDetails.value = true;

        accountNumberController.text = accountDetails.value!.accountNumber;
        bankNameController.text = accountDetails.value!.bankName;
        sortCodeController.text = accountDetails.value!.ifscCode;
        ibanNumberController.text = accountDetails.value!.ibanNumber;
        accountHolderNameController.text = accountDetails.value!.bankAccountHolderName;
        swiftCodeController.text = accountDetails.value!.swiftCode;
        paypalIdController.text = accountDetails.value!.paypalId;
      } else {
        hasAccountDetails.value = false;
        accountNumberController.clear();
        bankNameController.clear();
        sortCodeController.clear();
        ibanNumberController.clear();
        accountHolderNameController.clear();
        swiftCodeController.clear();
        paypalIdController.clear();
      }
    } on ApiException catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch account details: ${e.message}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while fetching account details: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool validateForm() {
    if (accountNumberController.text.isEmpty) {
      showValidationError("Account Number is required");
      return false;
    }
    if (bankNameController.text.isEmpty) {
      showValidationError("Bank Name is required");
      return false;
    }
    if (sortCodeController.text.isEmpty) {
      showValidationError("Sort Code is required");
      return false;
    }
    if (ibanNumberController.text.isEmpty) {
      showValidationError("IBAN Number is required");
      return false;
    }
    if (accountHolderNameController.text.isEmpty) {
      showValidationError("Account Holder Name is required");
      return false;
    }
    if (swiftCodeController.text.isEmpty) {
      showValidationError("SWIFT Code is required");
      return false;
    }
    if (paypalIdController.text.isEmpty) {
      showValidationError("PayPal ID is required");
      return false;
    }
    return true;
  }

  void showValidationError(String message) {
    Get.snackbar(
      "Validation Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  Future<void> submitAccountDetails() async {
    if (!validateForm()) {
      return;
    }

    isLoading.value = true;

    // Declare isUpdateOperation here so it is accessible in try and catch blocks
    bool isUpdateOperation = false;

    try {
      String? token = await sessionManager.getToken();
      if (token == null || vendorId.value.isEmpty) {
        Get.snackbar(
          "Error",
          "Unable to fetch token or vendor ID",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return;
      }

      if (isTokenExpired(token)) {
        Get.snackbar(
          "Error",
          "Session expired. Please log in again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
        return;
      }

      final payload = {
        'accountNumber': accountNumberController.text,
        'bankName': bankNameController.text,
        'ifscCode': sortCodeController.text,
        'ibanNumber': ibanNumberController.text,
        'bankAccountHolderName': accountHolderNameController.text,
        'swiftCode': swiftCodeController.text,
        'paypalId': paypalIdController.text,
      };

      print("Submitting account details...");
      print("Vendor ID: ${vendorId.value}");
      print("Token: $token");
      print("Payload: $payload");

      apiService.setRequestHeaders({'Authorization': 'Bearer $token'});
   
      isUpdateOperation = hasAccountDetails.value && isEditing.value;

      final responseData = isUpdateOperation
          ? await apiService.putApi('/vendor/${vendorId.value}/account', payload)
          : await apiService.postApi('/vendor/${vendorId.value}/account', payload);

      print("Response: $responseData");

      if (responseData != null) {
        final accountData = responseData is Map<String, dynamic> ? responseData : responseData['data'];
        if (accountData != null) {
          accountDetails.value = AccountDetailsModel.fromJson(accountData);
        }

        hasAccountDetails.value = true;

        String successMessage = isUpdateOperation
            ? "Account details updated successfully"
            : "Account details added successfully";

        isEditing.value = false;
        Get.snackbar(
          "Success",
          successMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 5, 129, 69),
          colorText: Colors.white,
          borderRadius: 8.0,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        );
      }
    } on ApiException catch (e) {
      String errorMessage = isUpdateOperation
          ? "Failed to update account details"
          : "Failed to add account details. Please try again.";
      if (e.message != null && e.message!.isNotEmpty) {
        errorMessage = e.message!;
      }

      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred while submitting account details: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 8.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetForm() {
    isEditing.value = true;
  }
}