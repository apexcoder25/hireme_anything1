import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class CityFetchController extends GetxController {
  var placeList = <dynamic>[].obs;
  var sessionToken = '1234567890'.obs;
  final uuid = const Uuid();
  static const String G_MAP_API_KEY = 'AIzaSyBKrP4U38qt2EwJuNkSdIlHIL7T1kwFURw';

  void onTextChanged(String input) {
    if (input.isEmpty) {
      placeList.clear();
      return;
    }
    if (sessionToken.value == '1234567890') {
      sessionToken.value = uuid.v4();
    }
    getSuggestions(input);
  }

  Future<void> getSuggestions(String input) async {
    try {
      String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      // Removed types=(cities) to include streets and other locations, kept country:gb for UK restriction
      String request = '$baseURL?input=$input&key=$G_MAP_API_KEY&sessiontoken=${sessionToken.value}&components=country:gb';
      var response = await http.get(Uri.parse(request));
      print('Autocomplete Response: ${response.body}');

      if (response.statusCode == 200) {
        placeList.value = jsonDecode(response.body)['predictions'];
      } else {
        throw Exception('Failed to load predictions: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
      placeList.clear();
    }
  }

  Future<Map<String, double>?> getPlaceCoordinates(String placeId) async {
    try {
      String baseURL = 'https://maps.googleapis.com/maps/api/place/details/json';
      String request = '$baseURL?place_id=$placeId&key=$G_MAP_API_KEY&fields=geometry';
      var response = await http.get(Uri.parse(request));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var location = data['result']['geometry']['location'];
        return {
          'lat': location['lat'].toDouble(),
          'lng': location['lng'].toDouble(),
        };
      } else {
        throw Exception('Failed to load place details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching place coordinates: $e');
      return null;
    }
  }

  Future<double?> calculateDistanceMiles(String originPlaceId, String destinationPlaceId) async {
    try {
      String baseURL = 'https://maps.googleapis.com/maps/api/distancematrix/json';
      String request =
          '$baseURL?origins=place_id:$originPlaceId&destinations=place_id:$destinationPlaceId&key=$G_MAP_API_KEY&units=imperial';
      var response = await http.get(Uri.parse(request));
      print('Distance Matrix Response: ${response.body}');

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Parsed Distance Matrix Data: $data');

        if (data['status'] == 'OK') {
          var elements = data['rows'][0]['elements'][0];
          if (elements['status'] == 'OK') {
            double distanceInMeters = elements['distance']['value'].toDouble();
            double distanceMiles = distanceInMeters / 1609.34; 
            print('Calculated Road Distance: $distanceMiles miles');
            return distanceMiles;
          } else if (elements['status'] == 'ZERO_RESULTS') {
            print('No driving route found between locations');
            return -1; 
          } else {
            throw Exception('Element status not OK: ${elements['status']}');
          }
        } else {
          throw Exception('Distance Matrix API status not OK: ${data['status']}');
        }
      } else {
        throw Exception('Failed to load distance: ${response.statusCode}');
      }
    } catch (e) {
      print('Error calculating distance: $e');
      return null;
    }
  }


  double calculateHaversineDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 3958.8; 
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) * cos(_toRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  void clearSearch() {
    placeList.clear();
  }
}