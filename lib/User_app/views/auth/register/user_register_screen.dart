import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../controllers/auth_controller.dart';
import '../components/auth_input_field.dart';
import '../components/auth_button.dart';
import '../components/progress_indicator.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class UserRegisterContent extends StatelessWidget {
  final AuthController authController;
  final Map<String, TextEditingController> controllers;

  const UserRegisterContent({
    super.key,
    required this.authController,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => Column(
        children: [
          AuthProgressIndicator(
            currentStep: controller.registrationStep,
              totalSteps: 5,
              stepLabels: const [
                'Personal Info',
                'Verify Email',
                'Mobile Number',
                'Verify Phone',
                'Complete Setup'
              ],
          ),
          
          const SizedBox(height: 25),
          
          GetBuilder<AuthController>(
            id: 'registration_step',
            builder: (controller) => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.3, 0.0),
                    end: Offset.zero,
                  ).animate(CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOutCubic,
                  )),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: _buildRegistrationStep(controller),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegistrationStep(AuthController controller) {
    switch (controller.registrationStep) {
      case 1: return _buildStep1(controller);
      case 2: return _buildStep2(controller);
      case 3: return _buildStep3(controller);
      case 4: return _buildStep4(controller);
      case 5: return _buildStep5(controller);
      default: return _buildStep1(controller);
    }
  }

  Widget _buildStep1(AuthController controller) {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthInputField(
          controller: controllers['firstName']!,
          hintText: "Enter first name",
          labelText: "First Name",
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 20),
        AuthInputField(
          controller: controllers['lastName']!,
          hintText: "Enter last name",
          labelText: "Last Name",
          prefixIcon: Icons.person_outline,
        ),
        const SizedBox(height: 20),
        AuthInputField(
          controller: controllers['email']!,
          hintText: "Enter email",
          labelText: "Email",
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 25),
        GetBuilder<AuthController>(
          builder: (controller) => AuthButton(
            onPressed: controller.isLoading ? null : () => _handleStep1(controller),
            text: controller.getRegistrationButtonText(),
            isLoading: controller.isLoading,
          ),
        ),
      ],
    );
  }

  Widget _buildStep2(AuthController controller) {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthInputField(
          controller: controllers['emailOtp']!,
          hintText: "Enter 6-digit OTP",
          labelText: "Email OTP",
          prefixIcon: Icons.sms_outlined,
          keyboardType: TextInputType.number,
          maxLength: 6,
        ),
        const SizedBox(height: 15),
        
        // Info container with resend option
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "We've sent a 6-digit verification code to:",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                controller.registrationData['email'] ?? controllers['email']!.text,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.isLoading ? null : () {
                      controller.resendEmailOtp();
                    },
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        fontSize: 12,
                        color: controller.isLoading ? AppColors.textLight : AppColors.btnColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 25),
        GetBuilder<AuthController>(
          builder: (controller) => AuthButton(
            onPressed: controller.isLoading ? null : () => _handleStep2(controller),
            text: controller.getRegistrationButtonText(),
            isLoading: controller.isLoading,
          ),
        ),
      ],
    );
  }

  Widget _buildStep3(AuthController controller) {
    return Column(
      key: const ValueKey('step3'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Mobile Number",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: const Border.fromBorderSide(
              BorderSide(color: AppColors.borderLight),
            ),
          ),
          child: IntlPhoneField(
            controller: controllers['mobile']!,
            flagsButtonPadding: const EdgeInsets.all(8),
            decoration: const InputDecoration(
              hintText: "Mobile Number",
              hintStyle: TextStyle(color: AppColors.textLight),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            ),
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textPrimary,
            ),
            initialCountryCode: 'IN',
            onChanged: (value) {
              controller.setPhoneData(value.number, value.countryCode);
            },
          ),
        ),
        const SizedBox(height: 25),
        GetBuilder<AuthController>(
          builder: (controller) => AuthButton(
            onPressed: controller.isLoading ? null : () => _handleStep3(controller),
            text: controller.getRegistrationButtonText(),
            isLoading: controller.isLoading,
          ),
        ),
      ],
    );
  }

  Widget _buildStep4(AuthController controller) {
    return Column(
      key: const ValueKey('step4'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthInputField(
          controller: controllers['phoneOtp']!,
          hintText: "Enter 6-digit OTP",
          labelText: "Phone OTP",
          prefixIcon: Icons.sms_outlined,
          keyboardType: TextInputType.number,
          maxLength: 6,
        ),
        const SizedBox(height: 15),
        
        // Info container with resend option
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "We've sent a 6-digit verification code to:",
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "${controller.countryCode ?? '+91'}${controller.phoneNumber ?? ''}",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    "Didn't receive the code? ",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.isLoading ? null : () {
                      controller.resendPhoneOtp();
                    },
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        fontSize: 12,
                        color: controller.isLoading ? AppColors.textLight : AppColors.btnColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 25),
        GetBuilder<AuthController>(
          builder: (controller) => AuthButton(
            onPressed: controller.isLoading ? null : () => _handleStep4(controller),
            text: controller.getRegistrationButtonText(),
            isLoading: controller.isLoading,
          ),
        ),
      ],
    );
  }

  Widget _buildStep5(AuthController controller) {
    return Column(
      key: const ValueKey('step5'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GetBuilder<AuthController>(
          builder: (controller) => AuthInputField(
            controller: controllers['password']!,
            hintText: "Enter password (min 6 characters)",
            labelText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: controller.obscurePassword,
            suffixIcon: GestureDetector(
              onTap: controller.togglePasswordVisibility,
              child: Icon(
                controller.obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.textLight,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        GetBuilder<AuthController>(
          builder: (controller) => AuthInputField(
            controller: controllers['confirmPassword']!,
            hintText: "Confirm your password",
            labelText: "Confirm Password",
            prefixIcon: Icons.lock_outline,
            obscureText: controller.obscureConfirmPassword,
            suffixIcon: GestureDetector(
              onTap: controller.toggleConfirmPasswordVisibility,
              child: Icon(
                controller.obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.textLight,
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        GetBuilder<AuthController>(
          builder: (controller) => AuthButton(
            onPressed: controller.isLoading ? null : () => _handleStep5(controller),
            text: controller.getRegistrationButtonText(),
            isLoading: controller.isLoading,
          ),
        ),
      ],
    );
  }

  // Step handlers with enhanced validation
  void _handleStep1(AuthController controller) {
    final firstName = controllers['firstName']!.text.trim();
    final lastName = controllers['lastName']!.text.trim();
    final email = controllers['email']!.text.trim();

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
      controller.showErrorSnackbar("Please fill all fields");
      return;
    }

    if (firstName.length < 2) {
      controller.showErrorSnackbar("First name must be at least 2 characters");
      return;
    }

    if (lastName.length < 2) {
      controller.showErrorSnackbar("Last name must be at least 2 characters");
      return;
    }

    if (!GetUtils.isEmail(email)) {
      controller.showErrorSnackbar("Please enter a valid email");
      return;
    }

    controller.performRegistrationStep(1, {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    });
  }

  void _handleStep2(AuthController controller) {
    final otp = controllers['emailOtp']!.text.trim();
    
    if (otp.isEmpty) {
      controller.showErrorSnackbar("Please enter OTP");
      return;
    }

    if (otp.length != 6) {
      controller.showErrorSnackbar("OTP must be 6 digits");
      return;
    }

    if (!RegExp(r'^\d{6}$').hasMatch(otp)) {
      controller.showErrorSnackbar("OTP must contain only numbers");
      return;
    }

    controller.performRegistrationStep(2, {
      'otp': otp,
    });
  }

  void _handleStep3(AuthController controller) {
    if (controller.phoneNumber == null || controller.countryCode == null) {
      controller.showErrorSnackbar("Please enter mobile number");
      return;
    }

    if (controller.phoneNumber!.length < 10) {
      controller.showErrorSnackbar("Please enter a valid 10-digit mobile number");
      return;
    }

    controller.performRegistrationStep(3, {});
  }

  void _handleStep4(AuthController controller) {
    final otp = controllers['phoneOtp']!.text.trim();
    
    if (otp.isEmpty) {
      controller.showErrorSnackbar("Please enter OTP");
      return;
    }

    

    if (!RegExp(r'^\d{4}$').hasMatch(otp)) {
      controller.showErrorSnackbar("OTP must contain only numbers");
      return;
    }

    controller.performRegistrationStep(4, {'otp': otp});
  }

  void _handleStep5(AuthController controller) {
    final password = controllers['password']!.text.trim();
    final confirmPassword = controllers['confirmPassword']!.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      controller.showErrorSnackbar("Please fill all password fields");
      return;
    }

    if (password.length < 6) {
      controller.showErrorSnackbar("Password must be at least 6 characters");
      return;
    }

    if (password != confirmPassword) {
      controller.showErrorSnackbar("Passwords do not match!");
      return;
    }

    // Password strength validation
    if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(password)) {
      controller.showErrorSnackbar("Password must contain both letters and numbers");
      return;
    }

    controller.performRegistrationStep(5, {
      'password': password,
    });
  }
}
