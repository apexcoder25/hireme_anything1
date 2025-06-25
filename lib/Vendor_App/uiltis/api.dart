// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:salon_hub_beautician/constant/api_url.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class ApiService {
//   static Future<String?> getIdFromSharedPreferences(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(key);
//   }

//   static Future<void> listHome(String retrievedId) async {
//     final String apiUrl =
//         ApiUrl.baseUrl+ApiUrl.shopOrderListUrl;

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       body: {
//         "shopId": retrievedId,
//       },
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       print('Response Body: ${response.body}');

//       if (data.containsKey('data')) {
//         List<dynamic> orderList = data['data'];
//         // Process and update yourDataList
//       }
//     } else {
//       print('Request failed');
//     }
//   }

//   static Future<void> orderStatus(
//       String action, String orderId, String userId) async {
//     final String apiUrl =
//         ApiUrl.baseUrl+ApiUrl.updateOrderListUrl;
//     final Map<String, String> headers = {
//       'Content-Type': 'application/json',
//     };

//     final Map<String, String> data = {
//       'orderId': orderId,
//       'userId': userId,
//       'order_status': (action == 'Accept') ? 'In Progress' : 'Cancel',
//       'vender_status': (action == 'Accept') ? 'accept' : 'reject',
//     };

//     final String requestBody = json.encode(data);
//     print('Request Body: $requestBody');

//     try {
//       final response = await http.post(Uri.parse(apiUrl),
//           headers: headers, body: requestBody);
//       print('Response Status Code: ${response.statusCode}');
//       print('Response Body: ${response.body}');

//       if (response.statusCode == 200) {
//         final jsonResponse = json.decode(response.body);
//         print('Decoded Response: $jsonResponse');
//         // Handle response and update if needed
//       } else {
//         print("API request failed with status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//   static Future<void> checkStatus(String retrievedId) async {
//     var response = await http.post(
//         Uri.parse(ApiUrl.baseUrl+ApiUrl.getStatusUrl),
//         body: {"shopId": retrievedId});

//     var resData = json.decode(response.body);
//     print(response.body);
//     print(resData);

//     if (response.statusCode == 200 &&
//         resData["result"].toString() == "true".toString()) {
//       final status = resData['data']['status'];
//       if (status == 1) {
//         print(status);
//         // Update state or perform any action based on the status
//       } else {
//         print(status);
//         // Update state or perform any action based on the status
//       }
//     } else {
//       print("Not Found");
//     }
//   }

//   static Future<void> openCloseShop(String retrievedId) async {
//     final String apiUrl =
//         ApiUrl.baseUrl+ApiUrl.shopOpenCloseUrl;
//     final Map<String, dynamic> data = {
//       'shopId': retrievedId,
//     };

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode(data),
//     );

//     if (response.statusCode == 200) {
//       print("Response: ${response.body}");
//       // Handle response if needed
//     } else {
//       print("Error: ${response.statusCode}");
//     }
//   }

//   static Future<void> getShopName(String retrievedId) async {
//     final String apiUrl =
//         ApiUrl.baseUrl+ApiUrl.getVenderProfileUrl;
//     final Map<String, String> headers = {
//       'Content-Type': 'application/json',
//     };

//     final Map<String, String> data = {
//       'shopId': retrievedId,
//     };

//     final String requestBody = json.encode(data);

//     try {
//       final response = await http.post(Uri.parse(apiUrl),
//           headers: headers, body: requestBody);

//       if (response.statusCode == 200) {
//         print("Response: ${response.body}");
//         final jsonResponse = json.decode(response.body);
//         String shopName = jsonResponse['data']['shop_name'];
//         String url = jsonResponse['data']['shop_image'][0];
//         print("Shop Name: $shopName");
//         print("URL: $url");
//         // Update state or perform any action based on the data
//       } else {
//         print("API request failed with status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
// }
