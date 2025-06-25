import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class GmapStatetest extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<GmapStatetest> {
  void saveAddressToSharedPreferences(String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', address);
  }

  var _controllers = TextEditingController();
  var uuid = new Uuid();
  String k = "d90alvgHTQ-yYTKGJhxPch:"
      "APA91bGQCKn93TPFsEil_meZ4axhd3ywiBNAy2tijOJOtqC"
      "0EFVGJobF6hrde6DGNOEhH05CWUI-HFKfgtFI0gxIBIQ2gPmIJv"
      "8QrM8UsHE_SIIuFf84fMg_M99iurPIn6dL30XZiu84";
  List<dynamic> _placeList = [];
  String tappedPlace = "";

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();
  LatLng? showLocation;
  String address = "Address not found ";

  String? cityName;
  String? streetName;
  String? pincode;


  Timer? _debounce;
  @override
  void initState() {
    super.initState();
    useSavedLocation();
    _controllers.addListener(() {
      _onChanged();
    });
    _getTappedPlace();
  }
  _onChanged() {
    if (k == null) {
      setState(() {
        k = uuid.v4();
      });
    }
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getSuggestion(_controllers.text);
    });
  }
  void getSuggestion(String input) async {
    try {
      String kPLACES_API_KEY =
          "AIzaSyC85iTCGYU-pIeS9fp1agTcHYWjS5XgaxY&libraries=places";
      String type = '(regions)';
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$k';
      var response = await http.get(Uri.parse(request)); // Use Uri.parse here
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        print(
            'Failed to load predictions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  _getTappedPlace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tappedPlace = prefs.getString('tappedPlace') ?? "";
    });
  }
  _setTappedPlace(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('tappedPlace', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,

                    buildingsEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (CameraPosition? position) {
                      if (showLocation != position!.target) {
                        print(showLocation.toString() + "cghcfghfg");
                        setState(() {
                          showLocation = position.target;
                        });
                      }
                    },
                    onCameraIdle: () {
                      showBottomSheet();
                    },
                    initialCameraPosition: CameraPosition(
                      target: showLocation ?? LatLng(0, 0),
                      zoom: 15.0,
                    ),

                    // markers: markers,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: _getMarker(),
                    ),
                  ),
                  Positioned(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: _location(),
                    ),
                  ),


                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0, left: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: TextField(
                          controller: _controllers,
                          decoration: InputDecoration(
                            hintText: "search location",
                            focusColor: Colors.white,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            suffixIcon: _controllers.text.toString() == ""
                                ? null
                                : IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _controllers.clear();
                                    },
                                  ),
                            border: InputBorder.none, // Remove the underline
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Container(
                      color: Colors.white,
                      // Set your desired background color here
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _placeList.length,
                        itemBuilder: (context, index) {
                          final place = _placeList[index];

                          return ListTile(
                            title: InkWell(
                              onTap: () async {
                                final description = place["description"];
                                print('Tapped place..... $description');
                                try {
                                  await getLocationFromPlaceName(description);
                                  setState(() {
                                    tappedPlace = description;
                                    _setTappedPlace(description);
                                    showBottomSheet();
                                    _controllers.clear();
                                  });

                                  _setTappedPlace(tappedPlace);
                                  getLocationFromPlaceName(tappedPlace);
                                } catch (e) {
                                  print('Error: $e');
                                }
                              },
                              child: Text(
                                place["description"],
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      '$address',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString("currentAddress", address);

                          await prefs.setDouble(
                              'latitude', showLocation!.latitude);
                          await prefs.setDouble(
                              'longitude', showLocation!.longitude);

                          Navigator.pop(context, {
                            'latitude': showLocation!.latitude,
                            'longitude': showLocation!.longitude,
                            'address': address,
                          "cityName":cityName,
                          "streetName":streetName,
                          "pincode":pincode
                          });


                        },
                        style: ElevatedButton.styleFrom(
                          // primary: Colors.green,
                          foregroundColor: Colors.green,
                        ),
                        child: Text('Confirm Location'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMarker() {
    return Container(
      width: 40,
      height: 40,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(),
      child: ClipOval(
        child: Image.asset(
          "assets/image/pin.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> useSavedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitude = prefs.getDouble('latitude');
    double? longitude = prefs.getDouble('longitude');

    if (latitude != null && longitude != null) {
      final GoogleMapController controller = await _controller.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: 16)));

      setState(() {
        showLocation = LatLng(latitude, longitude);
      });
    }
  }

  void showBottomSheet() async {
    if (showLocation != null) {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          showLocation!.latitude, showLocation!.longitude);

      if (placemarks.isNotEmpty) {
        final Placemark placemark = placemarks.first;
        if (mounted) {
          setState(() {
            // print("Address Vendor=>${placemark.street},${placemark.subLocality}, ${placemark.locality}");
            // print("placemark.locality=>${placemark.locality}");
            // print("Address Vendor2=> ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}");
            address =
                "${placemark.street},${placemark.subLocality}, ${placemark.locality},"
                " ${placemark.administrativeArea}, ${placemark.country}, ${placemark.postalCode}";
            saveAddressToSharedPreferences(address);
            cityName=placemark.locality;
            streetName=placemark.street.toString()+placemark.subLocality.toString();
            pincode=placemark.postalCode;
          });
        }
      }

    }
  }

  Future<void> getLocationFromPlaceName(String placeName) async {
    try {
      List<Location> locations = await locationFromAddress(placeName);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        double latitude = location.latitude;
        double longitude = location.longitude;

        final GoogleMapController controller = await _controller.future;
        await controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(latitude, longitude), zoom: 16)));

        setState(() {
          showLocation = LatLng(latitude, longitude);
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setDouble('latitude', latitude);
        await prefs.setDouble('longitude', longitude);

        print('Latitudegmapc: $latitude, Longitudegmapc: $longitude');
      } else {
        print('No results found for the provided place name.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
     controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
         target: LatLng(position.latitude, position.longitude), zoom: 15)));
  }

  Widget _location() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          setState(() {
            _currentLocation();
          });
        },
        child: Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black87, width: 0.8),
            color: Colors.white,
          ),
          child: ClipOval(
            child: Image.asset(
              "assets/image/img_5.png",
              fit: BoxFit.cover,
              // color: Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
