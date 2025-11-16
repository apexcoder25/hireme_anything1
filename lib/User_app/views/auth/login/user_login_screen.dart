import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/utilities/colors.dart';
import '../controllers/auth_controller.dart';
import '../components/auth_input_field.dart';
import '../components/auth_button.dart';

class UserLoginContent extends StatelessWidget {
  final AuthController authController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const UserLoginContent({
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
        AuthInputField(
          controller: emailController,
          hintText: "Enter email",
          labelText: "Email",
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
        ),
        
        const SizedBox(height: 20),
        
        GetBuilder<AuthController>(
          builder: (controller) => AuthInputField(
            controller: passwordController,
            hintText: "Enter password",
            labelText: "Password",
            prefixIcon: Icons.lock_outline,
            obscureText: controller.obscurePassword,
            suffixIcon: GestureDetector(
              onTap: controller.togglePasswordVisibility,
              child: Icon(
                controller.obscurePassword 
                  ? Icons.visibility_off 
                  : Icons.visibility,
                color: AppColors.textLight,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 15),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           const Spacer(),
            TextButton(
              onPressed: () {},
              child: const Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.btnColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 25),
        
        GetBuilder<AuthController>(
          builder: (controller) => AuthButton(
            onPressed: controller.isLoading 
              ? null 
              : () => controller.performLogin(
                  emailController.text,
                  passwordController.text,
                ),
            text: "Login",
            isLoading: controller.isLoading,
            icon: const Icon(Icons.login, size: 18),
          ),
        ),
      ],
    );
  }
}
