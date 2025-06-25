import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cutom_widgets/signup_textfilled.dart';
import '../../uiltis/color.dart';
import '../Navagation_bar.dart';
import '../login.dart';
import 'package:get/get.dart';
class EditServiceScreenSecond extends StatefulWidget {
  @override
  State<EditServiceScreenSecond> createState() => _EditServiceScreenSecondState();
}

class _EditServiceScreenSecondState extends State<EditServiceScreenSecond> {
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
  bool isYeswheelChaircheck = false;
  bool isNoWheelChaircheck = false;
  bool isYesToiletcheck = false;
  bool isNoToiletcheck = false;
  bool isYesAironcheck = false;
  bool isNoAironcheck = false;
  bool isYesCoffeecheck = false;
  bool isNoCoffeecheck = false;

  void _onYesWheelChairChanged(bool? value) {
    setState(() {
      isYeswheelChaircheck = value ?? false;
      if (isYeswheelChaircheck) {
        isNoWheelChaircheck = false;
      }
    });
  }

  void _onNo_onYesWheelChairChanged(bool? value) {
    setState(() {
      isNoWheelChaircheck = value ?? false;
      if (isNoWheelChaircheck) {
        isYeswheelChaircheck = false;
      }
    });
  }

  void _onYesToiletChanged(bool? value) {
    setState(() {
      isYesToiletcheck = value ?? false;
      if (isYesToiletcheck) {
        isNoToiletcheck = false;
      }
    });
  }

  void _onNoToiletChanged(bool? value) {
    setState(() {
      isNoToiletcheck = value ?? false;
      if (isNoToiletcheck) {
        isYesToiletcheck = false;
      }
    });
  }

  void _onYesAironChanged(bool? value) {
    setState(() {
      isYesAironcheck = value ?? false;
      if (isYesAironcheck) {
        isNoAironcheck = false;
      }
    });
  }

  void _onNoAironChanged(bool? value) {
    setState(() {
      isNoAironcheck = value ?? false;
      if (isNoAironcheck) {
        isYesAironcheck = false;
      }
    });
  }

  void _onYesCoffeeChanged(bool? value) {
    setState(() {
      isYesCoffeecheck = value ?? false;
      if (isYesCoffeecheck) {
        isNoCoffeecheck = false;
      }
    });
  }

