import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/upload_image.dart';
import 'package:hire_any_thing/data/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/res/routes/routes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../uiltis/color.dart';

class VendorSignUp extends StatefulWidget {
  const VendorSignUp({super.key});

  @override
  State<VendorSignUp> createState() => _VendorSignUpState();
}

class _VendorSignUpState extends State<VendorSignUp> {
  final ImageController imageController = Get.put(ImageController());
  int k = 0;
  var ll = 10;

  TextEditingController nameController = TextEditingController();
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
  TextEditingController companyNameController = TextEditingController();
  TextEditingController countryRegionController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();

  // Password regex: At least 8 chars, 1 uppercase, 1 lowercase, 1 number, 1 special char
  final RegExp _passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

  // Error message for password validation
  String? _passwordError;

  @override
  void initState() {
    imageController.selectedImages.clear();
    imageController.uploadedUrls.clear();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailOtpController.dispose();
    confirmPasswordController.dispose();
    companyNameController.dispose();
    cityNameController.dispose();
    streetNameController.dispose();
    super.dispose();
  }

  // Validate password
  bool _validatePassword(String password) {
    if (!_passwordRegex.hasMatch(password)) {
      setState(() {
        _passwordError =
            'Password must be at least 8 characters, include uppercase, lowercase, number, and special character';
      });
      return false;
    }
    setState(() {
      _passwordError = null;
    });
    return true;
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
          "Vendor Signup Screen",
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
                    const Text("Account Information",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: emailController,
                      length: 50,
                      keytype: TextInputType.name,
                      hinttext: "Email Id",
                    ),
                    const SizedBox(height: 10),
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
                    const Text("Personal Information",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text(
                      "Name",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: nameController,
                      length: 50,
                      keytype: TextInputType.text,
                      hinttext: "Name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
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
                    const Text("Business Information",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: companyNameController,
                      length: 50,
                      keytype: TextInputType.text,
                      hinttext: "Enter Your Company Name",
                    ),
                    const SizedBox(height: 20),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: countryRegionController,
                      length: 50,
                      keytype: TextInputType.name,
                      hinttext: "Country/Region",
                    ),
                    const SizedBox(height: 20),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: cityNameController,
                      length: 50,
                      keytype: TextInputType.name,
                      hinttext: "City Name",
                    ),
                    const SizedBox(height: 20),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: streetNameController,
                      length: 50,
                      keytype: TextInputType.name,
                      hinttext: "Street Name",
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Obx(() => Wrap(
                                  children: List.generate(
                                      imageController.selectedImages.length,
                                      (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(
                                        children: [
                                          Image.file(
                                            File(imageController
                                                .selectedImages[index]),
                                            fit: BoxFit.cover,
                                            height: 60,
                                            width: 60,
                                          ),
                                          Positioned(
                                            top: 2,
                                            right: 2,
                                            child: GestureDetector(
                                              onTap: () => imageController
                                                  .removeImage(index),
                                              child: Icon(Icons.close,
                                                  color: Colors.redAccent),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                                )))),
                    const SizedBox(height: 20),
                    // Upload Button
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.camera),
                                  title: Text('Take a Photo'),
                                  onTap: () {
                                    imageController.pickImages(true);
                                    Navigator.pop(context);
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.photo_library),
                                  title: Text('Choose from Gallery'),
                                  onTap: () {
                                    imageController.pickImages(false);
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: DottedBorder(
                        color: Colors.black,
                        strokeWidth: 1,
                        dashPattern: [5, 5],
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.cloud_upload_outlined,
                                    size: 40, color: Colors.grey),
                                Text(
                                  "Click to upload or drag and drop PNG, JPG (MAX. 800x400px)",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Signup_textfilled(
                      textfilled_height: 17,
                      textfilled_weight: 1,
                      textcont: passwordController,
                      length: 50,
                      keytype: TextInputType.text,
                      hinttext: "Password",
                      isPassword: true,
                      onChanged: (value) {
                        _validatePassword(value);
                      },
                    ),
                    if (_passwordError != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _passwordError!,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
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
                      keytype: TextInputType.text,
                      hinttext: "Confirm Password",
                      isPassword: true,
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
                      final password = passwordController.text.trim();
                      final confirmPassword =
                          confirmPasswordController.text.trim();
                      if (!_validatePassword(password)) {
                        Get.snackbar(
                          "Error",
                          "Invalid password format!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          borderRadius: 8.0,
                          margin: const EdgeInsets.all(16),
                          duration: const Duration(seconds: 3),
                        );
                      } else if (password != confirmPassword) {
                        Get.snackbar(
                          "Error",
                          "Passwords do not match!",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.redAccent,
                          colorText: Colors.white,
                          borderRadius: 8.0,
                          margin: const EdgeInsets.all(16),
                          duration: const Duration(seconds: 3),
                        );
                      } else {
                        final data = {
                          "email": emailController.text.trim(),
                          "name": nameController.text.trim(),
                          "mobile_no": number,
                          "country_code": countryCode,
                          "password": password,
                          "confirmPassword": confirmPassword,
                          "company_name": companyNameController.text.trim(),
                          "city_name": cityNameController.text.trim(),
                          "country": countryRegionController.text.trim(),
                          "state": "",
                          "street_name": streetNameController.text.trim(),
                          "pincode": "",
                          "photos": imageController.uploadedUrls[0].toString(),
                          "otp": emailOtpController.text.trim(),
                        };
                        final isRegistered = await apiServiceVenderSide
                            .vendorRegisterUser(data);
                        if (isRegistered) {
                          Get.offAllNamed(VendorRoutesName.homeVendorView);
                        }
                      }
                    }
                    setState(() {
                      loader = false;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Color.fromARGB(255, 102, 145, 218);
                      },
                    ),
                  ),
                  child: (loader == false)
                      ? const Text("Next",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 18,
                          ))
                      : const CircularProgressIndicator(
                          color: Colors.grey,
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
                      Get.offNamed(VendorRoutesName.loginVendorView);
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