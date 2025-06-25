import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/auth_user_getx_controller.dart';
import 'package:hire_any_thing/navigation_bar.dart';
import 'package:hire_any_thing/views/Home.dart';

import '../utilities/constant.dart';

class GeneralInformation extends StatefulWidget {
  final userId;
  final token;
  const GeneralInformation({super.key, this.userId, this.token});

  @override
  State<GeneralInformation> createState() => _GeneralInformationState();
}

class _GeneralInformationState extends State<GeneralInformation> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  bool isMaleSelected = true;
  String? genderName;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final AuthUserGetXController authUserGetXController =
        Get.put(AuthUserGetXController());

    bool loader = false;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFf5f5f3),
                border: Border.all(color: Colors.transparent),
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [kPrimaryColor, kSecondaryColor],
                // ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: h / 20),
                    Image.asset(
                      "assets/app_logo/SH.png",
                      height: 230,
                      width: 290,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Welcome to Hire Anything",
                      style: TextStyle(
                        fontSize: isPortrait ? 20 : 24,
                        color: Color(0xFF004aad),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.transparent),
                  color: Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(15)),
              // margin: EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Enter Your Details",
                      style: TextStyle(
                        fontSize: isPortrait ? 20 : 24,
                        // color: kblackTextColor,
                        color: Color(0xFF004aad),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade100,
                              spreadRadius: 0,
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: name,
                        maxLength: 38,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade100,
                              spreadRadius: 0,
                              blurStyle: BlurStyle.outer,
                              blurRadius: 10,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20)),
                      child: TextFormField(
                        controller: email,
                        maxLength: 38,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          counterText: "",
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isMaleSelected = true;
                                genderName = "Male";
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: isMaleSelected
                                    ? Colors.red[700]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.male,
                                      color: isMaleSelected
                                          ? Colors.white
                                          : Colors.grey),
                                  SizedBox(width: 8),
                                  Text(
                                    'Male',
                                    style: TextStyle(
                                      color: isMaleSelected
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isMaleSelected = false;
                                genderName = "Female";
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: isMaleSelected
                                    ? Colors.grey[200]
                                    : Colors.red[700],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.female,
                                      color: isMaleSelected
                                          ? Colors.grey
                                          : Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'Female',
                                    style: TextStyle(
                                      color: isMaleSelected
                                          ? Colors.grey
                                          : Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    InkWell(
                      onTap: (loader == false)
                          ? () {
                              print("loader=>${loader}");
                              if (name.text.isEmpty) {
                                Get.snackbar(
                                  "Field required", // Title of the Snackbar
                                  "Please Enter name", // Message to display
                                  snackPosition: SnackPosition
                                      .BOTTOM, // Position of the snackbar
                                  backgroundColor:
                                      Colors.redAccent, // Background color
                                  colorText: Colors.white, // Text color
                                  borderRadius:
                                      8.0, // Border radius for rounding corners
                                  margin: const EdgeInsets.all(
                                      16), // Padding around the snackbar
                                  duration: Duration(
                                      seconds:
                                          3), // How long the snackbar will be visible
                                );
                              } else if (email.text.isEmpty) {
                                Get.snackbar(
                                  "Field required", // Title of the Snackbar
                                  "Please Enter email", // Message to display
                                  snackPosition: SnackPosition
                                      .BOTTOM, // Position of the snackbar
                                  backgroundColor:
                                      Colors.redAccent, // Background color
                                  colorText: Colors.white, // Text color
                                  borderRadius:
                                      8.0, // Border radius for rounding corners
                                  margin: const EdgeInsets.all(
                                      16), // Padding around the snackbar
                                  duration: Duration(
                                      seconds:
                                          3), // How long the snackbar will be visible
                                );
                              }

                              setState(() {
                                loader = true;
                              });
                              Future.microtask(() =>
                                  apiServiceUserSide.updateUserProfile(
                                      "${widget.userId}",
                                      "",
                                      name.text.trim(),
                                      email.text.trim(),
                                      widget.token.toString(),
                                      genderName)).whenComplete(() {
                                setState(() {
                                  loader = false;
                                });
                              });
                            }
                          : null,
                      child: (loader)
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Container(
                              height: 60,
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: kPrimaryColor.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                  child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isPortrait ? 16 : 20,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
