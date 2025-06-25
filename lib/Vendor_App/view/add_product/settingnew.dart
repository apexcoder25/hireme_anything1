// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../uiltis/color.dart';
// import 'LoyaltyCardview.dart';
// import 'cardloy.dart';
// import 'edit.dart';

// class settingone extends StatefulWidget {
//   const settingone({Key? key});

//   @override
//   State<settingone> createState() => _ProfileState();
// }

// class _ProfileState extends State<settingone> {
//   String? retrievedId;
//   String response = "";
//   SharedPreferences? prefs;

//   String apiUrl = 'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getVenderProfile';

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: colors.white,
//       appBar: AppBar(
//         title: Text('Setting'),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
//           child: SafeArea(
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     SizedBox(
//                       height: h / 8,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => EditableNameWidget()),
//                               );
//                             },
//                             child: Icon(Icons.update_sharp),
//                           ),
//                           GestureDetector(
//                             onTap: () async {
//                               SharedPreferences prefs =
//                                   await SharedPreferences.getInstance();
//                               String? loyaltyId = prefs.getString('loyaltyId');
//                               if (loyaltyId == null) {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Loyal()),
//                                 );
//                               } else {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           MyGradientContainer()),
//                                 );
//                               }
//                             },
//                             child: Icon(Icons.card_giftcard),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: w / 15,
//                     ),
//                     SizedBox(
//                       height: h / 8,
//                       width: w / 1.5,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           EditableNameWidget()),
//                                 );
//                               },
//                               child: const Text(
//                                 "Update",
//                                 style: TextStyle(color: colors.black),
//                               )),
//                           TextButton(
//                               onPressed: () async {
//                                 SharedPreferences prefs =
//                                     await SharedPreferences.getInstance();
//                                 String? loyaltyId =
//                                     prefs.getString('loyaltyId');
//                                 if (loyaltyId == null) {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Loyal()),
//                                   );
//                                 } else {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             MyGradientContainer()),
//                                   );
//                                 }
//                               },
//                               child: const Text("Loyalty Card",
//                                   style: TextStyle(color: colors.black))),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: h / 8,
//                       width: w / 10,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           EditableNameWidget(),
//                                     ));
//                               },
//                               icon: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 color: Colors.grey,
//                               )),
//                           IconButton(
//                               onPressed: () async {
//                                 SharedPreferences prefs =
//                                     await SharedPreferences.getInstance();
//                                 String? loyaltyId =
//                                     prefs.getString('loyaltyId');
//                                 if (loyaltyId == null) {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) => Loyal()),
//                                   );
//                                 } else {
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             MyGradientContainer()),
//                                   );
//                                 }
//                               },
//                               icon: const Icon(
//                                 Icons.keyboard_arrow_right,
//                                 color: Colors.grey,
//                               )),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
