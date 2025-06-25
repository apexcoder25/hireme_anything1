// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../../cutom_widgets/button.dart';
// import '../../cutom_widgets/signup_textfilled.dart';
//
// class EditableNameWidget extends StatefulWidget {
//   @override
//   _EditableNameWidgetState createState() => _EditableNameWidgetState();
// }
//
// class _EditableNameWidgetState extends State<EditableNameWidget> {
//   String getFormattedTime(TimeOfDay time) {
//     int hour = time.hour;
//     int minute = time.minute;
//     String period = time.period == DayPeriod.am ? 'AM' : 'PM';
//
//     String formattedHour = hour < 10 ? '0$hour' : '$hour';
//     String formattedMinute = minute < 10 ? '0$minute' : '$minute';
//
//     return '$formattedHour:$formattedMinute $period';
//   }
//
//   Future<void> getIdFromSharedPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     retrievedId = prefs.getString('id');
//     print("Retrieved ID: $retrievedId");
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getIdFromSharedPreferences().then((_) {
//       if (retrievedId != null) {
//         print('Retrieved edit etting  shop ID: $retrievedId');
//       } else {}
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text('Setting'),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0, bottom: 10),
//               child: Text("Update Delivery Charge per Km",
//                   style: TextStyle(color: Colors.black87, fontSize: 16)),
//             ),
//             Signup_textfilled(
//               textfilled_height: 17,
//               textfilled_weight: 1,
//               textcont: editcharge,
//               length: 50,
//               keytype: TextInputType.name,
//               hinttext: "Delivery charge",
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0, bottom: 10),
//               child: Text("Update Service Available in Km",
//                   style: TextStyle(color: Colors.black87, fontSize: 16)),
//             ),
//             Signup_textfilled(
//               textfilled_height: 17,
//               textfilled_weight: 1,
//               textcont: perkm,
//               length: 50,
//               keytype: TextInputType.name,
//               hinttext: "Service available",
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0, bottom: 10),
//               child: Text(
//                 "Update Open And Close Time",
//                 style: TextStyle(color: Colors.black87, fontSize: 16),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     var selectedTime = await showTimePicker(
//                       initialTime: selectedOpenTime1 ?? TimeOfDay.now(),
//                       context: context,
//                     );
//                     if (selectedTime != null) {
//                       if (selectedOpenTime2 != null &&
//                           _isBefore(selectedTime, selectedOpenTime2!)) {
//                         _showWarningDialog();
//                       } else {
//                         setState(() {
//                           selectedOpenTime1 = selectedTime;
//                         });
//                       }
//                     }
//                   },
//                   child: Container(
//                     color: Colors.white,
//                     height: 50,
//                     width: 150,
//                     child: Center(
//                       child: Text(
//                         selectedOpenTime1 != null
//                             ? '${selectedOpenTime1!.hour.toString().padLeft(2, '0')}:${selectedOpenTime1!.minute.toString().padLeft(2, '0')}'
//                             : 'Select Open Time',
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     var selectedTime = await showTimePicker(
//                       initialTime: selectedOpenTime2 ?? TimeOfDay.now(),
//                       context: context,
//                     );
//                     if (selectedTime != null) {
//                       if (selectedOpenTime1 != null &&
//                           _isBefore(selectedTime, selectedOpenTime1!)) {
//                         _showWarningDialog();
//                       } else {
//                         setState(() {
//                           selectedOpenTime2 = selectedTime;
//                         });
//                       }
//                     }
//                   },
//                   child: Container(
//                     color: Colors.white,
//                     height: 50,
//                     width: 150,
//                     child: Center(
//                       child: Text(
//                         selectedOpenTime2 != null
//                             ? '${selectedOpenTime2!.hour.toString().padLeft(2, '0')}:${selectedOpenTime2!.minute.toString().padLeft(2, '0')}'
//                             : 'Select Close Time',
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0, bottom: 10),
//               child: Text(
//                 "Update II  Open And Close Time",
//                 style: TextStyle(color: Colors.black87, fontSize: 16),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () async {
//                     var selectedTime = await showTimePicker(
//                       initialTime: selectedOpenTime3 ?? TimeOfDay.now(),
//                       context: context,
//                     );
//                     if (selectedTime != null) {
//                       if (selectedOpenTime2 != null &&
//                           _isBefore(selectedTime, selectedOpenTime2!)) {
//                         _showWarningDialog();
//                       } else {
//                         setState(() {
//                           selectedOpenTime3 = selectedTime;
//                         });
//                       }
//                     }
//                   },
//                   child: Container(
//                     color: Colors.white,
//                     height: 50,
//                     width: 150,
//                     child: Center(
//                       child: Text(
//                         selectedOpenTime3 != null
//                             ? '${selectedOpenTime3!.hour.toString().padLeft(2, '0')}:${selectedOpenTime3!.minute.toString().padLeft(2, '0')}'
//                             : 'Select Open Time',
//                       ),
//                     ),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () async {
//                     var selectedTime = await showTimePicker(
//                       initialTime: selectedOpenTime4 ?? TimeOfDay.now(),
//                       context: context,
//                     );
//                     if (selectedTime != null) {
//                       if (selectedOpenTime3 != null &&
//                           _isBefore(selectedTime, selectedOpenTime3!)) {
//                         _showWarningDialog();
//                       } else {
//                         setState(() {
//                           selectedOpenTime4 = selectedTime;
//                         });
//                       }
//                     }
//                   },
//                   child: Container(
//                     color: Colors.white,
//                     height: 50,
//                     width: 150,
//                     child: Center(
//                       child: Text(
//                         selectedOpenTime4 != null
//                             ? '${selectedOpenTime4!.hour.toString().padLeft(2, '0')}:${selectedOpenTime4!.minute.toString().padLeft(2, '0')}'
//                             : 'Select Close Time',
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.only(top: 30.0),
//             //   child: Button_widget(
//             //     buttontext: "Update",
//             //     button_height: 20,
//             //     button_weight: 1,
//             //     onpressed: () async {
//             //       if (editcharge.text.isEmpty &&
//             //           perkm.text.isEmpty &&
//             //           selectedOpenTime1 == null &&
//             //           selectedOpenTime2 == null &&
//             //           selectedOpenTime3 == null &&
//             //           selectedOpenTime4 == null) {
//             //         ScaffoldMessenger.of(context).showSnackBar(
//             //           SnackBar(
//             //             content: Text('Please enter at least one field.'),
//             //             duration: Duration(seconds: 2),
//             //             backgroundColor: Colors.red,
//             //           ),
//             //         );
//             //       } else {
//             //         await updateSetting();
//             //       }
//             //     },
//             //   ),
//             // ),
//             Padding(
//               padding: const EdgeInsets.only(top: 30.0),
//               child: Container(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     if (
//                     editcharge.text.isEmpty &&
//                         perkm.text.isEmpty &&
//                         selectedOpenTime1 == null &&
//                         selectedOpenTime2 == null &&
//                         selectedOpenTime3 == null &&
//                         selectedOpenTime4 == null
//
//                     ) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Please enter at least one field.'),
//                           duration: Duration(seconds: 2),
//                           backgroundColor: Colors.red,
//                         ),
//                       );
//                     } else {
//                       await updateSetting();
//                     }
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.resolveWith<Color>(
//                           (Set<MaterialState> states) {
//                         if (
//                         editcharge.text.isEmpty &&
//                             perkm.text.isEmpty &&
//                             selectedOpenTime1 == null &&
//                             selectedOpenTime2 == null &&
//                             selectedOpenTime3 == null &&
//                             selectedOpenTime4 == null
//                         ) {
//                           return Colors.grey;
//                         }
//                         return Colors.green;
//                       },
//                     ),
//                   ),
//                   child: Text(
//                     "Update",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ),
//               ),
//             )
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   String? retrievedId;
//   TextEditingController perkm = TextEditingController();
//   TextEditingController editcharge = TextEditingController();
//
//   TimeOfDay? selectedOpenTime1;
//   TimeOfDay? selectedOpenTime2;
//   TimeOfDay? selectedOpenTime3;
//   TimeOfDay? selectedOpenTime4;
//
//   void _showWarningDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Warning'),
//           content: Text('Please enter the time after the previous close time.'),
//           actions: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   bool _isBefore(TimeOfDay time1, TimeOfDay time2) {
//     final DateTime dateTime1 = DateTime(2023, 1, 1, time1.hour, time1.minute);
//     final DateTime dateTime2 = DateTime(2023, 1, 1, time2.hour, time2.minute);
//     return dateTime1.isBefore(dateTime2);
//   }
//
//   Future<void> updateSetting() async {
//     final String apiUrl =
//         'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/update_vender';
//     final Map<String, String> headers = {
//       'Content-Type': 'application/json',
//     };
//
//     final Map<String, String?> data = {
//       'shopId': retrievedId,
//       'delivery_charge': editcharge.text.toString(),
//       'max_distance': perkm.text.toString(),
//       'open_time': selectedOpenTime1 != null
//           ? getFormattedTime(selectedOpenTime1!)
//           : null,
//       'close_time': selectedOpenTime2 != null
//           ? getFormattedTime(selectedOpenTime2!)
//           : null,
//       'o_time': selectedOpenTime3 != null
//           ? getFormattedTime(selectedOpenTime3!)
//           : null,
//       'c_time': selectedOpenTime4 != null
//           ? getFormattedTime(selectedOpenTime4!)
//           : null,
//     };
//
//     data.removeWhere((key, value) => value == null);
//
//     final String requestBody = json.encode(data);
//
//     try {
//       final response = await http.post(Uri.parse(apiUrl),
//           headers: headers, body: requestBody);
//
//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Data update successfully..'),
//             duration: Duration(seconds: 2), // Adjust the duration as needed
//             backgroundColor: Colors.green,
//           ),
//         );
//
//         print("Response: ${response.body}");
//         final jsonResponse = json.decode(response.body);
//
//         print("----------------------------");
//         Get.back();
//       } else {
//         print("API request failed with status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
// }
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../uiltis/color.dart';

class EditableNameWidget extends StatefulWidget {
  @override
  _EditableNameWidgetState createState() => _EditableNameWidgetState();
}

class _EditableNameWidgetState extends State<EditableNameWidget> {
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
    stortiming();
  }

  String? openTime;
  String? sopenTime;
  String? closeTime;
  String? scloseTime;

  Future<void> stortiming() async {
    if (retrievedId == null) {
      print('Retrieved ID is null');
      return;
    }

    final url = Uri.parse('');
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
        openTime = parsedResponse['data']['open_time'];
        closeTime = parsedResponse['data']['close_time'];
        sopenTime = parsedResponse['data']['o_time'];
        scloseTime = parsedResponse['data']['c_time'];
      });
      // Extract and print opening and closing times

      print('Open time: $openTime');
      print('Close time: $closeTime');
      print('Close time: $sopenTime');
      print('Close time: $scloseTime');
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved edit etting  shop ID: $retrievedId');
        stortiming();
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: colors.white,
          ),
        ),
        title: Text(
          'Store Timming',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colors.button_color,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10),
              child: Text(
                "Update Open And Close Time",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    var selectedTime = await showTimePicker(
                      initialTime: selectedOpenTime1 ?? TimeOfDay.now(),
                      context: context,
                    );
                    if (selectedTime != null) {
                      if (selectedOpenTime2 != null &&
                          _isBefore(selectedTime, selectedOpenTime2!)) {
                        _showWarningDialog();
                      } else {
                        setState(() {
                          selectedOpenTime1 = selectedTime;
                        });
                      }
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: 150,
                    child: Center(
                      // child: Text(
                      //   selectedOpenTime1 != null
                      //       ? '${selectedOpenTime1!.hour.toString().padLeft(2, '0')}:${selectedOpenTime1!.minute.toString().padLeft(2, '0')}'
                      //       : '$openTime',
                      // ),
                      child: Text(
                        selectedOpenTime1 != null
                            ? '${selectedOpenTime1!.hour.toString().padLeft(2, '0')}:${selectedOpenTime1!.minute.toString().padLeft(2, '0')}'
                            : openTime != null
                                ? '$openTime'
                                : 'Loading',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var selectedTime = await showTimePicker(
                      initialTime: selectedOpenTime2 ?? TimeOfDay.now(),
                      context: context,
                    );
                    if (selectedTime != null) {
                      if (selectedOpenTime1 != null &&
                          _isBefore(selectedTime, selectedOpenTime1!)) {
                        _showWarningDialog();
                      } else {
                        setState(() {
                          selectedOpenTime2 = selectedTime;
                        });
                      }
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: 150,
                    child: Center(
                      // child: Text(
                      //   selectedOpenTime2 != null
                      //       ? '${selectedOpenTime2!.hour.toString().padLeft(2, '0')}:${selectedOpenTime2!.minute.toString().padLeft(2, '0')}'
                      //       : '$closeTime',
                      // ),
                      child: Text(
                        selectedOpenTime2 != null
                            ? '${selectedOpenTime2!.hour.toString().padLeft(2, '0')}:${selectedOpenTime2!.minute.toString().padLeft(2, '0')}'
                            : closeTime != null
                                ? '$closeTime'
                                : 'Loading',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 10),
              child: Text(
                "Update II  Open And Close Time",
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    var selectedTime = await showTimePicker(
                      initialTime: selectedOpenTime3 ?? TimeOfDay.now(),
                      context: context,
                    );
                    if (selectedTime != null) {
                      if (selectedOpenTime2 != null &&
                          _isBefore(selectedTime, selectedOpenTime2!)) {
                        _showWarningDialog();
                      } else {
                        setState(() {
                          selectedOpenTime3 = selectedTime;
                        });
                      }
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: 150,
                    child: Center(
                      // child: Text(
                      //   selectedOpenTime3 != null
                      //       ? '${selectedOpenTime3!.hour.toString().padLeft(2, '0')}:${selectedOpenTime3!.minute.toString().padLeft(2, '0')}'
                      //       : '$sopenTime',
                      // ),
                      child: Text(
                        selectedOpenTime3 != null
                            ? '${selectedOpenTime3!.hour.toString().padLeft(2, '0')}:${selectedOpenTime3!.minute.toString().padLeft(2, '0')}'
                            : sopenTime != null
                                ? '$sopenTime'
                                : 'Loading',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var selectedTime = await showTimePicker(
                      initialTime: selectedOpenTime4 ?? TimeOfDay.now(),
                      context: context,
                    );
                    if (selectedTime != null) {
                      if (selectedOpenTime3 != null &&
                          _isBefore(selectedTime, selectedOpenTime3!)) {
                        _showWarningDialog();
                      } else {
                        setState(() {
                          selectedOpenTime4 = selectedTime;
                        });
                      }
                    }
                  },
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: 150,
                    child: Center(
                      // child: Text(
                      //   selectedOpenTime4 != null
                      //       ? '${selectedOpenTime4!.hour.toString().padLeft(2, '0')}:${selectedOpenTime4!.minute.toString().padLeft(2, '0')}'
                      //       : '$scloseTime',
                      // ),
                      child: Text(
                        selectedOpenTime4 != null
                            ? '${selectedOpenTime4!.hour.toString().padLeft(2, '0')}:${selectedOpenTime4!.minute.toString().padLeft(2, '0')}'
                            : scloseTime != null
                                ? '$scloseTime'
                                : 'Loading',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectedOpenTime1 == null &&
                        selectedOpenTime2 == null &&
                        selectedOpenTime3 == null &&
                        selectedOpenTime4 == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
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
                        if (selectedOpenTime1 == null &&
                            selectedOpenTime2 == null &&
                            selectedOpenTime3 == null &&
                            selectedOpenTime4 == null) {
                          return Colors.grey;
                        }
                        return Colors.green;
                      },
                    ),
                  ),
                  child: Text(
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

  String? retrievedId;
  TextEditingController perkm = TextEditingController();
  TextEditingController editcharge = TextEditingController();

  TimeOfDay? selectedOpenTime1;
  TimeOfDay? selectedOpenTime2;
  TimeOfDay? selectedOpenTime3;
  TimeOfDay? selectedOpenTime4;

  void _showWarningDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Please enter the time after the previous close time.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  bool _isBefore(TimeOfDay time1, TimeOfDay time2) {
    final DateTime dateTime1 = DateTime(2023, 1, 1, time1.hour, time1.minute);
    final DateTime dateTime2 = DateTime(2023, 1, 1, time2.hour, time2.minute);
    return dateTime1.isBefore(dateTime2);
  }

  Future<void> updateSetting() async {
    const String apiUrl = '';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, String?> data = {
      'shopId': retrievedId,
      'open_time': selectedOpenTime1 != null
          ? getFormattedTime(selectedOpenTime1!)
          : null,
      'close_time': selectedOpenTime2 != null
          ? getFormattedTime(selectedOpenTime2!)
          : null,
      'o_time': selectedOpenTime3 != null
          ? getFormattedTime(selectedOpenTime3!)
          : null,
      'c_time': selectedOpenTime4 != null
          ? getFormattedTime(selectedOpenTime4!)
          : null,
    };

    data.removeWhere((key, value) => value == null);

    final String requestBody = json.encode(data);

    try {
      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: requestBody);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
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
