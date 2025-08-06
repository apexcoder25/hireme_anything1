import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Import the MediaType class
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../uiltis/color.dart';

class Signup extends StatefulWidget {
  Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  File? _logoImage;
  File? _coverImage;
  int k = 0;
  var ll = 10;

  @override
  void initState() {
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

  String selectedHireOption = 'Limousine Hire'; // Default selected option

  String selectedSubOption =
      'Sub C.. Limousine Hire'; // Default selected option

  TextEditingController compNameController = TextEditingController();
  TextEditingController countryRegionController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController chosseYourLocationController = TextEditingController();
  TextEditingController streetNameController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController vehicleDesController = TextEditingController();
  TextEditingController maxMiles = TextEditingController();
  TextEditingController minMiles = TextEditingController();

  bool loader = false;

  final String email = 'manishsinghsemra2@gmail.com';
  final String subject = 'Test Email';
  final String body = 'This is a test email from Flutter.';

  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query:
          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch email client.');
    }
  }

  String? number;
  String? countryCode;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final VenderSidetGetXController venderSidetGetXController =
        Get.put(VenderSidetGetXController());

    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Signup Screen",
          style: TextStyle(fontWeight: FontWeight.bold, color: colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
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
              // InkWell(
              //   onTap: (){
              //     _sendEmail();
              //   },
              //   child: Container(
              //     child:Text("Send Mail") ,
              //   ),
              // ),
              const Text("Company name*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: compNameController,
                length: 50,
                keytype: TextInputType.name,
                hinttext: "Company name",
              ),

              const SizedBox(height: 30),
              const Text("Country/Region*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: countryRegionController,
                length: 50,
                keytype: TextInputType.name,
                hinttext: "Country/Region",
              ),
              const SizedBox(height: 10),
              const Text("Name",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: nameController,
                length: 50,
                keytype: TextInputType.name,
                hinttext: "Name",
              ),

              const SizedBox(height: 30),
              const Text("Mobile Number*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
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
                  print("onChanged=>${value.number}");
                  print("onChanged=>${value.countryCode}");
                  setState(() {
                    number = value.number;
                    countryCode = value.countryCode;
                  });
                },
                onSubmitted: (phone) {
                  if (phone != null && phone.contains(RegExp(r'[0-5]'))) {
                    // Entered number contains 0, 1, 2, 3, 4, or 5
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter a valid number.'),
                      ),
                    );
                  }
                },
              ),

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

              const SizedBox(height: 30),
              const Text("Choose Your Shop Location*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),

              GestureDetector(
                onTap: () async {
                  if (isMapOpening) {
                    return;
                  }

                  isMapOpening = true;

                  setState(() {
                    isLoading = true;
                  });

                  await Future.delayed(const Duration(milliseconds: 400));

                  setState(() {
                    isLoading = false;
                  });

                  await getCurrentLocation();

                  isMapOpening = false;
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: isLoading
                          ? const CircularProgressIndicator() // Loader widget
                          : Text(addressmap ?? "Select address",
                              style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
              const Text("Add the complete Address",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: streetNameController,
                length: 50,
                keytype: TextInputType.text,
                hinttext: "Street Name and Door Number",
              ),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: pinCodeController,
                length: 50,
                keytype: TextInputType.text,
                hinttext: "Pin Code",
              ),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: cityController,
                length: 50,
                keytype: TextInputType.text,
                hinttext: "City",
              ),
              const SizedBox(height: 30),
              const Text("Select Category",
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
                    value: venderSidetGetXController.initalvalue,
                    icon: Icon(Icons.arrow_downward,
                        color: Colors.black), // Dropdown icon color
                    dropdownColor:
                        Colors.white, // Background color of dropdown items
                    elevation: 16,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16), // Text style inside dropdown
                    onChanged: (newValue) {
                      print(
                          "venderSidetGetXController.initalvalue=>${venderSidetGetXController.initalvalue}");
                      print("newValue=>${newValue}");
                      // if(venderSidetGetXController.initalvalue!=newValue){
                      venderSidetGetXController!.setinitalvalue(newValue);
                      Future.microtask(() =>
                              apiServiceVenderSide.subcategoryList(newValue))
                          .whenComplete(() {
                        setState(() {});
                      });

                      // }
                    },
                    items: venderSidetGetXController
                        .getCategoryList?.subcategoryList
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value.categoryId.toString(),
                        child: Text(value.categoryName.toString()),
                      );
                    }).toList(),
                  ),
                ),
              ),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   padding: EdgeInsets.symmetric(horizontal: 5), // Padding inside the button
              //   decoration: BoxDecoration(
              //     color: Colors.white, // Background color of the button
              //     borderRadius: BorderRadius.circular(12), // Rounded corners
              //   ),
              //   child: DropdownButtonHideUnderline(
              //     child: DropdownButton<String>(
              //
              //       value: selectedHireOption,
              //       icon: Icon(Icons.arrow_downward, color: Colors.black), // Dropdown icon color
              //       dropdownColor: Colors.white, // Background color of dropdown items
              //       elevation: 16,
              //       style: TextStyle(color: Colors.black, fontSize: 16), // Text style inside dropdown
              //       onChanged: (String? newValue) {
              //         setState(() {
              //           selectedHireOption = newValue!;
              //         });
              //       },
              //       items: <String>[
              //         'Limousine Hire',
              //         'Minibus Hire',
              //         'Coach Hire',
              //         'Horse and Carriage Hire',
              //         'Boat Hire',
              //         'Funeral Car Hire',
              //         'Chauffeur Driven Prestige Car Hire'
              //       ].map<DropdownMenuItem<String>>((String value) {
              //         return DropdownMenuItem<String>(
              //           value: value,
              //           child: Text(value),
              //         );
              //       }).toList(),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 20),
              const Text("Add Description*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              // const SizedBox(height: 10),
              // const Text("Distance in miles",
              //     style: TextStyle(color: Colors.black87, fontSize: 16)),
              // const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     Material(
              //       elevation: 1,
              //       borderRadius: BorderRadius.circular(7),
              //       child: Container(
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(7)),
              //         height: MediaQuery.of(context).size.height / 17,
              //         width: MediaQuery.of(context).size.width / 2.5,
              //         child: Center(
              //           child: Padding(
              //             padding: const EdgeInsets.only(left: 10.0),
              //             child: TextFormField(
              //               controller: minMiles,
              //               keyboardType: TextInputType.number,
              //               inputFormatters: [
              //                 LengthLimitingTextInputFormatter(50)
              //               ],
              //               decoration: InputDecoration(
              //                 border: InputBorder.none,
              //                 hintText: "Min. 50 mile",
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //     Material(
              //       elevation: 1,
              //       borderRadius: BorderRadius.circular(7),
              //       child: Container(
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(7)),
              //         height: MediaQuery.of(context).size.height / 17,
              //         width: MediaQuery.of(context).size.width / 2.5,
              //         child: Center(
              //           child: Padding(
              //             padding: const EdgeInsets.only(left: 10.0),
              //             child: TextFormField(
              //               controller: maxMiles,
              //               keyboardType: TextInputType.number,
              //               inputFormatters: [
              //                 LengthLimitingTextInputFormatter(50)
              //               ],
              //               decoration: InputDecoration(
              //                 border: InputBorder.none,
              //                 hintText: "Max 500 miles",
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(height: 10),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: vehicleDesController,
                length: 50,
                keytype: TextInputType.name,
                hinttext: "Vehicle description",
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
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
              ),
              const SizedBox(height: 20),
              const Text("Government ID",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
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
                    Map<String, dynamic>? requestedData = {
                      "country_code": "${countryCode}",
                      "mobile_no": mobileController.text.trim() ?? "",
                      "company_name": compNameController.text.trim() ?? "",
                      "country_name": countryRegionController.text.trim() ?? "",
                      "name": nameController.text.trim() ?? "",
                      "email": emailController.text.trim() ?? "",
                      "street_name": streetNameController.text.trim() ?? "",
                      "city_name": cityController.text.trim() ?? "",
                      "pincode": pinCodeController.text.trim() ?? "",
                      "latitude": "${latitudemap}",
                      "longitude": "${longitudemap}",
                      "categoryId": "${venderSidetGetXController.initalvalue}"
                    };

                    print("requestedData=>${requestedData}");

                    if (loader == true) {
                      Future.microtask(() =>
                              apiServiceVenderSide.signupPageFirst(
                                  _imageFiles, requestedData, context))
                          .whenComplete(() {
                        setState(() {
                          loader = false;
                        });

                        // /(Login());
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        return Colors.grey;
                      },
                    ),
                  ),
                  child: (loader == false)
                      ? const Text("Submit")
                      : CircularProgressIndicator(
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
                      Get.to(const Login());
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
                streetNameController.text = result['streetName'];
                pinCodeController.text = result['pincode'];
                cityController.text = result['cityName'];
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
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        setState(() {
          pickedFiles?.forEach((element) async {
            print("Index => ${element.path}");
            Future.microtask(
                    () => compressFile(file: XFile(element.path.toString())))
                .then((value) {
              _imageFiles?.add(value);
              setState(() {});
            });
          });
        });
      }
    }

    if (camera == true) {
      //
      dynamic image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _imageFiles?.add(image.path.toString());
      }

      setState(() {});
    }
  }
}
