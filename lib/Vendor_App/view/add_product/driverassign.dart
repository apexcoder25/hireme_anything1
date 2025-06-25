// import 'dart:convert';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:lottie/lottie.dart';
// import 'package:salon_hub_beautician/constant/api_url.dart';
// import 'package:salon_hub_beautician/uiltis/color.dart';
// import 'package:salon_hub_beautician/view/Navagation_bar.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class asigndelivery extends StatefulWidget {
//   const asigndelivery({super.key});
//
//   @override
//   State<asigndelivery> createState() => _Delivery_boy_listState();
// }
//
// class _Delivery_boy_listState extends State<asigndelivery> {
//   List<Driver> drivers = [];
//   bool isLoading = true;
//   String? retrievedId;
//   String? orderIddd;
//   String? userIdddd;
//   String? selectedDriverId;
//
//   @override
//   void initState() {
//     super.initState();
//     getIdFromSharedPreferences().then((_) {
//       getOrderIdAndUserIdFromSharedPreferences().then((_) {
//         if (retrievedId != null) {
//           print(
//               'Retrieved delevery listtttttttttttttt -------------- shop ID: $retrievedId');
//           loadListWithLoader();
//         } else {}
//       });
//     });
//   }
//
//   Future<void> getOrderIdAndUserIdFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     orderIddd = prefs.getString('orderId');
//     userIdddd = prefs.getString('userId');
//     print(
//         "OrderId from SharedPreferences: $orderIddd, UserId from SharedPreferences: $userIdddd");
//   }
//
//   Future<void> getIdFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     retrievedId = prefs.getString('id');
//     print("Retrieved ID: $retrievedId");
//   }
//
//   Future<void> loadListWithLoader() async {
//     await Future.delayed(Duration(seconds: 2));
//     await listDel();
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: colors.scaffold_background_color,
//       appBar: AppBar(
//         backgroundColor: colors.white,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//             onPressed: () {
//               Get.back();
//             },
//             icon: Icon(
//               Icons.arrow_back,
//               color: colors.black,
//             )),
//         title: Text("Assign boy",
//             style: TextStyle(
//                 fontSize: 20,
//                 color: colors.black,
//                 fontWeight: FontWeight.bold)),
//       ),
//       body: isLoading
//           ? Center(
//               child: LoadingAnimationWidget.fourRotatingDots(
//                 color: Color.fromARGB(255, 12, 110, 42),
//                 size: 50,
//               ),
//             )
//           : drivers.isEmpty
//               ? Center(
//                   child: Column(
//                     children: [
//                       Lottie.asset(
//                         'assets/gif/homeempty.json',
//                         width: 150,
//                         height: 150,
//                         fit: BoxFit.cover,
//                       ),
//                       Text('No data available'),
//                     ],
//                   ),
//                 )
//               : SingleChildScrollView(
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.only(left: 20.0, right: 20, top: 15),
//                     child: Column(
//                       children: [
//                         ListView.builder(
//                           physics: NeverScrollableScrollPhysics(),
//                           itemCount: drivers.length,
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             final driver = drivers[index];
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 10.0),
//                               child: Material(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 elevation: 1,
//                                 child: Container(
//                                   height:
//                                       MediaQuery.of(context).size.height / 8,
//                                   width: MediaQuery.of(context).size.width / 1,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: colors.white,
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(
//                                         right: 10.0, left: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 40,
//                                           backgroundImage: NetworkImage(
//                                               "http://103.104.74.215:3092/uploads/${driver.image}"),
//                                         ),
//                                         Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               driver.name,
//                                               style: TextStyle(
//                                                   fontSize: 17,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             Text(
//                                               driver.phone?.toString() ?? '',
//                                               // Use the null-aware operator
//                                               style: TextStyle(),
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Icon(Icons.star,
//                                                     size: 18,
//                                                     color: colors.button_color),
//                                                 Text(
//                                                   driver.rating
//                                                       .toStringAsFixed(1),
//                                                   style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 )
//                                               ],
//                                             ),
//                                             if (driver.activeStatus == 0)
//                                               Text(
//                                                 'Disable',
//                                                 style: TextStyle(
//                                                     color: Colors.red),
//                                               ),
//                                           ],
//                                         ),
//                                         ElevatedButton(
//                                           onPressed: () {
//                                             selectedDriverId = driver.driverId;
//                                             print(
//                                                 "Assign button tapped for driverId: $selectedDriverId");
//                                             assignboyyy();
//                                           },
//                                           style: ElevatedButton.styleFrom(
//                                             padding: EdgeInsets.symmetric(
//                                                 vertical: 10, horizontal: 20),
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(15.0),
//                                               side: BorderSide(
//                                                   color: Colors
//                                                       .black), // White border
//                                             ),
//                                             backgroundColor: Colors
//                                                 .green, // Green background
//                                           ),
//                                           child: Text(
//                                             'Assign',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               color: Colors.white, // White text
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//     );
//   }
//
//   void showSuccessAlert(BuildContext context) {
//     CoolAlert.show(
//       confirmBtnText: "Done",
//       cancelBtnText: "To Home Page",
//       showCancelBtn: true,
//       context: context,
//       autoCloseDuration: Duration(seconds: 3),
//       animType: CoolAlertAnimType.slideInDown,
//       type: CoolAlertType.success,
//       confirmBtnColor: Colors.amberAccent,
//       text: "Boy Assigned Successfully",
//     ).then((value) {
//       Future.delayed(Duration(microseconds: 200), () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => Nav_bar()),
//         );
//       });
//     });
//   }
//
//   Future listDel() async {
//     const String apiUrl ='';
//     final Map<String, dynamic> data = {
//       'shopId': retrievedId.toString(),
//     };
//
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(data),
//     );
//
//     if (response.statusCode == 200) {
//       print("Response: ${response.body}");
//
//       final parsedResponse = json.decode(response.body);
//       final driversData = parsedResponse['data'];
//
//       List<Driver> driverList = [];
//
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
//
//       setState(() {
//         drivers = driverList;
//       });
//     } else {
//       print("Error: ${response.statusCode}");
//     }
//   }
//
//   Future assignboyyy() async {
//     if (retrievedId == null) {
//       print('Retrieved ID is null');
//       return;
//     }
//
//     final url =
//         Uri.parse('');
//     print("inside api $retrievedId");
//     final response = await http.post(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'shopId': retrievedId!,
//         'orderId': orderIddd.toString(),
//         'userId': userIdddd.toString(),
//         'driverId': selectedDriverId.toString(),
//       }),
//     );
//
//     if (response.statusCode == 200) {
//       print('Response data: ${response.body}');
//       showSuccessAlert(context);
//     } else {
//       print('POST request failed with status: ${response.statusCode}');
//       print('Response data: ${response.body}');
//     }
//   }
// }
//
// class Driver {
//   final String image;
//   final String name;
//   final int phone;
//   final double rating;
//   final String driverId;
//   final int activeStatus;
//
//   Driver({
//     required this.image,
//     required this.name,
//     required this.phone,
//     required this.rating,
//     required this.driverId,
//     required this.activeStatus,
//   });
// }
