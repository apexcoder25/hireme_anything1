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
    final UserProfileController profileController = Get.put(UserProfileController());


  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool loader = false;

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();

    super.dispose();
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
                      keytype: TextInputType.name,
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
                    const SizedBox(height: 20),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            loader = true;
                          });

                          if (emailController.text.trim().isNotEmpty &&
                              passwordController.text.trim().isNotEmpty) {
                            final isRegistered =
                                await apiServiceUserSide.userLogin({
                              "email": emailController.text.trim(),
                              "password": passwordController.text.trim(),
                            });

                            if (isRegistered) {
                              Get.offAllNamed(UserRoutesName.homeUserView);
                              profileController.fetchProfile();
                            } else {
                              Get.snackbar(
                                "Error",
                                "Registration failed. Please try again!",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.redAccent,
                                colorText: Colors.white,
                                borderRadius: 8.0,
                                margin: const EdgeInsets.all(16),
                                duration: const Duration(seconds: 3),
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Error",
                              "Email and password cannot be empty!",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              colorText: Colors.white,
                              borderRadius: 8.0,
                              margin: const EdgeInsets.all(16),
                              duration: const Duration(seconds: 3),
                            );
                          }

                          setState(() {
                            loader = false;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              return Color.fromARGB(255, 102, 145, 218);
                            },
                          ),
                        ),
                        child: (loader == false)
                            ? const Text("Login",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                ))
                            : const CircularProgressIndicator(
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Dont have an account?",
                          style: TextStyle(
                              fontSize: 15,
                              color: colors.hintext_shop,
                              fontWeight: FontWeight.normal),
                        ),
                        TextButton(
                          child: const Text("Sign Up",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: colors.button_color,
                                  fontWeight: FontWeight.w600)),
                          onPressed: () {
                            Get.offNamed(UserRoutesName.registerUserView);
                          },
                        )
                      ],
                    ),
                  ],
                ))));
  }
}
