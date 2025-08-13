import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
// Import the MediaType class
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../uiltis/color.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  int k = 0;
  var ll = 10;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool loader = false;

  String? number;
  String? countryCode;

  int step = 1;
  TextEditingController emailOtpController = TextEditingController();
  TextEditingController phoneOtpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "User Signup Screen",
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
              if (step == 1)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("First Name",
                        style: TextStyle(color: Colors.black87, fontSize: 16)),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: firstnameController,
                      length: 50,
                      keytype: TextInputType.name,
                      hinttext: "First name",
                    ),
                    const SizedBox(height: 10),
                    const Text("Last Name",
                        style: TextStyle(color: Colors.black87, fontSize: 16)),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: lastnameController,
                      length: 50,
                      keytype: TextInputType.name,
                      hinttext: "Last Name",
                    ),
                    const SizedBox(height: 10),
                    const Text("Email Id*",
                        style: TextStyle(color: Colors.black87, fontSize: 16)),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: emailController,
                      length: 50,
                      keytype: TextInputType.name,
                      hinttext: "Email Id",
                    ),
                  ],
                ),
              if (step == 2)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter OTP",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: emailOtpController,
                      length: 50,
                      keytype: TextInputType.number,
                      hinttext: "OTP",
                    ),
                  ],
                ),
              if (step == 3)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mobile Number*",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    IntlPhoneField(
                      onCountryChanged: (value) {
                        setState(() {
                          ll = value.maxLength;
                        });
                      },
                      controller: mobileController,
                      flagsButtonPadding: const EdgeInsets.all(8),
                      decoration: const InputDecoration(
                        hintText: "Mobile Number",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (value) {
                        setState(() {
                          number = value.number;
                          countryCode = value.countryCode;
                        });
                      },
                      onSubmitted: (phone) {
                        if (phone.contains(RegExp(r'[0-5]'))) {
                          // Entered number contains 0, 1, 2, 3, 4, or 5
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a valid number.'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              if (step == 4)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Enter OTP",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: phoneOtpController,
                      length: 50,
                      keytype: TextInputType.number,
                      hinttext: "OTP",
                    ),
                  ],
                ),
              if (step == 5)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      keytype: TextInputType.number,
                      hinttext: "Password",
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Enter Confirm Password",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: confirmPasswordController,
                      length: 50,
                      keytype: TextInputType.number,
                      hinttext: "Confirm Password",
                    ),
                  ],
                ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loader = true;
                    });
                    if (step == 1) {
                      final isEmailValid = await apiServiceVenderSide
                          .checkEmail(emailController.text.trim());
                      if (isEmailValid) {
                        final isEmailOtpSent = await apiServiceVenderSide
                            .sendOtpEmail(emailController.text.trim());
                        if (isEmailOtpSent) {
                          setState(() {
                            step++;
                          });
                        }
                      }
                    } else if (step == 2) {
                      final isEmailOtpValid =
                          await apiServiceVenderSide.verifyOtpEmail(
                              emailController.text.trim(),
                              emailOtpController.text.trim());
                      if (isEmailOtpValid) {
                        setState(() {
                          step++;
                        });
                      }
                    } else if (step == 3) {
                      if (number != null && countryCode != null) {
                        final isPhoneOtpSent = await apiServiceVenderSide
                            .sendOtpPhone(number!, countryCode!);
                        if (isPhoneOtpSent) {
                          setState(() {
                            step++;
                          });
                        }
                      }

                      setState(() {
                        loader = false;
                      });
                    } else if (step == 4) {
                      final isPhoneOtpValid =
                          await apiServiceVenderSide.verifyOtpPhone(
                        number!,
                        countryCode!,
                        phoneOtpController.text.trim(),
                      );
                      if (isPhoneOtpValid) {
                        setState(() {
                          step++;
                        });
                      }
                    } else if (step == 5) {
                      if (passwordController.text.trim() ==
                          confirmPasswordController.text.trim()) {
                        final data = {
                          "email": emailController.text.trim(),
                          "firstName": firstnameController.text.trim(),
                          "lastName": lastnameController.text.trim(),
                          "password": passwordController.text.trim(),
                          "country_code": countryCode,
                          "mobile_no": number,
                          "role_type": "user"
                        };

                        final isRegistered =
                            await apiServiceVenderSide.registerUser(data);
                        if (isRegistered) {
                          Get.offAllNamed(UserRoutesName.homeUserView);
                        }
                      } else {
                        Get.snackbar(
                          "Error", // Title of the Snackbar
                          "Passwords do not match!", // Message to display
                          snackPosition:
                              SnackPosition.BOTTOM, // Position of the snackbar
                          backgroundColor: Colors.redAccent, // Background color
                          colorText: Colors.white, // Text color
                          borderRadius:
                              8.0, // Border radius for rounding corners
                          margin: const EdgeInsets.all(
                              16), // Padding around the snackbar
                          duration: const Duration(
                              seconds:
                                  3), // How long the snackbar will be visible
                        );
                      }
                    }

                    setState(() {
                      loader = false;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.grey;
                      },
                    ),
                  ),
                  child: (loader == false)
                      ? const Text("Next")
                      : const CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
                    style: TextStyle(
                        fontSize: 15,
                        color: colors.hintext_shop,
                        fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                    child: const Text("Login",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: colors.button_color,
                            fontWeight: FontWeight.w600)),
                    onPressed: () {
                      Get.offNamed(UserRoutesName.loginUserView);
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
