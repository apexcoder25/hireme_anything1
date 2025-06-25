// import 'dart:async';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:beyeeman_dwa_seller/controller/response.dart';
// import 'package:provider/provider.dart';
//
// class LiveTrackingMap extends StatefulWidget {
//   const LiveTrackingMap({
//     Key? key,
//     required this.destination,
//     required this.orderId,
//   }) : super(key: key);
//   final String destination;
//   final String orderId;
//
//   @override
//   State<LiveTrackingMap> createState() => _LiveTrackingMapState();
// }
//
// class _LiveTrackingMapState extends State<LiveTrackingMap> {
//   final Completer<GoogleMapController> _controller = Completer();
//   CameraPosition? _cameraPosition;
//   Position? _currentLocation;
//   Map<PolylineId, Polyline> polylines = {};
//   PolylinePoints polylinePoints = PolylinePoints();
//
//   Marker? destinationPosition;
//   late Timer _timer;
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     _init();
//     setCustomMarkerIcon();
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
//       // getLiveLocation();
//     });
//   }
//
//   _init() async {
//     _cameraPosition = CameraPosition(
//       target: LatLng(0, 0), // Example initial lat and lng
//       zoom: 15,
//     );
//     // _initLocation();
//     // getLiveLocation();
//     getNavigationToDropLocation();
//   }
//
//   // getLiveLocation() async {
//   //   final serviceProvider = Provider.of<Services>(context, listen: false);
//   //   await serviceProvider.driverLiveLatLongApi(widget.orderId.toString());
//   //
//   //   if (serviceProvider
//   //       .driverLiveLatLong!.data!.location!.coordinates!.first.isNotEmpty) {
//   //     List<String>? coordinates =
//   //         serviceProvider.driverLiveLatLong!.data!.location!.coordinates;
//   //     print(coordinates.toString() + " cnjsdhnvji");
//   //     if (coordinates != null && coordinates.length == 2) {
//   //       double latitude = double.parse(coordinates[0]);
//   //       double longitude = double.parse(coordinates[1]);
//   //
//   //       // Update the camera position with the live location
//   //       setState(() {
//   //         _currentLocation = Position(
//   //             longitude: longitude,
//   //             latitude: latitude,
//   //             timestamp: DateTime.now(),
//   //             accuracy: 0.0,
//   //             altitude: 0.0,
//   //             altitudeAccuracy: 0.0,
//   //             heading: 0.0,
//   //             headingAccuracy: 0.0,
//   //             speed: 0.0,
//   //             speedAccuracy: 0.0);
//   //         _cameraPosition = CameraPosition(
//   //           target: LatLng(latitude, longitude),
//   //           zoom: 18,
//   //         );
//   //       });
//   //       moveToPosition(LatLng(latitude, longitude));
//   //     }
//   //   }
//   // }
//
//   moveToPosition(LatLng latLng) async {
//     GoogleMapController mapController = await _controller.future;
//     getNavigationToDropLocation();
//     mapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: latLng,
//           zoom: 18,
//         ),
//       ),
//     );
//   }
//
//   Future<LatLng> convertAddressToLatLng(String address) async {
//     try {
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         Location location = locations.first;
//         // return LatLng(location.latitude, location.longitude);
//         return LatLng(23.2304474,77.4139229);
//       }
//     } catch (e) {
//       print('Error converting address to coordinates: $e');
//     }
//     return LatLng(0, 0);
//   }
//
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
//
//   Future<Uint8List> resizeImage(String imagePath, int width, int height) async {
//     ByteData data = await rootBundle.load(imagePath);
//     ui.Codec codec = await ui.instantiateImageCodec(
//       data.buffer.asUint8List(),
//       targetWidth: width,
//       targetHeight: height,
//     );
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   void setCustomMarkerIcon() async {
//     Uint8List resizedIconBytes =
//     await resizeImage("assets/image/deliveryboyyy.png", 120, 120);
//     currentLocationIcon = BitmapDescriptor.fromBytes(resizedIconBytes);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     print("_currentLocation!.latitude=>${_currentLocation?.latitude}");
//     print("_currentLocation!.latitude=>${_currentLocation?.longitude}");
//     // final serviceProvider = Provider.of<Services>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         title: Text(
//           "Order Tracking",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: h / 1.12,
//             child: Stack(
//               children: [
//                 GoogleMap(
//                   mapType: MapType.normal,
//                   zoomControlsEnabled: false,
//                   polylines: Set<Polyline>.of(polylines.values),
//                   initialCameraPosition: _cameraPosition!,
//                   markers: {
//                     if (destinationPosition != null) destinationPosition!,
//                     if (_currentLocation != null)
//                       Marker(
//                         markerId: const MarkerId("currentLocation"),
//                         icon: currentLocationIcon,
//                         position: LatLng(_currentLocation!.latitude,
//                             _currentLocation!.longitude),
//                         draggable: true,
//                         onDragEnd: (value) {},
//                       ),
//                   }
//                   ,
//                   onMapCreated: (GoogleMapController controller) {
//                     if (!_controller.isCompleted) {
//                       _controller.complete(controller);
//                     }
//                   },
//                 ),
//                 // if (_currentLocation == null)
//                 //   const Center(child: CircularProgressIndicator()),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   getNavigationToDropLocation() async {
//     // LatLng dropLatLng = await convertAddressToLatLng(widget.destination);
//     LatLng dropLatLng = await convertAddressToLatLng(widget.destination);
//     destinationPosition = Marker(
//       markerId: const MarkerId('destination'),
//       position: dropLatLng,
//       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//     );
//
//     getDirections(dropLatLng);
//   }
//
//   getDirections(LatLng dst, {List<LatLng>? oldPolylineCoordinates}) async {
//     List<LatLng> polylineCoordinates = [];
//     List<dynamic> points = [];
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyAibWV0NM3Z51ZB0qIeKfxBBFs3vYZxUuM', // Replace with your API key
//       PointLatLng(_currentLocation!.latitude, _currentLocation!.longitude),
//       PointLatLng(dst.latitude, dst.longitude),
//       travelMode: TravelMode.driving,
//     );
//
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//         points.add({'lat': point.latitude, 'lng': point.longitude});
//       });
//     } else {
//       print(result.errorMessage);
//     }
//
//     setState(() {
//       polylines.clear();
//       addPolyLine(polylineCoordinates);
//     });
//   }
//
//   addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.blue,
//       points: polylineCoordinates,
//       width: 5,
//     );
//     polylines[id] = polyline;
//   }
// }
//
//
//
// // import 'dart:async';
// // import 'dart:ui' as ui;
// //
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:geocoding/geocoding.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:provider/provider.dart';
//
// class LiveTrackingMap2 extends StatefulWidget {
//   const LiveTrackingMap2({
//     Key? key,
//     required this.destination,
//     required this.orderId,
//   }) : super(key: key);
//   final String destination;
//   final String orderId;
//
//   @override
//   State<LiveTrackingMap2> createState() => _LiveTrackingMap2State();
// }
//
// class _LiveTrackingMap2State extends State<LiveTrackingMap2> {
//   final Completer<GoogleMapController> _controller = Completer();
//   CameraPosition? _cameraPosition;
//   Position? _currentLocation;
//   Map<PolylineId, Polyline> polylines = {};
//   PolylinePoints polylinePoints = PolylinePoints();
//   Marker? destinationPosition;
//   late Timer _timer;
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _init();
//     setCustomMarkerIcon();
//     _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
//       getLiveLocation();
//     });
//   }
//
//   Future<void> _init() async {
//     _cameraPosition = CameraPosition(
//       target: LatLng(0, 0), // Example initial lat and lng
//       zoom: 15,
//     );
//     await getLiveLocation();
//     await getNavigationToDropLocation();
//   }
//
//   Future<void> getLiveLocation() async {
//     try {
//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//       setState(() {
//         _currentLocation = position;
//         _cameraPosition = CameraPosition(
//           target: LatLng(_currentLocation!.latitude, _currentLocation!.longitude),
//           zoom: 18,
//         );
//       });
//       moveToPosition(LatLng(_currentLocation!.latitude, _currentLocation!.longitude));
//     } catch (e) {
//       print('Error getting location: $e');
//     }
//   }
//
//   Future<void> moveToPosition(LatLng latLng) async {
//     GoogleMapController mapController = await _controller.future;
//     mapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: latLng,
//           zoom: 18,
//         ),
//       ),
//     );
//     await getNavigationToDropLocation(); // Ensure directions are drawn after moving the map
//   }
//
//   Future<LatLng> convertAddressToLatLng(String address) async {
//     try {
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         Location location = locations.first;
//         return LatLng(location.latitude, location.longitude);
//       }
//     } catch (e) {
//       print('Error converting address to coordinates: $e');
//     }
//     return LatLng(0, 0); // Return a default value if an error occurs
//   }
//
//   BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;
//
//   Future<Uint8List> resizeImage(String imagePath, int width, int height) async {
//     ByteData data = await rootBundle.load(imagePath);
//     ui.Codec codec = await ui.instantiateImageCodec(
//       data.buffer.asUint8List(),
//       targetWidth: width,
//       targetHeight: height,
//     );
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   void setCustomMarkerIcon() async {
//     Uint8List resizedIconBytes =
//     await resizeImage("assets/image/deliveryboyyy.png", 120, 120);
//     currentLocationIcon = BitmapDescriptor.fromBytes(resizedIconBytes);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         centerTitle: true,
//         title: Text(
//           "Order Tracking",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: Container(
//         height: h / 1.12,
//         child: Stack(
//           children: [
//             GoogleMap(
//               mapType: MapType.normal,
//               zoomControlsEnabled: false,
//               polylines: Set<Polyline>.of(polylines.values),
//               initialCameraPosition: _cameraPosition!,
//               markers: {
//                 if (destinationPosition != null) destinationPosition!,
//                 if (_currentLocation != null)
//                   Marker(
//                     markerId: const MarkerId("currentLocation"),
//                     icon: currentLocationIcon,
//                     position: LatLng(_currentLocation!.latitude,
//                         _currentLocation!.longitude),
//                   ),
//               },
//               onMapCreated: (GoogleMapController controller) {
//                 if (!_controller.isCompleted) {
//                   _controller.complete(controller);
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> getNavigationToDropLocation() async {
//     LatLng dropLatLng = await convertAddressToLatLng(widget.destination);
//     setState(() {
//       destinationPosition = Marker(
//         markerId: const MarkerId('destination'),
//         position: dropLatLng,
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       );
//     });
//     await getDirections(dropLatLng);
//   }
//
//   Future<void> getDirections(LatLng dst) async {
//     if (_currentLocation == null) return;
//
//     List<LatLng> polylineCoordinates = [];
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       'AIzaSyBL-NPdBE4Mmcr7l5qaA5GwEs2w-yQcjEM', // Replace with your API key
//       PointLatLng(_currentLocation!.latitude, _currentLocation!.longitude),
//       PointLatLng(dst.latitude, dst.longitude),
//       travelMode: TravelMode.driving, // Change to TravelMode.bicycling for bike routes
//     );
//
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//
//     setState(() {
//       polylines.clear();
//       addPolyLine(polylineCoordinates);
//     });
//   }
//
//   void addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId('poly');
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.blue,
//       points: polylineCoordinates,
//       width: 5,
//     );
//     polylines[id] = polyline;
//   }
// }
