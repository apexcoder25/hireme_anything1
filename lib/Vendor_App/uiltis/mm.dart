// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// import '../../uiltis/color.dart';

// class Signupppp extends StatefulWidget {
//   Signupppp({Key? key});

//   @override
//   State<Signupppp> createState() => _SignupState();
// }

// class _SignupState extends State<Signupppp> {
//   bool locationSelected = false;
//   double? latitudelatest;
//   double? longitudelatest;
//   int k = 0;
//   var _controller = TextEditingController();
//   var uuid = new Uuid();
//   String kkk = "d90alvgHTQ-yYTKGJhxPch:"
//       "APA91bGQCKn93TPFsEil_meZ4axhd3ywiBNAy2tijOJOtqC"
//       "0EFVGJobF6hrde6DGNOEhH05CWUI-HFKfgtFI0gxIBIQ2gPmIJv"
//       "8QrM8UsHE_SIIuFf84fMg_M99iurPIn6dL30XZiu84";
//   List<dynamic> _placeList = [];
//   String tappedPlace = "";

//   _onChanged() {
//     if (kkk == null) {
//       setState(() {
//         kkk = uuid.v4();
//       });
//     }
//     getSuggestion(_controller.text);
//     setState(() {
//       locationSelected = false;
//     });
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
//     String storedPlace = prefs.getString('tappedPlace') ?? "";
//     if (storedPlace.isNotEmpty) {
//       setState(() {
//         _controller.text = storedPlace;
//       });
//     }
//   }

//   _setTappedPlace(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('tappedPlace', value);
//     setState(() {
//       locationSelected =
//           true; // Set the flag to true when a location is selected
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller.addListener(() {
//       _onChanged();
//     });
//     _getTappedPlace();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     final w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: colors.scaffold_background_color,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: TextField(
//                   controller: _controller,
//                   decoration: InputDecoration(
//                     hintText: "Select Your Shop Store",
//                     focusColor: Colors.white,
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                     prefixIcon: Icon(Icons.search_off_rounded),
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.cancel),
//                       onPressed: () {
//                         _controller.clear();
//                       },
//                     ),
//                     border: InputBorder.none, // Remove the underline
//                   ),
//                 ),
//               ),
//               if (!locationSelected)
//                 ListView.builder(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: _placeList.length,
//                   itemBuilder: (context, index) {
//                     final place = _placeList[index];
//                     return ListTile(
//                       title: InkWell(
//                         onTap: () async {
//                           final description = place["description"];
//                           print('Tapped place..... $description');
//                           if (description.isNotEmpty) {
//                             setState(() {
//                               _controller.text = description;
//                             });
//                             _setTappedPlace(description);
//                           }
//                           await getLocationFromPlaceName(description);
//                         },
//                         child: Text(place["description"]),
//                       ),
//                     );
//                   },
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void getCoordinates(String locationName) async {
//     if (locationName.isNotEmpty) {
//       try {
//         List<Location> locations = await locationFromAddress(locationName);
//         if (locations.isNotEmpty) {
//           final Location location = locations.first;
//           final double signlatitude = location.latitude;
//           final double signlongitude = location.longitude;

//           SharedPreferences prefs = await SharedPreferences.getInstance();
//           prefs.setDouble('latitude', signlatitude);
//           prefs.setDouble('longitude', signlongitude);
//           print("signLatitude: $signlatitude, signLongitude: $signlongitude");
//         }
//       } catch (e) {
//         print("Errorrr: $e");
//       }
//     }
//   }

//   Future<void> getLocationFromPlaceName(String placeName) async {
//     try {
//       List<Location> locations = await locationFromAddress(placeName);
//       if (locations.isNotEmpty) {
//         Location location = locations.first;
//         latitudelatest = location.latitude;
//         longitudelatest = location.longitude;

//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         await prefs.setDouble('latitude', latitudelatest!);
//         await prefs.setDouble('longitude', longitudelatest!);
//         await prefs.setString('placeName',
//             placeName); // Store the place name in shared preferences

//         print('Latitude: $latitudelatest, Longitude: $longitudelatest');
//         print('Latitude: $placeName');
//       } else {
//         print('No results found for the provided place name.');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
