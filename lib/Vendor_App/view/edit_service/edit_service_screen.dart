import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:hire_any_thing/Vendor_App/view/add_product/maptest.dart';
import 'package:hire_any_thing/Vendor_App/view/login.dart';
import 'package:hire_any_thing/Vendor_App/view/signup%20form/signup_form1.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Import the MediaType class
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../uiltis/color.dart';
import '../Navagation_bar.dart';
import 'edit_service_screen_second.dart';
import 'package:intl/intl.dart' as inTlDateTime; // Import the intl package

class EditServiceScreenFirst extends StatefulWidget {
  EditServiceScreenFirst({Key? key});

  @override
  State<EditServiceScreenFirst> createState() => _EditServiceScreenFirstState();
}

class _EditServiceScreenFirstState extends State<EditServiceScreenFirst> {
  final VenderSidetGetXController venderSidetGetXController =
      Get.put(VenderSidetGetXController());

  TextEditingController serviceNameController = TextEditingController();
  TextEditingController serviceAmountController = TextEditingController();
  TextEditingController serviceDesController = TextEditingController();
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

  File? _logoImage;
  File? _coverImage;
  int k = 0;
  var ll = 10;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromCamera(ImageSource source, bool isLogo) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        if (isLogo) {
          _logoImage = File(pickedFile.path);
        } else {
          _coverImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  void initState() {
    Future.microtask(() => data()).whenComplete(() {
      setState(() {});
    });
    separateString();

    super.initState();
  }

  Future data() async {
    serviceNameController.text = venderSidetGetXController
        .getVendorServiceSingleDetail.serviceName
        .toString();
    serviceAmountController.text = venderSidetGetXController
        .getVendorServiceSingleDetail.servicePrice
        .toString();
    serviceDesController.text = venderSidetGetXController
        .getVendorServiceSingleDetail.description
        .toString();
    noOfSeats.text = venderSidetGetXController
        .getVendorServiceSingleDetail.noOfSeats
        .toString();
    regisNo.text = venderSidetGetXController
        .getVendorServiceSingleDetail.registrationNo
        .toString();
    makeNmodel.text = venderSidetGetXController
        .getVendorServiceSingleDetail.makeAndModel
        .toString();
    minMiles.text = venderSidetGetXController
        .getVendorServiceSingleDetail.minimumDistance
        .toString();
    maxMiles.text = venderSidetGetXController
        .getVendorServiceSingleDetail.maximumDistance
        .toString();
    _initialValueWheelChareAccessibleAurNot =
        venderSidetGetXController.getVendorServiceSingleDetail.wheelChair;
    _initialToiletFacilitiesAurNot =
        venderSidetGetXController.getVendorServiceSingleDetail.toiletFacility;
    _initialCofeemachineAurNot =
        venderSidetGetXController.getVendorServiceSingleDetail.coffeeMachine;
    _initialAironFittedAurNot =
        venderSidetGetXController.getVendorServiceSingleDetail.aironFitted;
    selectedTime = parseTime(venderSidetGetXController
        .getVendorServiceSingleDetail.bookingTime
        .toString());
    // maxDeliveryServiceDistanceController.text=venderSidetGetXController.getVendorServiceSingleDetail.maximumDistance.toString();

    // hour.text=venderSidetGetXController.getVendorServiceSingleDetail..toString();

    final sessionManager = await SessionVendorSideManager();

    dynamic categoryId = await sessionManager.getcategoryId();
    Future.microtask(() => apiServiceVenderSide.subcategoryList(categoryId))
        .whenComplete(() {
      setState(() {});
    });
  }

  IconData currentIcon = Icons.add;

  String getFormattedTime(TimeOfDay time) {
    int hour = time.hour;
    int minute = time.minute;
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    String formattedHour = hour < 10 ? '0$hour' : '$hour';
    String formattedMinute = minute < 10 ? '0$minute' : '$minute';

    return '$formattedHour:$formattedMinute $period';
  }

  // TextEditingController serviceDesController= TextEditingController();
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

  List<int> image = [];

  List<String>? _imageFiles = [];

  Future compressFile({file}) async {
    final filePath = file!.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
    var result = await FlutterImageCompress.compressAndGetFile(
      file.path.toString(),
      outPath.toString(),
      quality: 80,
    );
    return result?.path.toString();
  }

  Future<void> _pickImages(bool camera) async {
    final ImagePicker _picker = ImagePicker();
    // ImageSource.camera
    // _picker.pickImage(source: source)

    if (camera == false) {
      final List<XFile>? pickedFiles =
          await _picker.pickMultiImage(imageQuality: 50);

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          pickedFiles?.forEach((element) async {
            print("Index => ${element.path}");
            _imageFiles?.add(element.path.toString());
            // Future.microtask(
            //         () => compressFile(file: XFile(element.path.toString())))
            //     .then((value) {
            //   _imageFiles?.add(value);
            //   setState(() {});
            // });
          });
        });
      }
    }

    if (camera == true) {
      //
      dynamic image =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      if (image != null) {
        _imageFiles?.add(image.path.toString());
      }

      setState(() {});
    }
  }

  String? hours;
  String? minutesSeparate;

  separateString() {
    String timeString =
        "${venderSidetGetXController.getVendorServiceSingleDetail.bookingTime.toString()}";

    // Split the string into time and period
    List<String> parts = timeString.split(" ");

    // Extract time and period
    String time = parts[0]; // "4:05"
    String period = parts[1]; // "PM"

    // Further split time into hours and minutes
    List<String> timeParts = time.split(":");
    hours = timeParts[0]; // "4"
    minutesSeparate = timeParts[1]; // "05"

    print("Hours: $hours");
    print("Minutes: $minutes");
    print("Period: $period");
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  // TimeOfDay selectedTime = TimeOfDay(hour: int.parse("$hours"), minute: minutesSeparate); // Default time 4:05 PM

  TimeOfDay parseTime(String timeString) {
    // Create a DateFormat to parse the time string
    final inTlDateTime.DateFormat formatter = inTlDateTime.DateFormat
        .jm(); // "j" is for hour in 12-hour format, "m" for minute

    // Parse the string to a DateTime object
    DateTime dateTime = formatter.parse(timeString);

    // Return a TimeOfDay object
    return TimeOfDay.fromDateTime(dateTime);
  }

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
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    print(
        "venderSidetGetXController.getSubCategoryList=>${venderSidetGetXController.getSubCategoryList?.length}");
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const Nav_bar(),
        //     ));
        return true;
      },
      child: Scaffold(
        backgroundColor: colors.scaffold_background_color,
        appBar: AppBar(
          backgroundColor: colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Edit Service",
            style: TextStyle(fontWeight: FontWeight.bold, color: colors.black),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Nav_bar(),
                  ));
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
                const SizedBox(height: 30),
                Text("Select SubCategory",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 5), // Padding inside the button
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color of the button
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: venderSidetGetXController.initalvalueSubCategory,
                      // value: venderSidetGetXController.initalvalueSubCategory.,
                      icon: Icon(Icons.arrow_downward,
                          color: Colors.black), // Dropdown icon color
                      dropdownColor:
                          Colors.white, // Background color of dropdown items
                      elevation: 16,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          overflow: TextOverflow
                              .ellipsis), // Text style inside dropdown
                      onChanged: (String? newValue) {
                        print("newValue=>${newValue}");
                        // venderSidetGetXController.clearSubCategoryList();
                        Future.microtask(() => venderSidetGetXController!
                            .setinitalSubCategoryvalue(newValue));
                        setState(() {});
                      },
                      items:
                          // <String>[
                          //   'Sub C.. Limousine Hire',
                          //   'Sub C.. Minibus Hire',
                          //   'Sub C.. Coach Hire',
                          //   'Sub C.. Horse and Carriage Hire',
                          //   'Sub C.. Boat Hire',
                          //   'Sub C.. Funeral Car Hire',
                          //   'Sub Cate.. Chauffeur Driven Prestige Car Hire'
                          // ].

                          venderSidetGetXController.getSubCategoryList
                              ?.map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          // value: value.subcategoryId,
                          value: value.subcategoryId,
                          child: SizedBox(
                              width: w * 0.7,
                              child: Text(
                                  maxLines: 5,
                                  value.subcategoryName.toString(),
                                  overflow: TextOverflow.ellipsis)),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: serviceNameController,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "Enter Service Name",
                ),

                const SizedBox(height: 20),

                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: serviceAmountController,
                  length: 50,
                  keytype: TextInputType.number,
                  hinttext: "Enter Service Amount",
                ),

                const SizedBox(height: 20),
                const Text("Add Description*",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: serviceDesController,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "Vehicle description",
                ),
                const SizedBox(height: 20),

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
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "${(dateSelectedUser == "") ? venderSidetGetXController.getVendorServiceSingleDetail.bookingTime : dateSelectedUser}"),
                      GestureDetector(
                          onTap: () {
                            showTimePickerDialog(context);
                          },
                          child: Icon(Icons.lock_clock))
                      // Material(
                      //   elevation: 1,
                      //   borderRadius: BorderRadius.circular(7),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(7)),
                      //     height: MediaQuery.of(context).size.height / 17,
                      //     width: MediaQuery.of(context).size.width / 2.5,
                      //     child: Center(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(left: 10.0),
                      //         child: TextFormField(
                      //           controller: hour,
                      //           keyboardType: TextInputType.number,
                      //           inputFormatters: [
                      //             LengthLimitingTextInputFormatter(50)
                      //           ],
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: "Min. 1 Hour",
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Material(
                      //   elevation: 1,
                      //   borderRadius: BorderRadius.circular(7),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(7)),
                      //     height: MediaQuery.of(context).size.height / 17,
                      //     width: MediaQuery.of(context).size.width / 2.5,
                      //     child: Center(
                      //       child: Padding(
                      //         padding: const EdgeInsets.only(left: 10.0),
                      //         child: TextFormField(
                      //           controller: minutes,
                      //           keyboardType: TextInputType.number,
                      //           inputFormatters: [
                      //             LengthLimitingTextInputFormatter(50)
                      //           ],
                      //           decoration: InputDecoration(
                      //             border: InputBorder.none,
                      //             hintText: "min.",
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),

                // GestureDetector(
                //     onTap:(){
                //
                //     },
                //     child: Text("Time")),

                const SizedBox(
                  height: 10,
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    "Photo",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Container(
                  child: Wrap(
                      children: List.generate(
                          venderSidetGetXController.getVendorServiceSingleDetail
                              .serviceImage!.length, (index) {
                    // for(int i = 0; i < image.length; i++)

                    return Visibility(
                      visible: image.contains(index) ? false : true,
                      child: Container(
                        height: 120,
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 1,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Image.network(
                                  "${appUrlsVendorSide.baseUrlImages}${venderSidetGetXController.getVendorServiceSingleDetail.serviceImage![index]}",
                                  height: 100,
                                  width: 100,
                                )),
                            Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                    onTap: () {
                                      // deleteImage();
                                      image.add(index);
                                      setState(() {});
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 30,
                                      color: Colors.red,
                                    )))
                          ],
                        ),
                      ),
                    );
                  })),
                ),

                Visibility(
                  visible: (_imageFiles!.isEmpty) ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      "New Photo ",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Wrap(
                    // alignment: WrapAlignment.center,
                    // runAlignment: WrapAlignment.center,
                    children: List.generate(
                        _imageFiles!.length,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  Image.file(
                                    File(_imageFiles![index]),
                                    fit: BoxFit.cover,
                                    height: 60,
                                    width: 60,
                                  ),
                                  Positioned(
                                      top: 2,
                                      right: 2,
                                      child: GestureDetector(
                                          onTap: () {
                                            _imageFiles?.removeAt(index);
                                            setState(() {});
                                          },
                                          child: Icon(Icons.close,
                                              color: Colors.redAccent)))
                                ],
                              ),
                            )),
                  ),
                ),

                const SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(Icons.camera),
                              title: const Text('Take a Photo'),
                              onTap: () {
                                // _getImageFromCamera(ImageSource.camera, true);
                                _pickImages(true);
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('Choose from Gallery'),
                              onTap: () {
                                _pickImages(false);
                                // _getImageFromCamera(ImageSource.gallery, true);
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
                    dashPattern: [
                      5,
                      5,
                    ],
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          // border: Border.all(color: Colors.black87, width: 0.5)
                          ),
                      child: _logoImage != null
                          ? Image.file(
                              _logoImage!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.cloud_upload_outlined,
                                    // Replace with your desired icon
                                    size: h / 12.9,
                                    color: Colors.grey, // Icon color
                                  ),
                                  const Text("Upload Up to 8 Images",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loader = true;
                      });
                      Map<dynamic, dynamic>? requestedData = {
                        "serviceId":
                            "${venderSidetGetXController.getVendorServiceSingleDetail.serviceId}",
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
                        "booking_time":
                            "${hour.text.trim().toString()}${minutes.text.trim().toString()}",
                      };
                      if (dateSelectedUser == "") {
                        requestedData["booking_time"] =
                            venderSidetGetXController
                                .getVendorServiceSingleDetail.bookingTime
                                .toString();
                      } else {
                        requestedData["booking_time"] = dateSelectedUser;
                      }

                      print("image=>${image}");
                      dynamic result = image.join(
                          ', '); // This will join the elements with a comma and a space

                      print("result=>${result}");
                      if (image.isNotEmpty) {
                        print("result_requestedData_result=>${result}");
                        requestedData["index[]"] = result;
                      }
                      print("_imageFiles=>${_imageFiles}");
                      // Todo
                      Future.microtask(() =>
                              apiServiceVenderSide.updateVendorService(
                                  _imageFiles, requestedData, context))
                          .whenComplete(() {
                        setState(() {
                          loader = false;
                        });
                      });

                      // Navigator.pushReplacement(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => EditServiceScreenSecond()),
                      // );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          // if (mobile.text.isEmpty ||
                          //     shop_name.text.isEmpty ||
                          //     addressmap!.isEmpty ||
                          //     emaillllllll.text.isEmpty ||
                          //     legal_nameee.text.isEmpty ||
                          //     _logoImage == null ||
                          //     vehicleName.text.isEmpty ||
                          //     vehicleDescription.text.isEmpty
                          // // selectedOpenTime == null ||
                          // // selectedOpenTime1 == null ||
                          // // ||
                          // // _coverImage == null
                          // ) {
                          //   return Colors.grey;
                          // }
                          return Colors.green;
                        },
                      ),
                    ),
                    child: (loader)
                        ? CircularProgressIndicator(
                            color: Colors.blue,
                          )
                        : const Text(
                            "Update",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;
  bool isMapOpening = false;

  Future<void> getCurrentLocation() async {
    print("Get Current Location");
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        try {
          Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
          );
          double latitude = position.latitude;
          double longitude = position.longitude;

          // Save the latitude and longitude to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setDouble('latitude', latitude);
          await prefs.setDouble('longitude', longitude);

          print('Latitude: $latitude, Longitude: $longitude');

          // Navigate to the GmapState screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GmapStatetest()),
          ).then((result) {
            if (result != null) {
              setState(() {
                latitudemap = result['latitude'];
                longitudemap = result['longitude'];
                addressmap = result['address'];
              });
            }
          });
        } catch (e) {
          print('Error getting current location: $e');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  double? latitudemap;

  double? longitudemap;

  String? addressmap;

  bool isRowVisible = false;

  TimeOfDay? selectedOpenTime;
  TimeOfDay? selectedOpenTime1;

  TimeOfDay? selectedOpenTime2;
  TimeOfDay? selectedOpenTime3;

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning'),
          content: const Text(
              'Please enter the time after the previous close time.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _isBefore(TimeOfDay time1, TimeOfDay time2) {
    final DateTime dateTime1 = DateTime(2023, 1, 1, time1.hour, time1.minute);
    final DateTime dateTime2 = DateTime(2023, 1, 1, time2.hour, time2.minute);
    return dateTime1.isBefore(dateTime2);
  }

  deleteImage() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Permanently Delete Image"),
          content: Text(
              "You're about to permanently delete this image.This action cannot be undone, please confirm your choice."),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
