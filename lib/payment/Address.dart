import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utilities/constant.dart';

class Address extends StatefulWidget {
  var lat;
  var long;
  var addredss;
  var pincode;
  var street;
   Address({
    this.lat,
     this.long,
     this.addredss,
     this.pincode,
     this.street,
    super.key,
  });

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  String name = "";
  String locality = "";
  String postalCode = "";
  // String country = "";
  String address = "";

  TextEditingController searchController = new TextEditingController();
  TextEditingController Line = new TextEditingController();
  TextEditingController street = new TextEditingController();
  TextEditingController pincode = new TextEditingController();
  // TextEditingController country1 = new TextEditingController();
  TextEditingController state = new TextEditingController();

  LatLng? _center;
  late GoogleMapController? controller1;
  String _locationName = '';
  double zoomLevel = 15.0;
  Set<Marker> markers = {};
  List<String> suggestions = [];
  bool mapInitialized = false;
  bool toggle = false;



  @override
  void initState() {
    super.initState();

    _center = LatLng(double.parse(widget.lat),double.parse(widget.long));
    _getLocationName(_center!);
  }

  Future<void> searchAddress(String query) async {
    if (controller1 == null) {
      return; // Return early if controller1 is null
    }
    List<Location> locations = await locationFromAddress(query);
    if (locations.isNotEmpty) {
      Location location = locations.first;
      setState(() {
        markers = {
          Marker(
            markerId: MarkerId('selected_location'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
              title: query,
            ),
          ),
        };
        if (controller1 != null) {
          controller1!.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(location.latitude, location.longitude),
              zoomLevel,
            ),
          );
        }
      });
    }
  }

  String? city;
  String? lat;
  String? long;
  String? country;

  void _onMapTapped(LatLng tappedPoint) async {
    // Add a marker at the tapped location
    setState(() {
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
      ));
    });

    // Fetch the address corresponding to the tapped location
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        tappedPoint.latitude,
        tappedPoint.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        Line.text = "${placemark.name}";
        street.text = "${placemark.locality}";
        pincode.text = "${placemark.postalCode}";
        // country1.text = "${placemark.country}";
        address = "${placemark.name}, ${placemark.locality}, ${placemark.postalCode}";
        state.text=placemark.administrativeArea.toString();
        city=placemark.locality.toString();
        lat= tappedPoint.latitude.toString();
        long= tappedPoint.longitude.toString();
        country= placemark.country.toString();

        // "${placemark.country}";
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
  }

  Future<void> _getLocationName(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        _locationName =
            placemarks.isNotEmpty ? placemarks[0].locality ?? '' : 'Indore';
      });
    } catch (e) {
      print('Error fetching location name: $e');
    }
  }

  bool tagcolor = true;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Navi(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
        automaticallyImplyLeading: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Addressess",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 200,
            child: Stack(
              children: [
                GoogleMap(
                  zoomControlsEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: _center!,
                    zoom: zoomLevel,
                  ),
                  onTap: _onMapTapped,
                  onMapCreated: (GoogleMapController controller) {
                    if (!mapInitialized) {
                      setState(() {
                        controller1 = controller;
                        mapInitialized = true;
                      });
                      searchAddress(searchController.text);
                    }
                  },
                  markers: markers,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for address',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            String query = searchController.text;
                            if (query.isNotEmpty) {
                              searchAddress(query);
                            }
                          },
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          Future.delayed(const Duration(seconds: 3), () {
                            searchAddress(value);
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: h / 90,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your location (Apartment / Road / Line) ",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: Line,
                  decoration:  InputDecoration(
                    hintText: '${widget.addredss}',
                    // Placeholder text
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    // Placeholder text
                    enabled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black)), // Border style
                    // Border style
                  ),
                ),
                SizedBox(
                  height: h / 50,
                ),
                Text(
                  "Street",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: street,
                  decoration: InputDecoration(
                    hintText: '${widget.street}',
                    // Placeholder text
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    // Placeholder text
                    enabled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black)), // Border style
                    // Border style
                  ),
                ),
                SizedBox(
                  height: h / 50,
                ),
                Text(
                  "Pincode",
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                TextField(
                  controller: pincode,
                  decoration:  InputDecoration(
                    hintText: '${widget.pincode}',
                    // Placeholder text
                    hintStyle: TextStyle(color: Colors.black, fontSize: 12),
                    // Placeholder text
                    enabled: true,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black)), // Border style
                    // Border style
                  ),
                ),
                SizedBox(
                  height: h / 50,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tagcolor = !tagcolor;
                          // tag = "Home";
                        });
                        //Get.to(DashBoardScreen());
                      },
                      child: Container(
                        height: h / 18,
                        width: w / 3.5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            color: tagcolor == true
                                ? kSecondaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/home.png",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: w / 90,
                            ),
                            Text(
                              "Home",
                              style: TextStyle(
                                  letterSpacing: 2.5,
                                  color: tagcolor == true
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: "Amazon_bold",
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w / 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          tagcolor = !tagcolor;
                          // tag = "Other";
                        });
                      },
                      child: Container(
                        height: h / 18,
                        width: w / 3.5,
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                            color: tagcolor == false
                                ? kSecondaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300, blurRadius: 3)
                            ]),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/location.png",
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: w / 90,
                            ),
                            Text(
                              "Other",
                              style: TextStyle(
                                  letterSpacing: 2.5,
                                  color: tagcolor == 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontFamily: "Amazon_bold",
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h / 80,
                ),
                InkWell(
                  onTap: () {
                    // ${place.street} ${place.subLocality} ${place.administrativeArea.toString()} ${place.postalCode.toString()} ${place.country.toString()}
                    Map<String,dynamic>? data ={
                      "street": "${street.text}",
                      'address': "${street.text} ${city} ${Line.text.trim()} ${state.text} ${pincode.text.toString()} ${country}",
                      'pincode':  pincode.text.toString(),
                      "state": state.text,
                      "city_name":  city ,
                      "latitude": lat,
                      "longitude": long
                    };

                    Future.microtask(() =>apiServiceUserSide.updateUserAddress(data)).whenComplete((){
                      Get.to(Navi());
                      setState(() {

                      });
                    });
                    // Navigator.pop(context,
                    //     MaterialPageRoute(builder: (context) => Navi()));
                    // updateUserAddress

                    // Map<String, dynamic> data = {
                    //   "line_1": Line.text.toString(),
                    //   "street": street.text.toString(),
                    //   "pincode": int.parse(pincode.text),
                    //   "city": street.text.toString(),
                    //   "state": "Not Available",
                    // };
                    //ApiService.postAddress(data);
                    // Get.to(() => address());
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    height: 50,
                    width: w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      color: kPrimaryColor,
                    ),
                    child: Center(
                        child: Text(
                      'Save',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
