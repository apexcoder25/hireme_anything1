import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/vendor_auth_controller.dart';
import '../components/auth_input_field.dart';
import '../components/auth_button.dart';

class VendorLoginContent extends StatelessWidget {
  final VendorAuthController authController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const VendorLoginContent({
    super.key,
    required this.authController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        VendorAuthInputField(
          controller: emailController,
          hintText: "Enter your business email",
          label: "Business Email",
          keyboardType: TextInputType.emailAddress,
          isRequired: true,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: Colors.grey,
          ),
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Email is required';
            }
            if (!GetUtils.isEmail(value!.trim())) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        VendorAuthInputField(
          controller: passwordController,
          hintText: "Enter your password",
          label: "Password",
          isPassword: true,
          isRequired: true,
          prefixIcon: const Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
          validator: (value) {
            if (value?.trim().isEmpty ?? true) {
              return 'Password is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            TextButton(
              onPressed: () {
                Get.snackbar(
                  'Info',
                  'Forgot password feature coming soon',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff0e53ce),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        Obx(() => VendorAuthButton(
          onPressed: authController.isLoading.value 
              ? null 
              : () => _handleLogin(),
          text: "Login to Dashboard",
          isLoading: authController.isLoading.value,
          icon: const Icon(
            Icons.login,
            size: 18,
            color: Colors.white,
          ),
        )),
      ],
    );
  }

  void _handleLogin() {
    if (emailController.text.trim().isEmpty || 
        passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill all required fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    authController.vendorLogin();
  }
}
