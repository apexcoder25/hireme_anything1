// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// class Search_pr extends StatefulWidget {
//   const Search_pr({super.key});

//   @override
//   State<Search_pr> createState() => _Search_prState();
// }

// class _Search_prState extends State<Search_pr> {
//   TextEditingController _searchController = TextEditingController();
//   String? retrievedId;

//   @override
//   void initState() {
//     super.initState();
//     getIdFromSharedPreferences().then((_) {
//       if (retrievedId != null) {
//         print('Retrieved Category shop ID: $retrievedId');
//       } else {
//         print('Retrieved Category is empty: $retrievedId');
//       }
//     });
//   }

//   Future<void> getIdFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     retrievedId = prefs.getString('id');
//     print("Retrieved Category ID: $retrievedId");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(right: 20.0, left: 20, top: 10),
//               child: TextField(
//                 controller: _searchController,
//                 decoration: InputDecoration(
//                   labelText: 'Search product',
//                   labelStyle: TextStyle(color: Colors.green),
//                   hintText: 'search product',
//                   prefixIcon: Icon(Icons.search, color: Colors.grey),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     borderSide: BorderSide(
//                         color: Colors.green), // Set the color you want
//                   ),
//                 ),
//                 onChanged: (value) {
//                   print('Search query: $value');
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> search_product() async {
//     if (retrievedId == null) {
//       print('Retrieved ID is null');
//       return;
//     }

//     final url =
//         Uri.parse('https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getVenderProfile');
//     print("inside api $retrievedId");
//     final response = await http.post(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode(<String, String>{
//         'shopId': retrievedId!,
//       }),
//     );

//     if (response.statusCode == 200) {
//       print('------------------------------------------ successful');
//       print(''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           ''''''
//           '');
//       print('Response data: ${response.body}');
//     } else {
//       print('POST request failed with status: ${response.statusCode}');
//       print('Response data: ${response.body}');
//     }
//   }
// }
