import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_product/maptest.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/automotive_electric_hire_service/automotive_and_electric_hire.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/calenderController.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/category_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/boat_hire_service_screen.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/chauffeur_Driven_Prestige_Car_HIre.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/coach_hire_services.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/funeralCarHireService.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/horse_and_carriage_hire_service.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/limousine_hire_service.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/minibus_hire_services.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/passenger_transpost.dart';
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../uiltis/color.dart';

class AddServiceScreenFirst extends StatefulWidget {
  AddServiceScreenFirst({Key? key});

  @override
  State<AddServiceScreenFirst> createState() => _AddServiceScreenFirstState();
}

class _AddServiceScreenFirstState extends State<AddServiceScreenFirst> {
  final DropdownController controller = Get.put(DropdownController());
  final CalendarController Calendercontroller = Get.put(CalendarController());
  TextEditingController kmPriceController = TextEditingController();
  // TextEditingController selltingController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController desController = TextEditingController();

  TextEditingController jobTitleController = TextEditingController();

  TextEditingController experienceController = TextEditingController();
  TextEditingController SpecializationsController = TextEditingController();
  TextEditingController KeySkillsCompletedController = TextEditingController();
  TextEditingController KeyProjectCompletedController = TextEditingController();

  TextEditingController preferredWorkLocationsController =
      TextEditingController();
  String? selectedTimeSlot;
  String? ServiceStatus;

  final List<String> timeSlots = ["Morning", "Afternoon", "Evening", "Night"];

  bool isOneDayHire = false;
  bool isPerHourHire = false;

  bool isGDPR = false;
  bool isTNC = false;
  bool isContactDetails = false;
  bool isCookiesPolicy = false;
  bool isPrivacyPolicy = false;

  final Map<String, bool> days = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

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
    // Future.microtask(() => apiServiceVenderSide.subcategoryList(
    //     venderSidetGetXController
    //         .getCategoryList!.subcategoryList[0].categoryId)).whenComplete(() {
    //   setState(() {});
    // });

    super.initState();
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

  final VenderSidetGetXController venderSidetGetXController =
      Get.put(VenderSidetGetXController());

  // String? selectedHireOption; // Default selected option
  // String selectedSubOption = 'Sub C.. Limousine Hire'; // Default selected option

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
            _imageFiles?.add(element.path);
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

  bool loader = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final VenderSidetGetXController venderSidetGetXController =
        Get.put(VenderSidetGetXController());

    // print("venderSidetGetXController.getSubCategoryList?.subcategoryList=>${venderSidetGetXController.getSubCategoryList?.subcategoryList.length}");

