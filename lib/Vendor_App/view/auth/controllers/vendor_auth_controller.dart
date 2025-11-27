import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';

class VendorAuthController extends GetxController {
  final ImageController imageController = Get.put(ImageController());

  // Observable variables
  var currentStep = 1.obs;
  var isLoading = false.obs;
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

  // Text controllers
  final emailController = TextEditingController();
  final emailOtpController = TextEditingController();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final phoneOtpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Phone data
  String? phoneNumber;
  String? countryCode;

  // Password validation
  final RegExp passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
  var passwordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
  }

  @override
  void onClose() {
    // Dispose controllers
    emailController.dispose();
    emailOtpController.dispose();
    nameController.dispose();
    mobileController.dispose();
    phoneOtpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Validation methods
  bool validateEmail(String email) {
    return GetUtils.isEmail(email);
  }

  bool validatePhone(String phone) {
    return phone.isNotEmpty && phone.length >= 10;
  }

  bool validatePassword(String password) {
    if (!passwordRegex.hasMatch(password)) {
      passwordError.value = 
          'Password must be at least 8 characters, include uppercase, lowercase, number, and special character';
      return false;
    }
    passwordError.value = '';
    return true;
  }

  bool validateOTP(String otp) {
    return otp.isNotEmpty && otp.length >= 4;
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  // Step navigation
  void nextStep() {
    if (currentStep.value < 5) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 1) {
      currentStep.value--;
    }
  }

  void resetRegistration() {
    currentStep.value = 1;
    emailController.clear();
    emailOtpController.clear();
    nameController.clear();
    mobileController.clear();
    phoneOtpController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneNumber = null;
    countryCode = null;
    passwordError.value = '';
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
  }

  // Registration steps methods
  Future<bool> checkEmailAvailability() async {
    try {
      isLoading.value = true;
      if (!validateEmail(emailController.text.trim())) {
        Get.snackbar(
          'Error',
          'Please enter a valid email address',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      final isEmailValid = await apiServiceVenderSide
          .checkEmail(emailController.text.trim());
      
      if (isEmailValid) {
        final isEmailOtpSent = await apiServiceVenderSide
            .sendOtpEmail(emailController.text.trim());
        if (isEmailOtpSent) {
          nextStep();
          Get.snackbar(
            'Success',
            'OTP sent to your email',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          return true;
        }
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to check email availability',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyEmailOTP() async {
    try {
      isLoading.value = true;
      if (!validateOTP(emailOtpController.text.trim())) {
        Get.snackbar(
          'Error',
          'Please enter a valid OTP',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      final isEmailOtpValid = await apiServiceVenderSide.verifyOtpEmail(
        emailController.text.trim(),
        emailOtpController.text.trim(),
      );

      if (isEmailOtpValid) {
        nextStep();
        Get.snackbar(
          'Success',
          'Email verified successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to verify email OTP',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> sendPhoneOTP() async {
    try {
      isLoading.value = true;
      if (nameController.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter your name',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      if (phoneNumber == null || countryCode == null) {
        Get.snackbar(
          'Error',
          'Please enter a valid phone number',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      final isPhoneOtpSent = await apiServiceVenderSide
          .sendOtpPhone(phoneNumber!, countryCode!);
      
      if (isPhoneOtpSent) {
        nextStep();
        Get.snackbar(
          'Success',
          'OTP sent to your phone',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to send phone OTP',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> verifyPhoneOTP() async {
    try {
      isLoading.value = true;
      if (!validateOTP(phoneOtpController.text.trim())) {
        Get.snackbar(
          'Error',
          'Please enter a valid OTP',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      final isPhoneOtpValid = await apiServiceVenderSide.verifyOtpPhone(
        phoneNumber!,
        countryCode!,
        phoneOtpController.text.trim(),
      );

      if (isPhoneOtpValid) {
        nextStep();
        Get.snackbar(
          'Success',
          'Phone verified successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to verify phone OTP',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> completeRegistration() async {
    try {
      isLoading.value = true;
      
      // Validate all required fields
      if (passwordController.text.trim().isEmpty ||
          confirmPasswordController.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Please fill all required fields',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      final password = passwordController.text.trim();
      final confirmPassword = confirmPasswordController.text.trim();

      if (!validatePassword(password)) {
        Get.snackbar(
          'Error',
          'Invalid password format',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      if (password != confirmPassword) {
        Get.snackbar(
          'Error',
          'Passwords do not match',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }


      final data = {
        "email": emailController.text.trim(),
        "name": nameController.text.trim(),
        "mobile_no": phoneNumber,
        "country_code": countryCode,
        "password": password,
        "confirmPassword": confirmPassword,
        "otp": emailOtpController.text.trim(),
      };

      final isRegistered = await apiServiceVenderSide.vendorRegisterUser(data);
      
      if (isRegistered) {
        Get.snackbar(
          'Success',
          'Registration completed successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(VendorRoutesName.loginVendorView);
        return true;
      }
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to complete registration',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      // print("dsfdfd $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Login method
  Future<bool> vendorLogin() async {
    try {
      isLoading.value = true;
      
      if (emailController.text.trim().isEmpty || 
          passwordController.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Email and password are required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      final isLoggedIn = await apiServiceVenderSide.vendorLogin({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      if (isLoggedIn) {
        Get.snackbar(
          'Success',
          'Partner logged in successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(VendorRoutesName.mainDashboard);
        return true;
      }
      
      Get.snackbar(
        'Error',
        'Invalid login credentials',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
