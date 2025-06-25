import 'dart:convert';

import 'package:hire_any_thing/Vendor_App/cutom_widgets/signup_textfilled.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../uiltis/color.dart';

class DeliverySetting extends StatefulWidget {
  const DeliverySetting({super.key});

  @override
  State<DeliverySetting> createState() => _DeliverySettingState();
}

class _DeliverySettingState extends State<DeliverySetting> {
  String getFormattedTime(TimeOfDay time) {
    int hour = time.hour;
    int minute = time.minute;
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    String formattedHour = hour < 10 ? '0$hour' : '$hour';
    String formattedMinute = minute < 10 ? '0$minute' : '$minute';

    return '$formattedHour:$formattedMinute $period';
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
  }

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved edit etting  shop ID: $retrievedId');
        delevory();
      } else {}
    });
    delevory();
  }

  String? retrievedId;
  TextEditingController perkm = TextEditingController();
  TextEditingController editcharge = TextEditingController();
  TextEditingController flat_delevery_chargeu = TextEditingController();
  TextEditingController minimum_order_valueu = TextEditingController();

  TimeOfDay? selectedOpenTime1;
  TimeOfDay? selectedOpenTime2;
  TimeOfDay? selectedOpenTime3;
  TimeOfDay? selectedOpenTime4;

  String? deleverycharge;
  String? servicescharge;
  String? flatdeliverych;
  String? minimumorderva;
  Future<void> delevory() async {
    if (retrievedId == null) {
      print('Retrieved ID is null');
      return;
    }

    final url = Uri.parse(
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getVenderProfile');
    print("inside api $retrievedId");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'shopId': retrievedId!,
      }),
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print('stortiming request successful');
      print('Response data: ${response.body}');

      final parsedResponse = jsonDecode(response.body);

      setState(() {
        deleverycharge = parsedResponse['data']['delivery_charge'].toString();
        flatdeliverych =
            parsedResponse['data']['flat_delivery_charge'].toString();
        servicescharge = parsedResponse['data']['service_charge'].toString();
        minimumorderva = parsedResponse['data']['min_order'].toString();
      });
      // Extract and print opening and closing times

      print('Open time: $deleverycharge');
      print('Close time: $flatdeliverych');
      print('Close time: $servicescharge');
      print('Close time: $minimumorderva');
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        foregroundColor: colors.white,
        title: const Text('Delivery Setting'),
        centerTitle: true,
        backgroundColor: colors.button_color,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 10),
              child: Text("Update delevery charge",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
            ),
            Signup_textfilled(
              textfilled_height: 17,
              textfilled_weight: 1,
              textcont: flat_delevery_chargeu,
              length: 50,
              keytype: TextInputType.name,
              //hinttext: "$flatdeliverych",
              hinttext: flatdeliverych != null ? "$flatdeliverych" : "Loding",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (flat_delevery_chargeu.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter at least one field.'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      await updateSetting();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (flat_delevery_chargeu.text.isEmpty) {
                          return Colors.grey;
                        }
                        return Colors.green;
                      },
                    ),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isBefore(TimeOfDay time1, TimeOfDay time2) {
    final DateTime dateTime1 = DateTime(2023, 1, 1, time1.hour, time1.minute);
    final DateTime dateTime2 = DateTime(2023, 1, 1, time2.hour, time2.minute);
    return dateTime1.isBefore(dateTime2);
  }

  Future<void> updateSetting() async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/update_vender';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String?> data = {
      'shopId': retrievedId,
      'delivery_charge': editcharge.text.toString(),
      'max_distance': perkm.text.toString(),
      'min_order': minimum_order_valueu.text.toString(),
      'flat_delivery_charge': flat_delevery_chargeu.text.toString(),
    };

    data.removeWhere((key, value) => value == null);

    final String requestBody = json.encode(data);

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data update successfully..'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
            backgroundColor: Colors.green,
          ),
        );

        print("Response: ${response.body}");
        final jsonResponse = json.decode(response.body);

        print("----------------------------");
        Get.back();
      } else {
        print("API request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
