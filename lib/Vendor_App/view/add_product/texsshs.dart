// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'maptest.dart';

// class ddd extends StatefulWidget {
//   const ddd({super.key});

//   @override
//   State<ddd> createState() => _dddState();
// }

// class _dddState extends State<ddd> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: ElevatedButton(
//             onPressed: () async {
//               final result = await Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => GmapStatetest()),
//               );
//               if (result != null) {
//                 String address = result['address'];
//                 LatLng latLng = result['latLng'];

//                 // Use the address and latLng as needed
//                 print('new screen Address: $address');
//                 if (latLng != null) {
//                   print(
//                       'newscreenLatitude: ${latLng.latitude}, Longitude: ${latLng.longitude}');
//                 }
//               }
//             },
//             child: Text("next")),
//       ),
//     );
//   }
// }
