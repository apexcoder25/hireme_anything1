// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui' as ui;
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// // import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../uiltis/color.dart';

// class Qr_code extends StatefulWidget {
//   const Qr_code({Key? key});

//   @override
//   State<Qr_code> createState() => _Qr_codeState();
// }

// class _Qr_codeState extends State<Qr_code> {
//   String? id;
//   File? file;
//   String qrCode = 'Loading...';
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchIdFromSharedPreferencesAndPostData();
//     Future.delayed(Duration(seconds: 2), () {
//       // Simulate loading for 2 seconds
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }

//   Future<void> fetchIdFromSharedPreferencesAndPostData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? id = prefs.getString('id');
//     print('ID from SharedPreferences: $id');
//     if (id != null) {
//       await postData(id);
//     } else {
//       print('ID is null. Cannot make the API request.');
//     }
//   }

//   final String apiUrl =
//       'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/qrcode_list';

//   Future<void> postData(String id) async {
//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({'shopId': id}),
//       );

//       if (response.statusCode == 200) {
//         print(response.body);
//         final responseData = jsonDecode(response.body);
//         print('Result: ${responseData['result']}');
//         print('Message: ${responseData['message']}');
//         final data = responseData['data'];
//         nameshopp = data['shop_name'];
//         idshop = data['_id'];
//         print('QR Code: ${data['qr_code']}');
//         print('_id: ${data['_id']}');
//         print('Shop Name: ${data['shop_name']}');
//         print('$nameshopp');
//         print('$idshop');

//         setState(() {
//           qrCode = data['qr_code'];
//         });
//       } else {
//         print('Request failed with status: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   String nameshopp = '';
//   String idshop = '';

//   Future<void> shareQrCodeImage() async {
//     try {
//       Directory tempDir = await getTemporaryDirectory();
//       String tempPath = tempDir.path;
//       String filePath = '$tempPath/qr_code_image.png';

//       await saveQrCodeImage(filePath);
//       await Share.shareFiles(['$filePath'],
//           text: 'Check out $nameshopp  QR Code');

//       File(filePath).delete();
//     } catch (e) {
//       print('Error sharing QR code image: $e');
//     }
//   }

//   Future<void> saveQrCodeImage(String filePath) async {
//     try {
//       RenderRepaintBoundary boundary =
//           globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//       ui.Image image = await boundary.toImage();

//       ByteData? byteData =
//           await image.toByteData(format: ui.ImageByteFormat.png);

//       if (byteData != null) {
//         Uint8List pngBytes = byteData.buffer.asUint8List();
//         await File(filePath).writeAsBytes(pngBytes);
//       } else {
//         print('Error: ByteData is null');
//       }
//     } catch (e) {
//       print('Error saving QR code image: $e');
//     }
//   }

//   Future<void> downloadQrCodeImage() async {
//     try {
//       Directory? appDocDir = await getExternalStorageDirectory();
//       String appDocPath = appDocDir!.path;
//       String filePath = '$appDocPath/qr_code_image.png';

//       await saveQrCodeImage(filePath);
//       // final result = await ImageGallerySaver.saveFile(filePath);
//       //
//       // if (result['isSuccess']) {
//       //   ScaffoldMessenger.of(context).showSnackBar(
//       //     SnackBar(
//       //       content: Text('Image saved to gallery check Your gallery'),
//       //       duration: Duration(seconds: 2), // Adjust the duration as needed
//       //       backgroundColor: Colors.green,
//       //     ),
//       //   );
//       //   print('Image saved to gallery');
//       // } else {
//       //   print('Failed to save image: ${result['error']}');
//       // }

//       File(filePath).delete();
//     } catch (e) {
//       print('Error downloading QR code image: $e');
//     }
//   }

