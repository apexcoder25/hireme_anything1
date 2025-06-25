// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:salon_hub_beautician/constant/api_url.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../model/driverlatlong.dart';

// class Services with ChangeNotifier {
//   DriverLiveLatLongModel? driverLiveLatLong;

//   driverLiveLatLongApi(String orderId) async {
//     final prefs = await SharedPreferences.getInstance();
//     String? userid = await prefs.getString("id");
//     print(orderId.toString() + " order id");
//     try {
//       var res = await http.post(
//           Uri.parse(ApiUrl.baseUrl+ApiUrl.getDriverLatLongUrl),
//           body: {
//             "shopId": userid.toString(),
//             "orderId": orderId.toString(),
//           });
//       var decodedData = json.decode(res.body.toString());
//       print(decodedData);
//       driverLiveLatLong = DriverLiveLatLongModel.fromJson(decodedData);
//       if (res.statusCode == 200) {
//         return driverLiveLatLong;
//       } else {
//         return driverLiveLatLong;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
// }
