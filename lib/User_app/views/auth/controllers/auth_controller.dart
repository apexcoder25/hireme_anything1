import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hire_any_thing/User_app/views/main_dashboard/user_main_dashboard.dart';
import 'package:hire_any_thing/User_app/views/user_profle/controller/user_profile_controller.dart';
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find<AuthController>();
  late UserProfileController profileController;

  // Observable states
  final _isLoading = false.obs;
  final _isLogin = true.obs;
  final _registrationStep = 1.obs;
  final _obscurePassword = true.obs;
  final _obscureConfirmPassword = true.obs;
  final _rememberMe = false.obs;
  final _phoneNumber = Rxn<String>();
  final _countryCode = Rxn<String>();

  // Store registration data across steps
  final _registrationData = <String, dynamic>{}.obs;

  // Getters for observables
  bool get isLoading => _isLoading.value;
  bool get isLogin => _isLogin.value;
  int get registrationStep => _registrationStep.value;
  bool get obscurePassword => _obscurePassword.value;
  bool get obscureConfirmPassword => _obscureConfirmPassword.value;
  bool get rememberMe => _rememberMe.value;
  String? get phoneNumber => _phoneNumber.value;
  String? get countryCode => _countryCode.value;
  Map<String, dynamic> get registrationData => _registrationData;

  @override
  void onInit() {
    super.onInit();
    _initializeProfileController();
    print("AuthController initialized");
  }

  void _initializeProfileController() {
    try {
      profileController = Get.find<UserProfileController>();
      print("Found existing UserProfileController");
    } catch (e) {
      profileController = Get.put(UserProfileController());
      print("Created new UserProfileController");
    }
  }

  // Navigation methods
  void switchToLogin() {
    _isLogin.value = true;
    print("Switched to Login tab");
    update();
  }

  void switchToRegister() {
    _isLogin.value = false;
    _registrationStep.value = 1;
    _registrationData.clear(); // Clear previous registration data
    print("Switched to Register tab, reset to step 1");
    update();
  }

  void nextRegistrationStep() {
    if (_registrationStep.value < 5) {
      _registrationStep.value++;
      print("Registration step updated to: ${_registrationStep.value}");
      update(['registration_step']);
      update();
    }
  }

  void resetRegistrationStep() {
    _registrationStep.value = 1;
    _registrationData.clear();
    print("Registration step reset to 1");
    update(['registration_step']);
    update();
  }

  void previousRegistrationStep() {
    if (_registrationStep.value > 1) {
      _registrationStep.value--;
      print("Registration step moved back to: ${_registrationStep.value}");
      update(['registration_step']);
      update();
    }
  }

  // Utility methods
  void togglePasswordVisibility() {
    _obscurePassword.value = !_obscurePassword.value;
    update();
  }

  void toggleConfirmPasswordVisibility() {
    _obscureConfirmPassword.value = !_obscureConfirmPassword.value;
    update();
  }

  void toggleRememberMe() {
    _rememberMe.value = !_rememberMe.value;
    update();
  }

  void setPhoneData(String number, String code) {
    _phoneNumber.value = number;
    _countryCode.value = code;
    print("Phone data set: $code$number");
    update();
  }

  // Store registration data
  void storeRegistrationData(String key, dynamic value) {
    _registrationData[key] = value;
    print("Stored registration data: $key = $value");
  }

  // Error handling
  void showErrorSnackbar(String message) {
    print("Error: $message");
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.error,
      colorText: AppColors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.error_outline, color: AppColors.white),
    );
  }

  void showSuccessSnackbar(String message) {
    print("Success: $message");
    Get.snackbar(
      "Success",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: AppColors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 300),
      icon: const Icon(Icons.check_circle_outline, color: AppColors.white),
    );
  }

  // API methods
  Future<bool> performLogin(String email, String password) async {
    print("performLogin called with email: $email");

    if (email.trim().isEmpty || password.trim().isEmpty) {
      showErrorSnackbar("Email and password cannot be empty!");
      return false;
    }

    if (!GetUtils.isEmail(email.trim())) {
      showErrorSnackbar("Please enter a valid email address!");
      return false;
    }

    _isLoading.value = true;
    update();

    try {
      print("Attempting login...");
      final isRegistered = await apiServiceUserSide.userLogin({
        "email": email.trim(),
        "password": password.trim(),
      });

      if (isRegistered) {
        print("Login successful, refreshing profile...");
        await profileController.refreshToken();
        await profileController.fetchProfile();

        if (profileController.isLogin.value) {
          print("Profile loaded, navigating to home...");
          showSuccessSnackbar("Login successful!");
          // Get.offAllNamed(UserRoutesName.homeUserView);
          Get.offAll(() => UserMainDashboard());
          return true;
        } else {
          showErrorSnackbar("Failed to load user profile. Please try again.");
        }
      } else {
        showErrorSnackbar(
            "Invalid credentials. Please check your email and password.");
      }
    } catch (e) {
      print("Login error: $e");
      showErrorSnackbar(
          "Login failed. Please check your connection and try again.");
    } finally {
      _isLoading.value = false;
      update();
    }

    return false;
  }

  Future<bool> performRegistrationStep(
      int step, Map<String, String> formData) async {
    print("performRegistrationStep called - Step: $step");
    print("Form data received: $formData");
    print("Stored registration data: $_registrationData");

    _isLoading.value = true;
    update();

    try {
      switch (step) {
        case 1:
          print("Processing step 1 - Personal Information");

          // Validate form data

          if (!GetUtils.isEmail(formData['email']!.trim())) {
            showErrorSnackbar("Please enter a valid email address");
            return false;
          }

          // Store data for later use
          storeRegistrationData('firstName', formData['firstName']!.trim());
          storeRegistrationData('lastName', formData['lastName']!.trim());
          storeRegistrationData('email', formData['email']!.trim());

          print("Checking email availability...");
          final isEmailValid =
              await apiServiceVenderSide.checkEmail(formData['email']!.trim());

          if (isEmailValid) {
            print("Email is valid, sending OTP...");
            final isEmailOtpSent = await apiServiceVenderSide
                .sendOtpEmail(formData['email']!.trim());

            if (isEmailOtpSent) {
              print("Email OTP sent successfully, moving to step 2");
              showSuccessSnackbar("OTP sent to your email successfully!");
              nextRegistrationStep();
              return true;
            } else {
              showErrorSnackbar("Failed to send OTP. Please try again.");
            }
          } else {
            showErrorSnackbar("Email is already registered or invalid");
          }
          break;

        case 2:
          print("Processing step 2 - Email Verification");

          if (formData['otp']?.trim().isEmpty ?? true) {
            showErrorSnackbar("Please enter the OTP");
            return false;
          }

          if (formData['otp']!.trim().length != 6) {
            showErrorSnackbar("OTP must be 6 digits");
            return false;
          }

          // Get email from stored data
          final email = _registrationData['email'] as String?;
          if (email == null) {
            showErrorSnackbar("Email not found. Please restart registration.");
            resetRegistrationStep();
            return false;
          }

          // Store OTP for later use
          storeRegistrationData('emailOtp', formData['otp']!.trim());

          print("Verifying email OTP for: $email with OTP: ${formData['otp']}");

          // Create verification payload
          final verificationData = {
            'email': email,
            'otp': formData['otp']!.trim(),
          };

          print("Verification payload: $verificationData");

          final isEmailOtpValid = await apiServiceVenderSide.verifyOtpEmail(
              email, formData['otp']!.trim());

          if (isEmailOtpValid) {
            print("Email OTP verified successfully, moving to step 3");
            showSuccessSnackbar("Email verified successfully!");
            nextRegistrationStep();
            return true;
          } else {
            showErrorSnackbar("Invalid or expired OTP. Please try again.");
          }
          break;

        case 3:
          print("Processing step 3 - Mobile Number");

          if (_phoneNumber.value == null || _countryCode.value == null) {
            showErrorSnackbar("Please enter a valid mobile number");
            return false;
          }

          if (_phoneNumber.value!.length < 10) {
            showErrorSnackbar("Please enter a valid mobile number");
            return false;
          }

          // Store phone data
          storeRegistrationData('phoneNumber', _phoneNumber.value);
          storeRegistrationData('countryCode', _countryCode.value);

          print(
              "Sending phone OTP to: ${_countryCode.value}${_phoneNumber.value}");
          final isPhoneOtpSent = await apiServiceVenderSide.sendOtpPhone(
              _phoneNumber.value!, _countryCode.value!);

          if (isPhoneOtpSent) {
            print("Phone OTP sent successfully, moving to step 4");
            showSuccessSnackbar("OTP sent to your mobile number!");
            nextRegistrationStep();
            return true;
          } else {
            showErrorSnackbar("Failed to send phone OTP. Please try again.");
          }
          break;

        case 4:
          print("Processing step 4 - Phone Verification");

          if (formData['otp']?.trim().isEmpty ?? true) {
            showErrorSnackbar("Please enter the OTP");
            return false;
          }

          // Get phone data from stored data
          final phoneNumber = _registrationData['phoneNumber'] as String?;
          final countryCode = _registrationData['countryCode'] as String?;

          if (phoneNumber == null || countryCode == null) {
            showErrorSnackbar(
                "Phone number not found. Please restart registration.");
            resetRegistrationStep();
            return false;
          }

          // Store phone OTP
          storeRegistrationData('phoneOtp', formData['otp']!.trim());

          print(
              "Verifying phone OTP for: $countryCode$phoneNumber with OTP: ${formData['otp']}");
          final isPhoneOtpValid = await apiServiceVenderSide.verifyOtpPhone(
            phoneNumber,
            countryCode,
            formData['otp']!.trim(),
          );

          if (isPhoneOtpValid) {
            print("Phone OTP verified successfully, moving to step 5");
            showSuccessSnackbar("Mobile number verified successfully!");
            nextRegistrationStep();
            return true;
          } else {
            showErrorSnackbar("Invalid or expired OTP. Please try again.");
          }
          break;

        case 5:
          print("Processing step 5 - Final Registration");

          // Validate passwords
          if (formData['password']?.trim().isEmpty ?? true) {
            showErrorSnackbar("Please enter a password");
            return false;
          }

          if (formData['password']!.trim().length < 6) {
            showErrorSnackbar("Password must be at least 6 characters long");
            return false;
          }

          // Store password
          storeRegistrationData('password', formData['password']!.trim());

          // Prepare final registration data with ALL required fields
          final registrationPayload = {
            "email": _registrationData['email'],
            "firstName": _registrationData['firstName'],
            "lastName": _registrationData['lastName'],
            "password": _registrationData['password'],
            "country_code": _registrationData['countryCode'],
            "mobile_no": _registrationData['phoneNumber'],
            "role_type": "user",
            "otp": _registrationData['emailOtp'],
          };

          print("Final registration payload: $registrationPayload");

          final isRegistered =
              await apiServiceVenderSide.registerUser(registrationPayload);

          if (isRegistered) {
            print("Registration successful!");
            showSuccessSnackbar("Account created successfully!");

            // Clear registration data
            _registrationData.clear();

            // Navigate to home after brief delay
            await Future.delayed(const Duration(milliseconds: 1500));
            Get.offAllNamed('/auth', arguments: {'initialTab': 'login'});
            return true;
          } else {
            showErrorSnackbar("Registration failed. Please try again.");
          }
          break;

        default:
          showErrorSnackbar("Invalid registration step");
          return false;
      }
    } catch (e) {
      print("Error in registration step $step: $e");
      if (e.toString().contains("All fields including OTP are required")) {
        showErrorSnackbar("Please complete all previous steps properly");
        // Optionally go back to step 1
        resetRegistrationStep();
      } else {
        showErrorSnackbar("An error occurred. Please try again.");
      }
    } finally {
      _isLoading.value = false;
      update();
    }

    return false;
  }

  // Helper methods for UI
  String getRegistrationStepTitle() {
    switch (_registrationStep.value) {
      case 1:
        return "Personal Information";
      case 2:
        return "Email Verification";
      case 3:
        return "Mobile Number";
      case 4:
        return "Mobile Verification";
      case 5:
        return "Create Password";
      default:
        return "Registration";
    }
  }

  String getRegistrationButtonText() {
    switch (_registrationStep.value) {
      case 5:
        return "Create Account";
      default:
        return "Next";
    }
  }

  String getRegistrationStepDescription() {
    switch (_registrationStep.value) {
      case 1:
        return "Enter your basic information to get started";
      case 2:
        return "Verify your email address";
      case 3:
        return "Add your mobile number for security";
      case 4:
        return "Verify your mobile number";
      case 5:
        return "Create a secure password for your account";
      default:
        return "";
    }
  }

  // Reset methods
  void resetAuthState() {
    _isLoading.value = false;
    _isLogin.value = true;
    _registrationStep.value = 1;
    _obscurePassword.value = true;
    _obscureConfirmPassword.value = true;
    _rememberMe.value = false;
    _phoneNumber.value = null;
    _countryCode.value = null;
    _registrationData.clear();

    print("Auth state reset completely");
    update();
  }

  // Resend OTP methods
  Future<bool> resendEmailOtp() async {
    final email = _registrationData['email'] as String?;
    if (email == null) {
      showErrorSnackbar("Email not found. Please restart registration.");
      return false;
    }

    print("Resending email OTP to: $email");
    _isLoading.value = true;
    update();

    try {
      final isEmailOtpSent = await apiServiceVenderSide.sendOtpEmail(email);
      if (isEmailOtpSent) {
        showSuccessSnackbar("OTP resent to your email!");
        return true;
      } else {
        showErrorSnackbar("Failed to resend OTP. Please try again.");
      }
    } catch (e) {
      print("Error resending email OTP: $e");
      showErrorSnackbar("Failed to resend OTP. Please try again.");
    } finally {
      _isLoading.value = false;
      update();
    }

    return false;
  }

  Future<bool> resendPhoneOtp() async {
    final phoneNumber = _registrationData['phoneNumber'] as String?;
    final countryCode = _registrationData['countryCode'] as String?;

    if (phoneNumber == null || countryCode == null) {
      showErrorSnackbar("Phone number not found. Please restart registration.");
      return false;
    }

    print("Resending phone OTP to: $countryCode$phoneNumber");
    _isLoading.value = true;
    update();

    try {
      final isPhoneOtpSent =
          await apiServiceVenderSide.sendOtpPhone(phoneNumber, countryCode);
      if (isPhoneOtpSent) {
        showSuccessSnackbar("OTP resent to your mobile!");
        return true;
      } else {
        showErrorSnackbar("Failed to resend OTP. Please try again.");
      }
    } catch (e) {
      print("Error resending phone OTP: $e");
      showErrorSnackbar("Failed to resend OTP. Please try again.");
    } finally {
      _isLoading.value = false;
      update();
    }

    return false;
  }

  @override
  void onClose() {
    print("AuthController disposed");
    _registrationData.clear();
    super.onClose();
  }
}
