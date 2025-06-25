import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // Import the MediaType class
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../uiltis/color.dart';

class Delivery_boy_list extends StatefulWidget {
  const Delivery_boy_list({super.key});

  @override
  State<Delivery_boy_list> createState() => _Delivery_boy_listState();
}

class _Delivery_boy_listState extends State<Delivery_boy_list> {
  String? retrievedId;
  List<Driver> drivers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print(
            'Retrieved delevery listtttttttttttttt -------------- shop ID: $retrievedId');
        loadListWithLoader();
        //listDel();
      } else {}
    });
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
  }

  Future<void> loadListWithLoader() async {
    await Future.delayed(const Duration(seconds: 2));
    await listDel();
    setState(() {
      isLoading = true;
    });
  }

  File? _deimagee;
  // String? retrievedId;
  // bool isLoading=false;

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   getIdFromSharedPreferences().then((_) {
  //     if (retrievedId != null) {
  //       print('Retrieved delevery boy -------------- shop ID: $retrievedId');
  //     } else {}
  //   });
  // }

  // Future<void> getIdFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   retrievedId = prefs.getString('id');
  //   print("Retrieved ID: $retrievedId");
  // }

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromCamera(ImageSource source, bool isLogo) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      if (isLogo) {
        _deimagee = File(pickedFile.path);
        Navigator.pop(context);
      } else {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        backgroundColor: colors.button_color,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: colors.white,
            )),
        title: const Text("Delivery boy",
            style: TextStyle(
                fontSize: 20,
                color: colors.white,
                fontWeight: FontWeight.bold)),
      ),
      // body: isLoading
      //     ? Center(
      //         child: LoadingAnimationWidget.fourRotatingDots(
      //           color: const Color.fromARGB(255, 12, 110, 42),
      //           size: 50,
      //         ),
      //       )
      //     : drivers.isEmpty
      //         ? Center(
      //             child: Column(
      //               children: [
      //                 Lottie.asset(
      //                   'assets/gif/homeempty.json',
      //                   width: 150,
      //                   height: 150,
      //                   fit: BoxFit.cover,
      //                 ),
      //                 const Text('No data available'),
      //               ],
      //             ),
      //           )
      //         :
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
          child: Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // final driver = drivers[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      elevation: 1,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                      'assets/image/uoload_banner.png')),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'driver Name',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '1234567890',
                                    // Use the null-aware operator
                                    style: const TextStyle(),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          size: 18, color: colors.button_color),
                                      Text(
                                        '4.5',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  if (1 == 0)
                                    const Text(
                                      'Disable',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                ],
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) async {
                                  if (value == 'delete') {
                                    await deletedriver('1');
                                    // } else if (value == 'disable') {
                                    //   await updateDriverStatus('driver.driverId', '0');
                                    // } else if (value == 'enable') {
                                    //   await updateDriverStatus(
                                    //       driver.driverId, '1');
                                    // }
                                  }
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'disable',
                                    child: Text('Disable'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'enable',
                                    child: Text('Enable'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
            child: const Icon(Icons.add, size: 40),
            backgroundColor: colors.button_color,
            onPressed: () {
              // Get.to(const Add_delivery_boy());
              // _showMyDialog();
            }),
      ),
    );
  }

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('AlertDialog Title'),
  //         content:  SingleChildScrollView(
  //           child: Padding(
  //               padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   const Align(
  //                     alignment: Alignment.center,
  //                     child: Padding(
  //                       padding: EdgeInsets.only(bottom: 10.0),
  //                       child: Text("Delivery boy photo",
  //                           style: TextStyle(
  //                               color: Colors.black87,
  //                               fontSize: 16,
  //                               fontWeight: FontWeight.bold)),
  //                     ),
  //                   ),
  //                   Align(
  //                     alignment: Alignment.center,
  //                     child: GestureDetector(
  //                         onTap: () {
  //                           showModalBottomSheet(
  //                             context: context,
  //                             builder: (context) {
  //                               return Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 children: <Widget>[
  //                                   ListTile(
  //                                     leading: const Icon(Icons.camera),
  //                                     title: const Text('Take a Photo'),
  //                                     onTap: () {
  //                                       _getImageFromCamera(ImageSource.camera, true).then((value) => (){
  //
  //                                       });
  //                                       Navigator.pop(context);
  //                                       setState(() {
  //
  //                                       });
  //                                     },
  //                                   ),
  //                                   ListTile(
  //                                     leading: const Icon(Icons.photo_library),
  //                                     title: const Text('Choose from Gallery'),
  //                                     onTap: () {
  //                                       _getImageFromCamera(
  //                                           ImageSource.gallery, true);
  //           setState(() {
  //
  //           });
  //
  //
  //                                     },
  //                                   ),
  //                                 ],
  //                               );
  //                             },
  //                           );
  //                         },
  //                         child: Container(
  //                           height: 150,
  //                           width: 150,
  //                           decoration: BoxDecoration(
  //                               border: Border.all(width: 0.2),
  //                               shape: BoxShape.circle),
  //                           child: _deimagee != null
  //                               ? ClipOval(
  //                             child: Image.file(
  //                               _deimagee!,
  //                               fit: BoxFit.cover,
  //                               width: 150,
  //                               height: 150,
  //                             ),
  //                           )
  //                               : const ClipOval(
  //                             child: Icon(
  //                               Icons.person, // Replace with the desired icon
  //                               size: 100,
  //                               color: Colors
  //                                   .grey, // Replace with the desired icon color
  //                             ),
  //                           ),
  //                         )),
  //                   ),
  //                   const Padding(
  //                     padding: EdgeInsets.only(bottom: 10.0, top: 30),
  //                     child: Text("Enter Delivery boy Name*",
  //                         style: TextStyle(color: Colors.black87, fontSize: 16)),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(bottom: 30.0),
  //                     child: Signup_textfilled(
  //                       textfilled_height: 17,
  //                       textfilled_weight: 1,
  //                       textcont: name,
  //                       length: 50,
  //                       keytype: TextInputType.name,
  //                       hinttext: "Name",
  //                     ),
  //                   ),
  //                   const Padding(
  //                     padding: EdgeInsets.only(bottom: 10.0, top: 10),
  //                     child: Text("Enter Delivery boy mobile number*",
  //                         style: TextStyle(color: Colors.black87, fontSize: 16)),
  //                   ),
  //                   /* Padding(
  //               padding: const EdgeInsets.only(bottom: 30.0),
  //               child: Signup_textfilled(
  //                 textfilled_height: 17,
  //                 textfilled_weight: 1,
  //                 textcont: phone,
  //                 length: 10,
  //                 keytype: TextInputType.number,
  //                 hinttext: "Number",
  //               ),
  //             ),*/
  //
  //                   Padding(
  //                     padding: const EdgeInsets.only(bottom: 20.0),
  //                     child: IntlPhoneField(
  //                       onCountryChanged: (value) {
  //                         setState(() {
  //                           // ll = value.maxLength;
  //                         });
  //                       },
  //                       controller: phone,
  //                       flagsButtonPadding: const EdgeInsets.all(8),
  //                       decoration: const InputDecoration(
  //                         hintText: "Mobile Number",
  //                         filled: true,
  //                         fillColor: Colors.white,
  //                         border: OutlineInputBorder(
  //                           borderSide: BorderSide.none,
  //                         ),
  //                         contentPadding: EdgeInsets.symmetric(vertical: 12),
  //                       ),
  //                       initialCountryCode: 'IN',
  //                       onSubmitted: (phone) {
  //                         if (phone != null && phone.contains(RegExp(r'[0-5]'))) {
  //                           // Entered number contains 0, 1, 2, 3, 4, or 5
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             const SnackBar(
  //                               content: Text('Please enter a valid number.'),
  //                             ),
  //                           );
  //                         }
  //                       },
  //                     ),
  //                   ),
  //                   // Padding(
  //                   //   padding: const EdgeInsets.only(bottom: 50.0),
  //                   //   child: Button_widget(
  //                   //     buttontext: "Done",
  //                   //     button_height: 20,
  //                   //     button_weight: 1,
  //                   //     onpressed: () {
  //                   //       if (name.text.isEmpty || phone.text.isEmpty) {
  //                   //         ScaffoldMessenger.of(context).showSnackBar(
  //                   //           SnackBar(
  //                   //             content: Text('Please fill in all fields,'),
  //                   //             duration: Duration(seconds: 2),
  //                   //             backgroundColor: Colors.red,
  //                   //           ),
  //                   //         );
  //                   //       } else {
  //                   //         deleyboy();
  //                   //         ScaffoldMessenger.of(context).showSnackBar(
  //                   //           SnackBar(
  //                   //             content:
  //                   //                 Text('Delivery Boy Details Added Successfully'),
  //                   //             duration: Duration(seconds: 2),
  //                   //             backgroundColor: Colors.green,
  //                   //           ),
  //                   //         );
  //                   //         //Get.to(Nav_bar());
  //                   //         Get.back();
  //                   //         Get.back();
  //                   //       }
  //                   //     },
  //                   //   ),
  //                   // ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(bottom: 50.0),
  //                     child: Container(
  //                       width: double.infinity,
  //                       height: 50,
  //                       child: ElevatedButton(
  //                         onPressed: () {
  //                           if (name.text.isEmpty || phone.text.isEmpty) {
  //                             ScaffoldMessenger.of(context).showSnackBar(
  //                               const SnackBar(
  //                                 content: Text('Please fill in all fields,'),
  //                                 duration: Duration(seconds: 2),
  //                                 backgroundColor: Colors.red,
  //                               ),
  //                             );
  //                           }
  //                           if (name.text.isNotEmpty ||
  //                               phone.text.isNotEmpty ||
  //                               _deimagee != null ) {
  //                             deleyboy();
  //
  //
  //                           }
  //
  //
  //
  //                         },
  //                         style: ButtonStyle(
  //                           backgroundColor: MaterialStateProperty.resolveWith<Color>(
  //                                 (Set<MaterialState> states) {
  //                               if (name.text.isEmpty ||
  //                                   phone.text.isEmpty ||
  //                                   _deimagee == null) {
  //                                 return Colors.grey;
  //                               }
  //                               return Colors.green;
  //                             },
  //                           ),
  //                         ),
  //                         child: const Text(
  //                           "Done",
  //                           style: TextStyle(fontSize: 20),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //         ),
  //         );
  //
  //
  //     },
  //   );
  // }
  Future listDel() async {
    const String apiUrl = '';
    final Map<String, dynamic> data = {
      'shopId': '1',
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print("Response: ${response.body}");

      final parsedResponse = json.decode(response.body);
      final driversData = parsedResponse['data'];

      List<Driver> driverList = [];

      for (var driverData in driversData) {
        if (driverData['image'] != null &&
            driverData['name'] != null &&
            driverData['phone'] != null &&
            driverData['rating'] != null &&
            driverData['driverId'] != null &&
            driverData['active_status'] != null) {
          driverList.add(Driver(
            image: driverData['image'],
            name: driverData['name'],
            phone: driverData['phone'],
            rating: driverData['rating'].toDouble(),
            driverId: driverData['driverId'],
            activeStatus: driverData['active_status'],
          ));
        }
      }

      setState(() {
        drivers = driverList;
      });
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  Future deletedriver(String driverId) async {
    final url = Uri.parse('');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'driver_id': driverId,
      }),
    );

    if (response.statusCode == 200) {
      print('Driver Delete successfully');
      print('Response data: ${response.body}');

      // Remove the deleted driver from the list
      setState(() {
        drivers.removeWhere((driver) => driver.driverId == driverId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Driver deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  // Future updateDriverStatus(String driverId, String status) async {
  //   final url = Uri.parse('');
  //   final response = await http.post(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'driver_id': driverId,
  //       'status': status,
  //     }),
  //   );

  //   if (response.statusCode == 200) {
  //     print('Driver status updated successfully');
  //     print('Response data: ${response.body}');

  //     await listDel();
  //   } else {
  //     print('POST request failed with status: ${response.statusCode}');
  //     print('Response data: ${response.body}');
  //   }
  // }
  Future<void> deleyboy() async {
    final request = http.MultipartRequest('POST', Uri.parse(''));

    if (_deimagee != null) {
      final coverImageFile = await http.MultipartFile.fromPath(
        'image',
        _deimagee!.path,
        contentType: MediaType('image', 'jpeg'),
      );
      request.files.add(coverImageFile);
    }
    request.fields['shopId'] = retrievedId.toString();
    request.fields['driver_name'] = name.text.toString();
    request.fields['mob'] = phone.text.toString();
    // Add more fields as needed

    final response = await request.send();

    if (response.statusCode == 200) {
      print("detadddddddddddddddddddddddddddddddddddddddddddddddddddd");
      isLoading = true;
      navigator?.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Delivery Boy Details Added Successfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      // Get.back();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Delivery_boy_list()));

      print('Data uploaded successfully.');
    } else {
      isLoading = false;
      print('Failed to upload data. Status code: ${response.statusCode}');
    }
  }
}

class Driver {
  final String image;
  final String name;
  final int phone;
  final double rating;
  final String driverId;
  final int activeStatus; // Add this property

  Driver({
    required this.image,
    required this.name,
    required this.phone,
    required this.rating,
    required this.driverId,
    required this.activeStatus,
  });
}