    print(
        "value=> ${venderSidetGetXController.getCategoryList?.subcategoryList.length}}");

    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text("Select Category"),
                const SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 11, 14, 16),
                            width: 2), // Custom Border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.green, width: 3), // Focused Border
                      ),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: controller.selectedCategory.value,
                    hint: Text("Select Category"),
                    isExpanded: true,
                    items: controller.categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectCategory(value);
                      }
                    },
                  );
                }),

                SizedBox(height: 20),
                Text("Select Subcategory"),
                SizedBox(height: 10),

                // Subcategory Dropdown
                Obx(() {
                  return DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: const Color.fromARGB(255, 11, 14, 16),
                            width: 2), // Custom Border
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                            color: Colors.green, width: 3), // Focused Border
                      ),
                    ),
                    value: controller.selectedSubcategory.value,
                    hint: Text("Select Subcategory"),
                    isExpanded: true,
                    items: controller.subcategories.map((subcat) {
                      return DropdownMenuItem<String>(
                        value: subcat,
                        child: Text(subcat),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectSubcategory(value);
                      }
                    },
                  );
                }),

                const SizedBox(height: 40),

                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      print(controller.selectedSubcategory);
                      if (controller.selectedCategory ==
                          'Passenger Transport') {
                        if (controller.selectedSubcategory == 'Boat Hire') {
                          Get.to(BoatHireService(
                            Category: controller.selectedCategory,
                            SubCategory: controller.selectedSubcategory,
                            CategoryId: controller
                                .selectedCategoryId.value, // Pass categoryId
                            SubCategoryId:
                                controller.selectedSubcategoryId.value,
                          ));
                        } else if (controller.selectedSubcategory ==
                            'Chauffeur Driven Prestige Car Hire') {
                          Get.to(ChauffeurHireService(
                            Category: controller.selectedCategory,
                            SubCategory: controller.selectedSubcategory,
                            CategoryId: controller
                                .selectedCategoryId.value, // Pass categoryId
                            SubCategoryId:
                                controller.selectedSubcategoryId.value,
                          ));
                        } else if (controller.selectedSubcategory ==
                            'Coach Hire') {
                          Get.to(CoachHireService(
                            Category: controller.selectedCategory,
                            SubCategory: controller.selectedSubcategory,
                            CategoryId: controller
                                .selectedCategoryId.value, // Pass categoryId
                            SubCategoryId:
                                controller.selectedSubcategoryId.value,
                          ));
                        } else if (controller.selectedSubcategory ==
                            'Funeral Car Hire') {
                          Get.to(FuneralCarHireService(
                            Category: controller.selectedCategory,
                            SubCategory: controller.selectedSubcategory,
                            CategoryId: controller
                                .selectedCategoryId.value, // Pass categoryId
                            SubCategoryId:
                                controller.selectedSubcategoryId.value,
                          ));
                        } else if (controller.selectedSubcategory ==
                            'Horse and Carriage Hire') {
                          Get.to(HorseAndCarriageHireService(
                            Category: controller.selectedCategory,
                            SubCategory: controller.selectedSubcategory,
                            CategoryId: controller
                                .selectedCategoryId.value, // Pass categoryId
                            SubCategoryId:
                                controller.selectedSubcategoryId.value,
                          ));
                        } else if (controller.selectedSubcategory ==
                            'Limousine Hire') {
                          Get.to(LimousineHireService(
                            Category: controller.selectedCategory,
                            SubCategory: controller.selectedSubcategory,
                            CategoryId: controller
                                .selectedCategoryId.value, // Pass categoryId
                            SubCategoryId:
                                controller.selectedSubcategoryId.value,
                          ));
                        } else if (controller.selectedSubcategory ==
                            'Minibus Hire') {
                          Get.to(MinibusHireService(
                            Category: controller.selectedCategory,
                            SubCategory: controller.selectedSubcategory,
                            CategoryId: controller
                                .selectedCategoryId.value, // Pass categoryId
                            SubCategoryId:
                                controller.selectedSubcategoryId.value,
                          ));
                        }
                      } else if (controller.selectedCategory ==
                              'Passenger Transport' &&
                          controller.selectedSubcategory.isNotEmpty != null) {
                        Get.to(PassengerTransportService(
                          Category: controller.selectedCategory,
                          SubCategory: controller.selectedSubcategory,
                          CategoryId: controller
                              .selectedCategoryId.value, // Pass categoryId
                          SubCategoryId: controller.selectedSubcategoryId.value,
                        ));
                      } else if (controller.selectedCategory ==
                              'Automotive and Electric Hire' &&
                          controller.selectedSubcategory.isNotEmpty != null) {
                        Get.to(AutomotiveElectricHireService(
                          Category: controller.selectedCategory,
                          SubCategory: controller.selectedSubcategory,
                          CategoryId: controller
                              .selectedCategoryId.value, // Pass categoryId
                          SubCategoryId: controller.selectedSubcategoryId.value,
                        ));
                      }
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
                    child: (loader == true)
                        ? CircularProgressIndicator(
                            color: Colors.blue,
                          )
                        : const Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text(
                //       "Already have an account?",
                //       style: TextStyle(
                //           fontSize: 15,
                //           color: colors.hintext_shop,
                //           fontWeight: FontWeight.normal),
                //     ),
                //     TextButton(
                //       child: const Text("Login",
                //           textAlign: TextAlign.justify,
                //           style: TextStyle(
                //               color: colors.button_color,
                //               fontWeight: FontWeight.w600)),
                //       onPressed: () {
                //         Get.to(const Login());
                //       },
                //     )
                //   ],
                // ),
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

  submit() {
    // print("KM PRICE: ${kmPriceController}");
    if (serviceNameController.text.isEmpty) {
      return gtxSnakbar("Missing Information", "Please Enter Service Name");
    }

    if (kmPriceController.text.isEmpty) {
      return gtxSnakbar(
          "Missing Information", "Please enter the price per kilometer");
    }

    if (desController.text.isEmpty) {
      return gtxSnakbar("Missing Information", "Please Enter Description");
    }

    Map<String, dynamic> requestedData = {
      // "categoryId": "${venderSidetGetXController.initalvalue}",
      "subcategoryId": "${venderSidetGetXController.initalvalueSubCategory}",
      "service_name": "${serviceNameController.text.trim()}",
      "kilometer_price": "${kmPriceController.text}",
      // "service_price": "${mrpController.text.trim()}",
      // "final_price": "${selltingController .text.trim()}",
      // "address": "${addressmap.toString()}",
      // "city_name": "${cityController.text.trim()}",
      // "pincode": "${postCodeController.text.trim()}",
      "description": "${desController.text.trim()}",
      // "latitude": "${latitudemap}",
      // "longitude": "${longitudemap}",
    };

    Future.microtask(() => apiServiceVenderSide.addVendorService(
        _imageFiles, requestedData, context));
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
}

Widget _buildDatePicker(BuildContext context, String label,
    Rx<DateTime> selectedDate, bool isFrom) {
  final CalendarController calendarController = Get.put(CalendarController());
  return ListTile(
    title: Text(
        "$label: ${DateFormat('dd-MM-yyyy HH:mm').format(selectedDate.value)}"),
    trailing: Icon(Icons.calendar_today),
    onTap: () async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(2025, 2, 1),
        lastDate: DateTime(2025, 2, 28),
      );

      if (pickedDate != null) {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate.value),
        );

        if (pickedTime != null) {
          DateTime finalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          if (isFrom) {
            calendarController.updateDateRange(
                finalDateTime, calendarController.toDate.value);
          } else {
            calendarController.updateDateRange(
                calendarController.fromDate.value, finalDateTime);
          }
        }
      }
    },
  );
}

Widget _buildCalendarCell(DateTime date) {
  return Center(
    child: Text(
      DateFormat('d').format(date),
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    ),
  );
}
