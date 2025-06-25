import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/view/delivery_boy_list.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constant/api_url.dart';

class ApiController extends GetxController {
  List<dynamic> loyaltyData = [].obs;

  RxBool isloading = false.obs;

  List<Driver> drivers = [];
  Future listDeliveryBoy(retrievedId) async {
    const String apiUrl = ApiUrl.baseUrl + ApiUrl.driverListUrl;
    final Map<String, dynamic> data = {
      'shopId': retrievedId.toString(),
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print("Response: ${response.body}");

      final parsedResponse = json.decode(response.body);
      final driversData = parsedResponse['data'];

      List<Driver> driverList = [];

      for (var driverData in driversData) {
        if (driverData['image'] != null &&
            driverData['name'] != null &&
            driverData['phone'] != null &&
            driverData['rating'] != null &&
            driverData['driverId'] != null &&
            driverData['active_status'] != null) {
          driverList.add(Driver(
            image: driverData['image'],
            name: driverData['name'],
            phone: driverData['phone'],
            rating: driverData['rating'].toDouble(),
            driverId: driverData['driverId'],
            activeStatus: driverData['active_status'],
          ));
        }
      }

      drivers = driverList;
    } else {
      print("Error: ${response.statusCode}");
    }
  }
}
