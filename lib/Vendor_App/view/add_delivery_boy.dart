// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart'; // Import the MediaType class
// import 'package:image_picker/image_picker.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:salon_hub_beautician/constant/api_url.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../cutom_widgets/button.dart';
// import '../cutom_widgets/signup_textfilled.dart';
// import '../uiltis/color.dart';
// import 'delivery_boy_list.dart';

// class Add_delivery_boy extends StatefulWidget {
//   const Add_delivery_boy({super.key});

//   @override
//   State<Add_delivery_boy> createState() => _Add_delivery_boyState();
// }

// class _Add_delivery_boyState extends State<Add_delivery_boy> {
//   File? _deimagee;
//   String? retrievedId;
//   List<Driver> drivers = [];
//   bool isloading=false;
//   @override
//   void initState() {
//     super.initState();
//     getIdFromSharedPreferences().then((_) {
//       if (retrievedId != null) {
//         print('Retrieved delevery boy -------------- shop ID: $retrievedId');
//       } else {}
//     });
//   }

//   Future<void> getIdFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     retrievedId = prefs.getString('id');
//     print("Retrieved ID: $retrievedId");
//   }

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _getImageFromCamera(ImageSource source, bool isLogo) async {
//     final XFile? pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         if (isLogo) {
//           _deimagee = File(pickedFile.path);
//         } else {}
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: colors.scaffold_background_color,
//       appBar: AppBar(
//         backgroundColor: colors.white,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               color: colors.black,
//             )),
//         centerTitle: true,
//         title: const Text("Add delivery boy",
//             style: TextStyle(
//                 fontSize: 20,
//                 color: colors.black,
//                 fontWeight: FontWeight.bold)),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Align(
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: EdgeInsets.only(bottom: 10.0),
//                   child: Text("Delivery boy photo",
//                       style: TextStyle(
//                           color: Colors.black87,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: GestureDetector(
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         builder: (context) {
//                           return Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               ListTile(
//                                 leading: const Icon(Icons.camera),
//                                 title: const Text('Take a Photo'),
//                                 onTap: () {
//                                   _getImageFromCamera(ImageSource.camera, true);
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                               ListTile(
//                                 leading: const Icon(Icons.photo_library),
//                                 title: const Text('Choose from Gallery'),
//                                 onTap: () {
//                                   _getImageFromCamera(
//                                       ImageSource.gallery, true);
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                       height: 150,
//                       width: 150,
//                       decoration: BoxDecoration(
//                           border: Border.all(width: 0.2),
//                           shape: BoxShape.circle),
//                       child: _deimagee != null
//                           ? ClipOval(
//                               child: Image.file(
//                                 _deimagee!,
//                                 fit: BoxFit.cover,
//                                 width: 150,
//                                 height: 150,
//                               ),
//                             )
//                           : const ClipOval(
//                               child: Icon(
//                                 Icons.person, // Replace with the desired icon
//                                 size: 100,
//                                 color: Colors
//                                     .grey, // Replace with the desired icon color
//                               ),
//                             ),
//                     )),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 10.0, top: 30),
//                 child: Text("Enter Delivery boy Name*",
//                     style: TextStyle(color: Colors.black87, fontSize: 16)),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 30.0),
//                 child: Signup_textfilled(
//                   textfilled_height: 17,
//                   textfilled_weight: 1,
//                   textcont: name,
//                   length: 50,
//                   keytype: TextInputType.name,
//                   hinttext: "Name",
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 10.0, top: 10),
//                 child: Text("Enter Delivery boy mobile number*",
//                     style: TextStyle(color: Colors.black87, fontSize: 16)),
//               ),
//               /* Padding(
//                 padding: const EdgeInsets.only(bottom: 30.0),
//                 child: Signup_textfilled(
//                   textfilled_height: 17,
//                   textfilled_weight: 1,
//                   textcont: phone,
//                   length: 10,
//                   keytype: TextInputType.number,
//                   hinttext: "Number",
//                 ),
//               ),*/

//               Padding(
//                 padding: const EdgeInsets.only(bottom: 20.0),
//                 child: IntlPhoneField(
//                   onCountryChanged: (value) {
//                     setState(() {
//                       // ll = value.maxLength;
//                     });
//                   },
//                   controller: phone,
//                   flagsButtonPadding: const EdgeInsets.all(8),
//                   decoration: const InputDecoration(
//                     hintText: "Mobile Number",
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                     ),
//                     contentPadding: EdgeInsets.symmetric(vertical: 12),
//                   ),
//                   initialCountryCode: 'IN',
//                   onSubmitted: (phone) {
//                     if (phone != null && phone.contains(RegExp(r'[0-5]'))) {
//                       // Entered number contains 0, 1, 2, 3, 4, or 5
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                           content: Text('Please enter a valid number.'),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.only(bottom: 50.0),
//               //   child: Button_widget(
//               //     buttontext: "Done",
//               //     button_height: 20,
//               //     button_weight: 1,
//               //     onpressed: () {
//               //       if (name.text.isEmpty || phone.text.isEmpty) {
//               //         ScaffoldMessenger.of(context).showSnackBar(
//               //           SnackBar(
//               //             content: Text('Please fill in all fields,'),
//               //             duration: Duration(seconds: 2),
//               //             backgroundColor: Colors.red,
//               //           ),
//               //         );
//               //       } else {
//               //         deleyboy();
//               //         ScaffoldMessenger.of(context).showSnackBar(
//               //           SnackBar(
//               //             content:
//               //                 Text('Delivery Boy Details Added Successfully'),
//               //             duration: Duration(seconds: 2),
//               //             backgroundColor: Colors.green,
//               //           ),
//               //         );
//               //         //Get.to(Nav_bar());
//               //         Get.back();
//               //         Get.back();
//               //       }
//               //     },
//               //   ),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 50.0),
//                 child: Container(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (name.text.isEmpty || phone.text.isEmpty) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                             content: Text('Please fill in all fields,'),
//                             duration: Duration(seconds: 2),
//                             backgroundColor: Colors.red,
//                           ),
//                         );
//                       }
//                       if (name.text.isNotEmpty ||
//                           phone.text.isNotEmpty ||
//                           _deimagee != null) {
//                         deleyboy();

//                       } else{

//                       }
//                     },
//                     style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                         (Set<MaterialState> states) {
//                           if (name.text.isEmpty ||
//                               phone.text.isEmpty ||
//                               _deimagee == null) {
//                             return Colors.grey;
//                           }
//                           return Colors.green;
//                         },
//                       ),
//                     ),
//                     child: const Text(
//                       "Done",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   TextEditingController name = TextEditingController();
//   TextEditingController phone = TextEditingController();

//   Future<void> deleyboy() async {
//     final request = http.MultipartRequest(
//         'POST', Uri.parse(ApiUrl.baseUrl + ApiUrl.createDriverUrl));

//     if (_deimagee != null) {
//       final coverImageFile = await http.MultipartFile.fromPath(
//         'image',
//         _deimagee!.path,
//         contentType: MediaType('image', 'jpeg'),
//       );
//       request.files.add(coverImageFile);
//       request.fields['shopId'] = retrievedId.toString();
//       request.fields['driver_name'] = name.text.toString();
//       request.fields['mob'] = phone.text.toString();
//     }

//     // Add more fields as needed

//     final response = await request.send();

//     if (response.statusCode == 200) {
//       print("detadddddddddddddddddddddddddddddddddddddddddddddddddddd");
//       isloading=true;
//       // Get.back();
//       listDeliveryBoy();
//       // Navigator.of(context).pop();
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content:
//           Text('Delivery Boy Details Added Successfully'),
//           duration: Duration(seconds: 2),
//           backgroundColor: Colors.green,
//         ),
//       );
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Delivery_boy_list()));
//       // Get.back();
//       // Navigator.pop(context,true);
//       print('Data uploaded successfully.');
//     } else {
//       print('Failed to upload data. Status code: ${response.statusCode}');
//     }
//   }
//   Future listDeliveryBoy() async {
//     const String apiUrl =
//         ApiUrl.baseUrl+ApiUrl.driverListUrl;
//     final Map<String, dynamic> data = {
//       'shopId': retrievedId.toString(),
//     };

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(data),
//     );

//     if (response.statusCode == 200) {
//       print("Response: ${response.body}");

//       final parsedResponse = json.decode(response.body);
//       final driversData = parsedResponse['data'];

//       List<Driver> driverList = [];

//       for (var driverData in driversData) {
//         if (driverData['image'] != null &&
//             driverData['name'] != null &&
//             driverData['phone'] != null &&
//             driverData['rating'] != null &&
//             driverData['driverId'] != null &&
//             driverData['active_status'] != null) {
//           driverList.add(Driver(
//             image: driverData['image'],
//             name: driverData['name'],
//             phone: driverData['phone'],
//             rating: driverData['rating'].toDouble(),
//             driverId: driverData['driverId'],
//             activeStatus: driverData['active_status'],
//           ));
//         }
//       }

//       setState(() {
//         drivers = driverList;
//       });
//     } else {
//       print("Error: ${response.statusCode}");
//     }
//   }
// }
