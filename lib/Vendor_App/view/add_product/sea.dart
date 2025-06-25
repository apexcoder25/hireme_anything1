// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// class MyHomePage extends StatefulWidget {
//   @override
//   MyHomePageState createState() => MyHomePageState();
// }

// class MyHomePageState extends State<MyHomePage> {
//   var _controller = TextEditingController();
//   var uuid = new Uuid();
//   String k = "d90alvgHTQ-yYTKGJhxPch:"
//       "APA91bGQCKn93TPFsEil_meZ4axhd3ywiBNAy2tijOJOtqC"
//       "0EFVGJobF6hrde6DGNOEhH05CWUI-HFKfgtFI0gxIBIQ2gPmIJv"
//       "8QrM8UsHE_SIIuFf84fMg_M99iurPIn6dL30XZiu84";
//   List<dynamic> _placeList = [];
//   String tappedPlace = "";

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       _onChanged();
//     });
//     _getTappedPlace();
//   }

//   _onChanged() {
//     if (k == null) {
//       setState(() {
//         k = uuid.v4();
//       });
//     }
//     getSuggestion(_controller.text);
//   }

//   void getSuggestion(String input) async {
//     try {
//       String kPLACES_API_KEY =
//           "AIzaSyC85iTCGYU-pIeS9fp1agTcHYWjS5XgaxY&libraries=places";
//       String type = '(regions)';
//       String baseURL =
//           'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//       String request =
//           '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$k';
//       var response = await http.get(Uri.parse(request)); // Use Uri.parse here
//       if (response.statusCode == 200) {
//         setState(() {
//           _placeList = json.decode(response.body)['predictions'];
//         });
//       } else {
//         print(
//             'Failed to load predictions. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   _getTappedPlace() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       tappedPlace = prefs.getString('tappedPlace') ?? "";
//     });
//   }

//   _setTappedPlace(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('tappedPlace', value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         resizeToAvoidBottomInset: false,
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16.0, left: 16),
//                   child: Align(
//                     alignment: Alignment.topCenter,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black),
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       child: TextField(
//                         controller: _controller,
//                         decoration: InputDecoration(
//                           hintText: "search location",
//                           focusColor: Colors.white,
//                           floatingLabelBehavior: FloatingLabelBehavior.never,
//                           prefixIcon: Icon(
//                             Icons.search,
//                             color: Colors.grey,
//                           ),
//                           suffixIcon: _controller.text.toString() == ""
//                               ? null
//                               : IconButton(
//                                   icon: Icon(
//                                     Icons.cancel,
//                                     color: Colors.grey,
//                                   ),
//                                   onPressed: () {
//                                     _controller.clear();
//                                   },
//                                 ),
//                           border: InputBorder.none, // Remove the underline
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: _placeList.length,
//                   itemBuilder: (context, index) {
//                     final place = _placeList[index];

//                     return ListTile(
//                         title: InkWell(
//                       onTap: () async {
//                         final description = place["description"];
//                         print('Tapped place..... $description');
//                         if (tappedPlace.isNotEmpty) {
//                           setState(() {
//                             tappedPlace = description;
//                           });

//                           _setTappedPlace(tappedPlace);
//                         }
//                       },
//                       child: Text(place["description"]),
//                     ));
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
