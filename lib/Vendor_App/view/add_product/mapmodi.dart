// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// class g extends StatefulWidget {
//   @override
//   _GmapState createState() => _GmapState();
// }

// class _GmapState extends State<g> {
//   Completer<GoogleMapController> _controller = Completer();
//   Set<Marker> markers = Set();
//   String tappedAddress = '';
//   bool locationSelected = false;
//   int k = 0;
//   var _controllerr = TextEditingController();
//   var uuid = new Uuid();
//   String address = '';
//   String kkk =
//       "d90alvgHTQ-yYTKGJhxPch:APA91bGQCKn93TPFsEil_meZ4axhd3ywiBNAy2tijOJOtqC0EFVGJobF6hrde6DGNOEhH05CWUI-HFKfgtFI0gxIBIQ2gPmIJv8QrM8UsHE_SIIuFf84fMg_M99iurPIn6dL30XZiu84";
//   List<dynamic> _placeList = [];
//   String tappedPlace = "";

//   _onChanged() {
//     if (kkk == null) {
//       setState(() {
//         kkk = uuid.v4();
//       });
//     }
//     getSuggestion(_controllerr.text);
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
//       var response = await http.get(Uri.parse(request));
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
//         _controllerr.text = storedPlace;
//       });
//     }
//   }

//   _setTappedPlace(String value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('tappedPlace', value);
//     setState(() {
//       locationSelected = true;
//     });
//   }

//   _onMapTapped(LatLng latLng) async {
//     tappedAddress = "Tapped Location";
//     tappedPlace =
//         "Latitude: ${latLng.latitude}, Longitude: ${latLng.longitude}";

//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
//     if (placemarks.isNotEmpty) {
//       Placemark placemark = placemarks.first;
//       tappedPlace += "\nAddress: ${getFullAddress(placemark)}";
//     }

//     setState(() {
//       markers.clear();
//       markers.add(
//         Marker(
//           markerId: MarkerId('Tapped Location'),
//           position: latLng,
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         ),
//       );

//       // Clear the address before appending the new one
//       address = '';
//       address = getFullAddress(placemarks.first);
//     });

//     _setTappedPlace(address);
//     print('Tapped place: $tappedPlace');
//   }

//   String getFullAddress(Placemark placemark) {
//     if (placemark.street != null && placemark.street!.isNotEmpty) {
//       address += '${placemark.street}, ';
//     }
//     if (placemark.subLocality != null && placemark.subLocality!.isNotEmpty) {
//       address += '${placemark.subLocality}, ';
//     }
//     if (placemark.locality != null && placemark.locality!.isNotEmpty) {
//       address += '${placemark.locality}, ';
//     }
//     if (placemark.administrativeArea != null &&
//         placemark.administrativeArea!.isNotEmpty) {
//       address += '${placemark.administrativeArea}, ';
//     }
//     if (placemark.country != null && placemark.country!.isNotEmpty) {
//       address += '${placemark.country}';
//     }
//     return address;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controllerr.addListener(() {
//       _onChanged();
//     });
//     _getTappedPlace();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Column(
//         children: [
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
//               child: Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 child: TextField(
//                   controller: _controllerr,
//                   decoration: InputDecoration(
//                     hintText: "Select Your Shop Store",
//                     focusColor: Colors.white,
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                     prefixIcon: Icon(Icons.search_off_rounded),
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.cancel),
//                       onPressed: () {
//                         _controllerr.clear();
//                       },
//                     ),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           if (!locationSelected)
//             ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: _placeList.length,
//               itemBuilder: (context, index) {
//                 final place = _placeList[index];
//                 return ListTile(
//                   title: InkWell(
//                     onTap: () async {
//                       final description = place["description"];
//                       if (description.isNotEmpty) {
//                         setState(() {
//                           _controllerr.text = description;
//                         });
//                         _setTappedPlace(description);
//                         List<Location> locations =
//                             await locationFromAddress(description);
//                         if (locations.isNotEmpty) {
//                           Location tappedLocation = locations.first;
//                           setState(() {
//                             markers.clear();
//                             markers.add(
//                               Marker(
//                                 markerId: MarkerId('Tapped Location'),
//                                 position: LatLng(tappedLocation.latitude,
//                                     tappedLocation.longitude),
//                                 icon: BitmapDescriptor.defaultMarkerWithHue(
//                                     BitmapDescriptor.hueRed),
//                               ),
//                             );
//                           });
//                           GoogleMapController controller =
//                               await _controller.future;
//                           controller.animateCamera(
//                             CameraUpdate.newCameraPosition(
//                               CameraPosition(
//                                 target: LatLng(tappedLocation.latitude,
//                                     tappedLocation.longitude),
//                                 zoom: 15.0,
//                               ),
//                             ),
//                           );
//                         }
//                       }
//                     },
//                     child: Text(place["description"]),
//                   ),
//                 );
//               },
//             ),
//           SizedBox(
//             height: 5,
//           ),
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               onTap: _onMapTapped,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(22.518, 88.3832),
//                 zoom: 12.0,
//               ),
//               markers: markers,
//               mapType: MapType.terrain,
//               minMaxZoomPreference: MinMaxZoomPreference(5, 22),
//             ),
//           ),
//           Container(
//               child: Center(
//                   child: Padding(
//             padding: const EdgeInsets.all(30.0),
//             child: Column(
//               children: [
//                 Text("$address",
//                     style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black87,
//                         fontWeight: FontWeight.bold)),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   //width: double.infinity,
//                   width: 125,
//                   height: 45,

//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pop(context, {
//                         'address': address,
//                         'latLng':
//                             markers.isNotEmpty ? markers.first.position : null,
//                       });
//                     },
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.green,
//                     ),
//                     child: Text('Confirm',
//                         style: TextStyle(
//                             color: Colors.white, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//           ))),
//         ],
//       ),
//     );
//   }
// }