//   final GlobalKey globalKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     // return Scaffold(
//     //   backgroundColor: colors.scaffold_background_color,
//     //   appBar: AppBar(
//     //     backgroundColor: colors.white,
//     //     elevation: 0,
//     //     leading: IconButton(
//     //       onPressed: () {
//     //         Get.back();
//     //       },
//     //       icon: Icon(
//     //         Icons.arrow_back,
//     //         color: colors.black,
//     //       ),
//     //     ),
//     //     centerTitle: true,
//     //     title: Text(
//     //       "QR Code",
//     //       style: TextStyle(
//     //         fontSize: 20,
//     //         color: colors.black,
//     //         fontWeight: FontWeight.bold,
//     //       ),
//     //     ),
//     //   ),
//     //   body: isLoading
//     //       ? Center(
//     //           child: CircularProgressIndicator(
//     //             color: Colors.green,
//     //           ),
//     //         )
//     //       : SingleChildScrollView(
//     //           child: Padding(
//     //             padding: const EdgeInsets.only(
//     //                 top: 10.0, bottom: 10, left: 20, right: 20),
//     //             child: Column(
//     //               crossAxisAlignment: CrossAxisAlignment.start,
//     //               children: [
//     //                 Center(
//     //                   child: Text(
//     //                     "$nameshopp",
//     //                     style: TextStyle(
//     //                       fontSize: 20,
//     //                       color: colors.black,
//     //                       fontWeight: FontWeight.w500,
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 SizedBox(height: h / 30),
//     //                 RepaintBoundary(
//     //                   key: globalKey,
//     //                   child: GestureDetector(
//     //                     onTap: () {
//     //                       // Handle tap on the QR code if needed
//     //                     },
//     //                     child: Center(
//     //                       child: QrImageView(
//     //                         data: qrCode,
//     //                         version: QrVersions.auto,
//     //                         size: 290.0,
//     //                         backgroundColor: Colors.white,
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 SizedBox(height: h / 30),
//     //                 Material(
//     //                   color: Colors.white,
//     //                   borderRadius: BorderRadius.circular(10),
//     //                   elevation: 2,
//     //                   child: Container(
//     //                     width: w / 1,
//     //                     height: h / 15,
//     //                     decoration: BoxDecoration(
//     //                       color: Colors.white,
//     //                       borderRadius: BorderRadius.circular(10),
//     //                     ),
//     //                     child: Row(
//     //                       mainAxisAlignment: MainAxisAlignment.center,
//     //                       children: [
//     //                         Container(
//     //                           width: w / 3,
//     //                           height: h / 20,
//     //                           color: Colors.white,
//     //                           child: InkWell(
//     //                             onTap: () {
//     //                               shareQrCodeImage();
//     //                             },
//     //                             child: Row(
//     //                               children: [
//     //                                 Icon(
//     //                                   Icons.share,
//     //                                   color: Colors.black,
//     //                                 ),
//     //                                 SizedBox(
//     //                                   width: w / 20,
//     //                                 ),
//     //                                 Text(
//     //                                   "Share",
//     //                                   style: TextStyle(fontSize: 17),
//     //                                 ),
//     //                               ],
//     //                             ),
//     //                           ),
//     //                         ),
//     //                         Container(
//     //                           width: w / 300,
//     //                           height: h / 40,
//     //                           color: Colors.grey,
//     //                         ),
//     //                         Padding(
//     //                           padding: const EdgeInsets.only(left: 15.0),
//     //                           child: Container(
//     //                             width: w / 3,
//     //                             height: h / 20,
//     //                             color: Colors.white,
//     //                             child: GestureDetector(
//     //                               onTap: () {
//     //                                 downloadQrCodeImage();
//     //                               },
//     //                               child: Row(
//     //                                 children: [
//     //                                   Icon(
//     //                                     Icons.arrow_circle_down,
//     //                                     color: Colors.black,
//     //                                   ),
//     //                                   SizedBox(
//     //                                     width: w / 20,
//     //                                   ),
//     //                                   Text(
//     //                                     "Download",
//     //                                     style: TextStyle(fontSize: 17),
//     //                                   ),
//     //                                 ],
//     //                               ),
//     //                             ),
//     //                           ),
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 SizedBox(height: h / 25),
//     //                 Text(
//     //                   "Shop ID & Name",
//     //                   style: TextStyle(fontSize: 15, color: Colors.grey),
//     //                 ),
//     //                 SizedBox(height: h / 50),
//     //                 Material(
//     //                   color: Colors.white,
//     //                   borderRadius: BorderRadius.circular(10),
//     //                   elevation: 2,
//     //                   child: Container(
//     //                     width: w / 1,
//     //                     height: h / 10,
//     //                     decoration: BoxDecoration(
//     //                       color: Colors.white,
//     //                       borderRadius: BorderRadius.circular(10),
//     //                     ),
//     //                     child: Padding(
//     //                       padding: const EdgeInsets.only(
//     //                         top: 10.0,
//     //                         bottom: 10,
//     //                         left: 15,
//     //                       ),
//     //                       child: Column(
//     //                         crossAxisAlignment: CrossAxisAlignment.start,
//     //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//     //                         children: [
//     //                           Text(
//     //                             "$idshop",
//     //                             style: TextStyle(
//     //                               fontSize: 16,
//     //                               color: colors.black,
//     //                               fontWeight: FontWeight.w400,
//     //                             ),
//     //                           ),
//     //                           Text(
//     //                             "$nameshopp",
//     //                             style: TextStyle(
//     //                                 fontSize: 16,
//     //                                 color: colors.black,
//     //                                 fontWeight: FontWeight.w400),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ),
//     //                   ),
//     //                 ),
//     //               ],
//     //             ),
//     //           ),
//     //         ),
//     // );
//     return Scaffold(
//       backgroundColor: colors.scaffold_background_color,
//       appBar: AppBar(
//         backgroundColor: colors.button_color,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: colors.white,
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           "QR Code",
//           style: TextStyle(
//             fontSize: 24,
//             color: colors.white,
//             //fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: isLoading
//           ? Center(
//               child: CircularProgressIndicator(
//                 color: Colors.green,
//               ),
//             )
//           : SingleChildScrollView(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 20),
//                     Text(
//                       "$nameshopp",
//                       style: TextStyle(
//                         fontSize: 24,
//                         color: colors.black,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     // RepaintBoundary(
//                     //   key: globalKey,
//                     //   child: GestureDetector(
//                     //     onTap: () {
//                     //       // Handle tap on the QR code if needed
//                     //     },
//                     //     child: QrImageView(
//                     //       data: qrCode,
//                     //       version: QrVersions.auto,
//                     //       size: 290.0,
//                     //       backgroundColor: Colors.white,
//                     //     ),
//                     //   ),
//                     // ),
//                     RepaintBoundary(
//                       key: globalKey,
//                       child: GestureDetector(
//                         onTap: () {
//                           // Handle tap on the QR code if needed
//                         },
//                         child: Container(
//                           padding: EdgeInsets.all(16.0),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10.0),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 3,
//                                 blurRadius: 7,
//                                 offset: Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: QrImageView(
//                             data: qrCode,
//                             version: QrVersions.auto,
//                             size: 290.0,
//                             backgroundColor: Colors.white,
//                             foregroundColor: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildButton("Share", Icons.share, shareQrCodeImage),
//                         _buildButton("Download", Icons.arrow_circle_down,
//                             downloadQrCodeImage),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     _buildInfoCard("Shop ID", "$idshop"),
//                     _buildInfoCard("Shop Name", "$nameshopp"),
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }

//   Widget _buildButton(String label, IconData icon, Function() onPressed) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: Icon(icon, color: Colors.white),
//       label: Text(
//         label,
//         style: TextStyle(fontSize: 17),
//       ),
//       style: ElevatedButton.styleFrom(
//         // primary: Colors.green,
//         foregroundColor: Colors.green,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         elevation: 5,
//         // Add a subtle shadow
//         // onPrimary: Colors.white,
//         shadowColor: Colors.white,
//         // todo
//         // Text color when the button is enabled
//         // onSurface: Colors.grey,
//         // Text color when the button is disabled
//         // shadowColor: Colors.black,
//         // Shadow color
//         side: BorderSide(color: Colors.green, width: 1), // Border color
//       ).copyWith(
//         // Add a gradient to the button
//         overlayColor: MaterialStateColor.resolveWith(
//             (states) => Colors.green.withOpacity(0.2)),
//         // Add a hover effect

//         mouseCursor: MaterialStateMouseCursor.clickable,
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, String value) {
//     return Container(
//       width: double.infinity,
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(fontSize: 15, color: Colors.grey),
//               ),
//               SizedBox(height: 8),
//               Text(
//                 value,
//                 style: TextStyle(fontSize: 18, color: colors.black),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
