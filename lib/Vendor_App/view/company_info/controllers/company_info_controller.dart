import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/models/company_info_model.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';


class CompanyInfoController extends GetxController with GetSingleTickerProviderStateMixin {
  final ApiServiceVenderSide apiService = ApiServiceVenderSide();
  
  final isLoading = false.obs;
  final isEditing = false.obs;
  final hasCompanyInfo = false.obs;
  
  Rx<CompanyInfoModel?> companyInfo = Rx<CompanyInfoModel?>(null);
  
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  
  // Form controllers
  final companyNameController = TextEditingController();
  final tradingNameController = TextEditingController();
  final companyRegNoController = TextEditingController();
  final addressController = TextEditingController();
  final postcodeController = TextEditingController();
  final contactNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _initializeAnimation();
    fetchCompanyInfo();
  }

  void _initializeAnimation() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    
    animationController.forward();
  }

  Future<void> fetchCompanyInfo() async {
    try {
      isLoading.value = true;
      
      final vendorId = await SessionVendorSideManager().getVendorId();
      if (vendorId == null || vendorId.isEmpty) {
        throw Exception('Vendor ID not found');
      }

      final token = await SessionVendorSideManager().getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found');
      }

      print('Fetching company info for vendor: $vendorId');
      
      final response = await apiService.getCompanyInfo(token);
      
      print('Company info response: $response');

      if (response['success'] == true && response['companyData'] != null) {
        companyInfo.value = CompanyInfoModel.fromJson(response['companyData']);
        hasCompanyInfo.value = true;
        _populateControllers();
      } else {
        hasCompanyInfo.value = false;
        isEditing.value = true; // Auto-enable edit mode for new entry
      }
    } catch (e) {
      print('Error fetching company info: $e');
      hasCompanyInfo.value = false;
      isEditing.value = true; // Auto-enable edit mode on error (likely no data)
      
      if (e.toString().contains('404')) {
        // No company info exists yet
        print('No company info found - ready to create new');
      } else {
        Get.snackbar(
          'Error',
          'Failed to load company information',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _populateControllers() {
    final info = companyInfo.value;
    if (info != null) {
      companyNameController.text = info.companyName;
      tradingNameController.text = info.tradingName;
      companyRegNoController.text = info.companyRegNo;
      addressController.text = info.address;
      postcodeController.text = info.postcode;
      contactNameController.text = info.contactName;
      phoneController.text = info.phone;
      emailController.text = info.email;
    }
  }

  void toggleEditMode() {
    if (isEditing.value) {
      // Cancel editing - restore original values
      _populateControllers();
    }
    isEditing.value = !isEditing.value;
  }

  Future<void> saveCompanyInfo() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      final token = await SessionVendorSideManager().getToken();
      if (token == null || token.isEmpty) {
        throw Exception('Authentication token not found');
      }

      final payload = {
        'companyName': companyNameController.text.trim(),
        'tradingName': tradingNameController.text.trim(),
        'companyRegNo': companyRegNoController.text.trim(),
        'address': addressController.text.trim(),
        'postcode': postcodeController.text.trim(),
        'contactName': contactNameController.text.trim(),
        'phone': phoneController.text.trim(),
        'email': emailController.text.trim(),
      };

      print('Saving company info: $payload');
      print('Has existing company info: ${hasCompanyInfo.value}');

      final response = hasCompanyInfo.value
          ? await apiService.updateCompanyInfo(token, payload)
          : await apiService.saveCompanyInfo(token, payload);

      print('Company info response: $response');

      if (response['success'] == true) {
        Get.snackbar(
          'Success',
          response['message'] ?? 'Company information saved successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        isEditing.value = false;
        await fetchCompanyInfo(); // Refresh data
      } else {
        throw Exception(response['message'] ?? 'Failed to save company information');
      }
    } catch (e) {
      print('Error saving company info: $e');
      Get.snackbar(
        'Error',
        'Failed to save company information: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    animationController.dispose();
    companyNameController.dispose();
    tradingNameController.dispose();
    companyRegNoController.dispose();
    addressController.dispose();
    postcodeController.dispose();
    contactNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