  void _onNoCoffeeChanged(bool? value) {
    setState(() {
      isNoCoffeecheck = value ?? false;
      if (isNoCoffeecheck) {
        isYesCoffeecheck = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        // Navigator.pop(context);

        Get.back();

        return false;
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
                // const Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     "Fssai photo",
                //     style: TextStyle(
                //         color: Colors.grey,
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold),
                //   ),
                // ),
                // const SizedBox(height: 20),
                // Center(
                //   child: GestureDetector(
                //       onTap: () {
                //         _showImagePickerOptions();
                //       },
                //       child: Stack(
                //         children: [
                //           CircleAvatar(
                //             backgroundColor: Colors.grey,
                //             maxRadius: 60,
                //             child: _image != null
                //                 ? CircleAvatar(
                //                     backgroundImage: FileImage(_image!),
                //                     radius: 60,
                //                   )
                //                 : const CircleAvatar(
                //                     radius: 64,
                //                     backgroundColor: Colors.white,
                //                     child: Icon(
                //                       Icons.person,
                //                       size: 60,
                //                       color: Colors
                //                           .grey, // Change the color as needed
                //                     ), // Change the background color as needed
                //                   ),
                //           ),
                //         ],
                //       )),
                // ),
                // const SizedBox(height: 30),
                // // const Text("Minimum Order*",
                // //     style: TextStyle(color: Colors.black87, fontSize: 16)),
                // // const SizedBox(height: 10),
                // // Signup_textfilled(
                // //   textfilled_height: 17,
                // //   textfilled_weight: 1,
                // //   textcont: miniOrderController,
                // //   length: 50,
                // //   keytype: TextInputType.name,
                // //   hinttext: "Min_Order",
                // // ),
                // // const SizedBox(height: 30),
                // // const Text("Delivery Charge per Km*",
                // //     style: TextStyle(color: Colors.black87, fontSize: 16)),
                // // const SizedBox(height: 10),
                // // Signup_textfilled(
                // //   textfilled_height: 17,
                // //   textfilled_weight: 1,
                // //   textcont: perKmDeliveryChargeController,
                // //   length: 50,
                // //   keytype: TextInputType.name,
                // //   hinttext: "Delivery charge",
                // // ),
                // <==========  No. Of Seats ==========>
                const Text("No. Of Seats",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
                const SizedBox(height: 10),
                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: noOfSeats,
                  length: 50,
                  keytype: TextInputType.name,
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
                            Checkbox(
                                value: isYeswheelChaircheck,
                                onChanged: _onYesWheelChairChanged),
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
                          Checkbox(
                              value: isNoWheelChaircheck,
                              onChanged: _onNo_onYesWheelChairChanged),
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
                            Checkbox(
                                value: isYesToiletcheck,
                                onChanged: _onYesToiletChanged),
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
                          Checkbox(
                              value: isNoToiletcheck,
                              onChanged: _onNoToiletChanged),
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
                            Checkbox(
                                value: isYesAironcheck,
                                onChanged: _onYesAironChanged),
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
                          Checkbox(
                              value: isNoAironcheck,
                              onChanged: _onNoAironChanged),
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
                            Checkbox(
                                value: isYesCoffeecheck,
                                onChanged: _onYesCoffeeChanged),
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
                          Checkbox(
                              value: isNoCoffeecheck,
                              onChanged: _onNoCoffeeChanged),
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
                              controller: hour,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Min. 1 Hour",
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
                              controller: minutes,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "min.",
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
                      if (
                      // miniOrderController.text.isEmpty ||

                      // perKmDeliveryChargeController.text.isEmpty ||
                      // servicesvalble.text.isEmpty ||
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                            Text('Please fill in all the required fields.'),
                          ),
                        );
                      }
                      // else if (!isValidFssiNumber(fssainum.text)) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(
                      //       content: Text('Please enter correct FSSAI number.'),
                      //     ),
                      //   );
                      // }

                      else {
                        // _uploadData();
                        await UserProgressHelper.setUserProgress(2);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Nav_bar()),
                        );
                      }
                    },
                    child: const Text(
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

  // Future _uploadData() async {
  //   final url = Uri.parse(
  //       'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/vender_signup1');
  //
  //   try {
  //     var request = http.MultipartRequest('POST', url);
  //
  //     if (_image != null) {
  //       final imageFile = await http.MultipartFile.fromPath(
  //         'shop_image',
  //         _image!.path,
  //         contentType: MediaType('image', 'jpeg'),
  //       );
  //       request.files.add(imageFile);
  //     }
  //
  //     String mobileNumber = (await getMobileFromSharedPreferences()).toString();
  //     request.fields['mobile'] = mobileNumber.toString();
  //     request.fields['min_order'] = miniOrderController.text.toString();
  //     request.fields['delivery_charge'] =
  //         perKmDeliveryChargeController.text.toString();
  //
  //     request.fields['max_distance'] = servicesvalble.text.toString();
  //     request.fields['fssai_no'] = fssainum.text.toString();
  //     request.fields['flat_delivery_charge'] = faltcon.text.toString();
  //
  //     String selectedCategories = selectedCategoryIds.join(',');
  //     selectedCategories =
  //         selectedCategories.replaceAll('[', '').replaceAll(']', '');
  //     request.fields['categoryId'] = selectedCategories.toString();
  //
  //     var streamedResponse = await request.send();
  //     var response = await http.Response.fromStream(streamedResponse);
  //     if (response.statusCode == 200) {
  //       print('Data uploaded successfully 2');
  //     } else {
  //       print('Data upload failed with status code: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error during data upload: $e');
  //   }
  // }

  Future<void> _fetchCategoryList() async {
    final apiUrl = Uri.parse(
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/category_list');
    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final categoryList = json.decode(response.body)['data'] as List;
        setState(() {
          items = categoryList.map((category) {
            final categoryId = category['categoryId'].toString();
            final categoryName = category['category_name'].toString();
            categoryMap[categoryName] = categoryId;
            return categoryName;
          }).toList();
          selectedItems = [];
        });

        // Add this print statement to display the response body data
        print('Response Body Data: ${response.body}');
      } else {
        print(
            'Failed to fetch category list with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during category list fetch: $e');
    }
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
