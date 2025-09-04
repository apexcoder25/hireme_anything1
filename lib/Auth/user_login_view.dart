import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_profile_controller.dart';
import 'package:hire_any_thing/res/routes/routes.dart';

class UserLoginScreeen extends StatefulWidget {
  const UserLoginScreeen({super.key});

  @override
  State<UserLoginScreeen> createState() => _UserLoginScreeenState();
}

class _UserLoginScreeenState extends State<UserLoginScreeen> {
  late UserProfileController profileController;

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool loader = false;

  @override
  void initState() {
    super.initState();
    // Get existing controller or create new one
    try {
      profileController = Get.find<UserProfileController>();
    } catch (e) {
      profileController = Get.put(UserProfileController());
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Validate inputs
    if (emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _showErrorSnackbar("Email and password cannot be empty!");
      return;
    }

    // Basic email validation
    if (!GetUtils.isEmail(emailController.text.trim())) {
      _showErrorSnackbar("Please enter a valid email address!");
      return;
    }

    setState(() {
      loader = true;
    });

    try {
      final isRegistered = await apiServiceUserSide.userLogin({
        "email": emailController.text.trim(),
        "password": passwordController.text.trim(),
      });

      print("Login result: $isRegistered");

      if (isRegistered) {
        print("Fetching profile...");

        // Key fix: Refresh token before fetching profile
        await profileController.refreshToken();
        await profileController.fetchProfile();

        // Check if profile was successfully fetched
        if (profileController.isLogin.value) {
          print("Navigating to ${UserRoutesName.homeUserView}");
          Get.offAllNamed(UserRoutesName.homeUserView);
        } else {
          _showErrorSnackbar("Failed to load user profile. Please try again.");
        }
      } else {
        _showErrorSnackbar(
            "Invalid credentials. Please check your email and password.");
      }
    } catch (e) {
      print("Login error: $e");
      _showErrorSnackbar(
          "Login failed. Please check your connection and try again.");
    } finally {
      setState(() {
        loader = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Login Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      borderRadius: 8.0,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "User Login Screen",
          style: TextStyle(fontWeight: FontWeight.bold, color: colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Email",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: emailController,
                length: 50,
                keytype: TextInputType.emailAddress, // Changed to emailAddress
                hinttext: "Email Id",
              ),
              const SizedBox(height: 20),
              const Text(
                "Enter Password",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: passwordController,
                length: 50,
                keytype: TextInputType.text,
                hinttext: "Password",
                isPassword: true,
              ),
              const SizedBox(height: 40), // Increased spacing
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      loader ? null : _handleLogin, // Disable when loading
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Colors.grey[400]!;
                        }
                        return const Color.fromARGB(255, 102, 145, 218);
                      },
                    ),
                  ),
                  child: loader
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors
                                .white, // Changed to white for better contrast
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?", // Fixed typo
                    style: TextStyle(
                      fontSize: 15,
                      color: colors.hintext_shop,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextButton(
                    child: const Text(
                      "Sign Up",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: colors.button_color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      Get.offNamed(UserRoutesName.registerUserView);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
