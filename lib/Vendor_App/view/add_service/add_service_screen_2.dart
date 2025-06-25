import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/api_service/api_service_vender_side.dart';
import '../../cutom_widgets/signup_textfilled.dart';
import '../../uiltis/color.dart';
import '../Navagation_bar.dart';
import '../login.dart';
import 'package:intl/intl.dart' as inTlDateTime; // Import the intl package

class AddServiceScreenServiceSecond extends StatefulWidget {
  String? serviceID;
  AddServiceScreenServiceSecond({super.key, this.serviceID});

  // serviceID
  @override
  State<AddServiceScreenServiceSecond> createState() =>
      _AddServiceScreenServiceState();
}

class _AddServiceScreenServiceState
    extends State<AddServiceScreenServiceSecond> {
  File? _image;
  TextEditingController noOfSeats = TextEditingController();
  TextEditingController regisNo = TextEditingController();
  TextEditingController makeNmodel = TextEditingController();
  TextEditingController fssainum = TextEditingController();
  TextEditingController perKmDeliveryChargeController = TextEditingController();
  TextEditingController minMiles = TextEditingController();
  TextEditingController maxMiles = TextEditingController();
  TextEditingController hour = TextEditingController();
  TextEditingController minutes = TextEditingController();

  TextEditingController maxDeliveryServiceDistanceController =
      TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  late String selectedDropdownItem = '';
  int p = 0;

  @override
  void initState() {
    // separateString();
    super.initState();
  }

  String?
      _initialValueWheelChareAccessibleAurNot; // Variable to hold the selected radio button value

  void _handleWheelChareAccessibleAurNot(String? value) {
    setState(() {
      _initialValueWheelChareAccessibleAurNot =
          value; // Update the selected option
    });
  }

  String?
      _initialToiletFacilitiesAurNot; // Variable to hold the selected radio button value

  void _setToiletFacilitiesAurNot(String? value) {
    setState(() {
      _initialToiletFacilitiesAurNot = value; // Update the selected option
    });
  }

  String?
      _initialAironFittedAurNot; // Variable to hold the selected radio button value

  void _setAironFittedAurNot(String? value) {
    setState(() {
      _initialAironFittedAurNot = value; // Update the selected option
    });
  }

  String?
      _initialCofeemachineAurNot; // Variable to hold the selected radio button value

  void _setCofeemachineAurNot(String? value) {
    setState(() {
      _initialCofeemachineAurNot = value; // Update the selected option
    });
  }

  bool loader = false;

  TimeOfDay selectedTime = TimeOfDay.now();

  String dateSelectedUser = "";

  Future<void> showTimePickerDialog(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.rtl, // Right to left direction
          child: child!,
        );
      },
    );

    // If a time was picked, update the selected time
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
    print(
        "selectedTime=>${selectedTime?.hour}:${selectedTime?.minute}:${selectedTime?.period}");
    print("formatTime(selectedTime)=>${formatTime(selectedTime!)}");
    setState(() {
      dateSelectedUser = formatTime(selectedTime!);
    });
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;

    // Determine AM or PM
    final suffix = hour >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    final formattedHour = hour % 12 == 0 ? 12 : hour % 12;

    return '$formattedHour:${minute.toString().padLeft(2, '0')} $suffix';
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: colors.scaffold_background_color,
        appBar: AppBar(
          backgroundColor: colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Add Service",
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
                const Text("No. Of Seats",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: noOfSeats,
                  length: 50,
                  keytype: TextInputType.number,
                  hinttext: "No. of Seats",
                ),
                const SizedBox(height: 20),

                // <==========  Registration No. ==========>
                const Text("Registration No.",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: regisNo,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "Registration No.",
                ),
                const SizedBox(height: 20),

                // <==========  Wheel Chair ==========>
                const Text("Wheel Chair Accessible",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 5),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        // Shadow color
                        spreadRadius: 1,
                        // How much the shadow spreads
                        blurRadius: 1,
                        // How blurred the shadow is
                        offset: Offset(0, 1), // Shadow offset
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text("Yes"),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Radio<String>(
                              value: "true",
                              groupValue:
                                  _initialValueWheelChareAccessibleAurNot,
                              onChanged: _handleWheelChareAccessibleAurNot,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Text("NO"),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          Radio<String>(
                            value: "false",
                            groupValue: _initialValueWheelChareAccessibleAurNot,
                            onChanged: _handleWheelChareAccessibleAurNot,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // <==========  Make and Model ==========>
                const Text("Make and Model",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: makeNmodel,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "Make and Model",
                ),
                const SizedBox(height: 20),

                // // <==========  Delivery Charge ==========>
                // const Text("Delivery Charge",
                //     style: TextStyle(color: Colors.black87, fontSize: 16)),
                // const SizedBox(height: 10),
                // Signup_textfilled(
                //   textfilled_height: 17,
                //   textfilled_weight: 1,
                //   textcont: faltcon,
                //   length: 50,
                //   keytype: TextInputType.name,
                //   hinttext: "Delivery charge",
                // ),

                // <==========  Toilet Facilities ==========>
                // <==========  Toilet Facilities ==========>
                const Text("Does the coach have Toilet Facilities",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        // Shadow color
                        spreadRadius: 1,
                        // How much the shadow spreads
                        blurRadius: 1,
                        // How blurred the shadow is
                        offset: Offset(0, 1), // Shadow offset
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text("Yes"),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Radio<String>(
                              value: "true",
                              groupValue: _initialToiletFacilitiesAurNot,
                              onChanged: _setToiletFacilitiesAurNot,
                            ),
                            // Checkbox(
                            //     value: isYesToiletcheck,
                            //     onChanged: _onYesToiletChanged),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Text("NO"),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          Radio<String>(
                            value: "false",
                            groupValue: _initialToiletFacilitiesAurNot,
                            onChanged: _setToiletFacilitiesAurNot,
                          ),
                          // Checkbox(
                          //     value: isNoToiletcheck,
                          //     onChanged: _onNoToiletChanged),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                // <==========  Airon Fitted ==========>
                const Text("Airon Fitted",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        // Shadow color
                        spreadRadius: 1,
                        // How much the shadow spreads
                        blurRadius: 1,
                        // How blurred the shadow is
                        offset: Offset(0, 1), // Shadow offset
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text("Yes"),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            // Checkbox(
                            //     value: isYesAironcheck,
                            //     onChanged: _onYesAironChanged),

                            Radio<String>(
                              value: "true",
                              groupValue: _initialAironFittedAurNot,
                              onChanged: _setAironFittedAurNot,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Text("NO"),
                          // SizedBox(
                          //   width: 5,
                          // ),

                          Radio<String>(
                            value: "false",
                            groupValue: _initialAironFittedAurNot,
                            onChanged: _setAironFittedAurNot,
                          ),

                          // Checkbox(
                          //     value: isNoAironcheck,
                          //     onChanged: _onNoAironChanged),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // <==========  Coffee Machine ==========>
                const Text("Coffee Machine",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        // Shadow color
                        spreadRadius: 1,
                        // How much the shadow spreads
                        blurRadius: 1,
                        // How blurred the shadow is
                        offset: Offset(0, 1), // Shadow offset
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            Text("Yes"),
                            // SizedBox(
                            //   width: 5,
                            // ),
                            Radio<String>(
                              value: "true",
                              groupValue: _initialCofeemachineAurNot,
                              onChanged: _setCofeemachineAurNot,
                            ),
                            // Checkbox(
                            //     value: isYesCoffeecheck,
                            //     onChanged: _onYesCoffeeChanged),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          Text("NO"),
                          // SizedBox(
                          //   width: 5,
                          // ),
                          Radio<String>(
                            value: "false",
                            groupValue: _initialCofeemachineAurNot,
                            onChanged: _setCofeemachineAurNot,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // <==========  Distance or mileage ==========>
                const Text("Distance in miles",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7)),
                        height: MediaQuery.of(context).size.height / 17,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              controller: minMiles,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Min. 50 mile",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      elevation: 1,
                      borderRadius: BorderRadius.circular(7),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7)),
                        height: MediaQuery.of(context).size.height / 17,
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: TextFormField(
                              controller: maxMiles,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Max 500 miles",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                // <==========  Time for Booking ==========>
                const Text("Time for Booking",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${dateSelectedUser}"),
                    GestureDetector(
                        onTap: () {
                          showTimePickerDialog(context);
                        },
                        child: Icon(Icons.lock_clock))
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),

                Wrap(
                  spacing: 5,
                  children: selectedItems.map((item) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // Background color
                          borderRadius: BorderRadius.circular(16.0),
                          // Rounded corners
                          border: Border.all(color: Colors.black, width: 0.2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 4.0, left: 4),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (selectedItems.contains(item))
                                const Icon(Icons.check, color: Colors.green),
                              const SizedBox(width: 3),
                              Text(
                                item,
                                style: const TextStyle(
                                  color: Colors.black, // Text color
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // noOfSeats
                      // regisNo

                      Map<String, dynamic>? requestedData = {
                        "serviceId": "${widget.serviceID}",
                        "no_of_seats": "${noOfSeats.text.trim()}",
                        "registration_no": "${regisNo.text.trim()}",
                        "wheel_chair":
                            _initialValueWheelChareAccessibleAurNot.toString(),
                        "make_and_model": "${makeNmodel.text.trim()}",
                        "toilet_facility":
                            _initialToiletFacilitiesAurNot.toString(),
                        "airon_fitted": _initialAironFittedAurNot.toString(),
                        "coffee_machine": _initialCofeemachineAurNot.toString(),
                        "minimum_distance": minMiles.text.trim().toString(),
                        "maximum_distance": maxMiles.text.trim().toString(),
                        "booking_time": "${dateSelectedUser}",
                      };
                      if (noOfSeats.text.isEmpty) {
                        return gtxSnakbar(
                            "Missing Information", "Please Enter No of Seats");
                      }
                      if (regisNo.text.isEmpty) {
                        return gtxSnakbar("Missing Information",
                            "Please Enter Registration no");
                      }
                      if (_initialValueWheelChareAccessibleAurNot == "") {
                        return gtxSnakbar("Missing Information",
                            "Please select if wheelchair accessible");
                      }
                      if (makeNmodel.text.isEmpty) {
                        return gtxSnakbar("Missing Information",
                            "Please Enter if Model Number");
                      }
                      if (_initialToiletFacilitiesAurNot == "") {
                        return gtxSnakbar("Missing Information",
                            "Please select if toilet facilities are available or not.");
                      }
                      if (_initialAironFittedAurNot == "") {
                        return gtxSnakbar("Missing Information",
                            "Please select if AironFitted facilities are available or not.");
                      }
                      if (_initialCofeemachineAurNot == "") {
                        return gtxSnakbar("Missing Information",
                            "Please select if coffee machine facilities are available or not");
                      }
                      if (minMiles.text.isEmpty) {
                        return gtxSnakbar(
                            "Missing Information", "Please enter minMiles");
                      }
                      if (dateSelectedUser == "") {
                        return gtxSnakbar(
                            "Missing Information", "Please select time");
                      }

                      setState(() {
                        loader = true;
                      });
                      if (loader == true) {
                        Future.microtask(() => apiServiceVenderSide
                            .updateVendorService(
                                [], requestedData, context)).whenComplete(() {
                          setState(() {
                            loader = false;
                          });
                        });
                      }
                    },
                    child: (loader == true)
                        ? CircularProgressIndicator(
                            color: Colors.blue,
                          )
                        : const Text(
                            "Done",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (
                              // miniOrderController.text.isEmpty ||
                              //     perKmDeliveryChargeController.text.isEmpty ||
                              //     servicesvalble.text.isEmpty ||
                              noOfSeats.text.isEmpty ||
                                  regisNo.text.isEmpty ||
                                  makeNmodel.text.isEmpty ||
                                  minMiles.text.isEmpty ||
                                  maxMiles.text.isEmpty ||
                                  hour.text.isEmpty ||
                                  minutes.text.isEmpty
                              // ||
                              // selectedCategoryIds.isEmpty
                              ) {
                            return Colors.grey;
                          }
                          return Colors.green;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidFssiNumber(String fssainum) {
    return fssainum.length == 14 && int.tryParse(fssainum) != null;
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _openCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _openGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImageCamera = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedImageCamera != null) {
      setState(() {
        _image = File(pickedImageCamera.path);
      });
    }
  }

  void _openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImageGallery = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImageGallery != null) {
      setState(() {
        _image = File(pickedImageGallery.path);
      });
    }
  }

  gtxSnakbar(title, des) {
    return Get.snackbar(
      "$title", // Title of the Snackbar
      "$des", // Message to display
      snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
      backgroundColor: Colors.redAccent, // Background color
      colorText: Colors.white, // Text color
      borderRadius: 8.0, // Border radius for rounding corners
      margin: const EdgeInsets.all(16), // Padding around the snackbar
      duration: Duration(seconds: 3), // How long the snackbar will be visible
    );
  }

  List<String> items = [];
  List<String> selectedItems = [];
  Map<String, String> categoryMap = {};
  List selectedCategoryIds = [];

  Future<String> getMobileFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userMobile') ?? 'Default Mobile';
  }
}
