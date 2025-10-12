import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import '../controllers/vendor_auth_controller.dart';
import '../components/auth_input_field.dart';
import '../components/auth_button.dart';
import '../components/progress_indicator.dart';

class VendorRegisterContent extends StatelessWidget {
  final VendorAuthController authController;

  const VendorRegisterContent({
    super.key,
    required this.authController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => VendorAuthProgressIndicator(
              currentStep: authController.currentStep.value,
              totalSteps: 5,
              stepLabels: const [
                'Business Email',
                'Verify Email',
                'Personal Info',
                'Verify Phone',
                'Complete Setup'
              ],
            )),
        const SizedBox(height: 25),
        Obx(() => AnimatedSwitcher(
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
              child: _buildRegistrationStep(),
            )),
      ],
    );
  }

  Widget _buildRegistrationStep() {
    switch (authController.currentStep.value) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      case 4:
        return _buildStep4();
      case 5:
        return _buildStep5();
      default:
        return _buildStep1();
    }
  }

  // Step 1: Email Input
  Widget _buildStep1() {
    return Column(
      key: const ValueKey('vendor_step1'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Business Email',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Enter your business email to get started with vendor registration',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: authController.emailController,
          hintText: "Enter your business email",
          label: "Email Address",
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 25),
        Obx(() => VendorAuthButton(
              onPressed: authController.isLoading.value
                  ? null
                  : authController.checkEmailAvailability,
              text: "Continue",
              isLoading: authController.isLoading.value,
            )),
      ],
    );
  }

  // Step 2: Email OTP Verification
  Widget _buildStep2() {
    return Column(
      key: const ValueKey('vendor_step2'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Verify Email',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We\'ve sent a verification code to ${authController.emailController.text}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: authController.emailOtpController,
          hintText: "Enter 6-digit OTP",
          label: "Email OTP",
          keyboardType: TextInputType.number,
          isRequired: true,
          maxLength: 6,
          prefixIcon: const Icon(
            Icons.sms_outlined,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xff0e53ce).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xff0e53ce).withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xff0e53ce),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Didn\'t receive the code?',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff0e53ce),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  if (!authController.isLoading.value) {
                    authController.checkEmailAvailability();
                  }
                },
                child: Obx(() => Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontSize: 12,
                        color: authController.isLoading.value
                            ? Colors.grey
                            : const Color(0xff0e53ce),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: authController.previousStep,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xff0e53ce)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xff0e53ce)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Obx(() => VendorAuthButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : authController.verifyEmailOTP,
                    text: "Verify Email",
                    isLoading: authController.isLoading.value,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  // Step 3: Personal Information & Phone
  Widget _buildStep3() {
    return Column(
      key: const ValueKey('vendor_step3'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Personal Information',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Tell us about yourself and add your phone number',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: authController.nameController,
          hintText: "Enter your full name",
          label: "Full Name",
          isRequired: true,
          prefixIcon: const Icon(
            Icons.person_outline,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Mobile Number *',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: IntlPhoneField(
            controller: authController.mobileController,
            flagsButtonPadding: const EdgeInsets.all(8),
            decoration: const InputDecoration(
              hintText: 'Mobile Number',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            ),
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
            initialCountryCode: 'GB',
            onChanged: (value) {
              authController.phoneNumber = value.number;
              authController.countryCode = value.countryCode;
            },
          ),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: authController.previousStep,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xff0e53ce)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xff0e53ce)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Obx(() => VendorAuthButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : authController.sendPhoneOTP,
                    text: "Continue",
                    isLoading: authController.isLoading.value,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  // Step 4: Phone OTP Verification
  Widget _buildStep4() {
    return Column(
      key: const ValueKey('vendor_step4'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Verify Phone Number',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'We\'ve sent a verification code to ${authController.countryCode ?? '+44'}${authController.phoneNumber ?? ''}',
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: authController.phoneOtpController,
          hintText: "Enter 6-digit OTP",
          label: "Phone OTP",
          keyboardType: TextInputType.number,
          isRequired: true,
          maxLength: 6,
          prefixIcon: const Icon(
            Icons.sms_outlined,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xff0e53ce).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xff0e53ce).withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xff0e53ce),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Didn\'t receive the code?',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff0e53ce),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  if (!authController.isLoading.value) {
                    authController.sendPhoneOTP();
                  }
                },
                child: Obx(() => Text(
                      'Resend OTP',
                      style: TextStyle(
                        fontSize: 12,
                        color: authController.isLoading.value
                            ? Colors.grey
                            : const Color(0xff0e53ce),
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: authController.previousStep,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xff0e53ce)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xff0e53ce)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Obx(() => VendorAuthButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : authController.verifyPhoneOTP,
                    text: "Verify Phone",
                    isLoading: authController.isLoading.value,
                  )),
            ),
          ],
        ),
      ],
    );
  }

  // Step 5: Complete Registration
  Widget _buildStep5() {
    return Column(
      key: const ValueKey('vendor_step5'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Complete Registration',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Add your business details and create a secure password',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: authController.companyNameController,
          hintText: "Enter your company name",
          label: "Company Name",
          isRequired: true,
          prefixIcon: const Icon(
            Icons.business,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'City *',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Obx(() => DropdownButtonFormField<String>(
                    value: authController.selectedCity.value.isEmpty
                        ? null
                        : authController.selectedCity.value,
                    decoration: const InputDecoration(
                      hintText: 'Select your city',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.location_city, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    items: authController.ukCities.map((String city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        authController.updateSelectedCity(newValue);
                      }
                    },
                  )),
            ),
          ],
        ),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: authController.streetNameController,
          hintText: "Enter street address",
          label: "Street Address",
          isRequired: true,
          prefixIcon: const Icon(
            Icons.location_on_outlined,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: authController.passwordController,
          hintText: "Create a strong password",
          label: "Password",
          isPassword: true,
          isRequired: true,
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
        ),
        Obx(() => authController.passwordError.value.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  authController.passwordError.value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
              )
            : const SizedBox.shrink()),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: authController.confirmPasswordController,
          hintText: "Confirm your password",
          label: "Confirm Password",
          isPassword: true,
          isRequired: true,
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        // Business Photos Section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.photo_camera,
                    color: Color(0xff0e53ce),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Business Photos *',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff0e53ce),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Add photos of your business to build trust with customers',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              // Add image upload widget
              GetBuilder<ImageController>(
                builder: (imageController) => Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey.shade300, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: imageController.selectedImages.isEmpty
                      ? InkWell(
                          // onTap: () => imageController.pickImages(),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate,
                                    size: 30, color: Colors.grey),
                                SizedBox(height: 4),
                                Text('Tap to add photos',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageController.selectedImages.length + 1,
                          itemBuilder: (context, index) {
                            if (index ==
                                imageController.selectedImages.length) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  // onTap: () => imageController.pickImages(),
                                  child: Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.add,
                                        color: Colors.grey),
                                  ),
                                ),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: FileImage(imageController
                                            .selectedImages[index] as File),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 4,
                                    right: 4,
                                    child: GestureDetector(
                                      onTap: () =>
                                          imageController.removeImage(index),
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: const BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: authController.previousStep,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xff0e53ce)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(color: Color(0xff0e53ce)),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: Obx(() => VendorAuthButton(
                    onPressed: authController.isLoading.value
                        ? null
                        : authController.completeRegistration,
                    text: "Create Account",
                    isLoading: authController.isLoading.value,
                    icon: const Icon(
                      Icons.check_circle_outline,
                      size: 18,
                      color: Colors.white,
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
