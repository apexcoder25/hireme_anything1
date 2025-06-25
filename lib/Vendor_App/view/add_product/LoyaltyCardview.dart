import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../cutom_widgets/button.dart';
import '../../cutom_widgets/signup_textfilled.dart';
import '../../uiltis/color.dart';
import 'cardloy.dart';

class Loyal extends StatefulWidget {
  @override
  _EditableNameWidgetState createState() => _EditableNameWidgetState();
}

class _EditableNameWidgetState extends State<Loyal> {
  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
  }

  List loyaltyData = [];
  bool allFill = false;
  bool isloading = false;
  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('Retrieved edit etting  shop ID: $retrievedId');
      } else {}
    });
  }

  String title = 'Title';
  String description = 'Description goes here.';
  int points = 100;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
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
        title: const Text(
          'Loyalty Card',
          style: TextStyle(color: colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: colors.button_color,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10),
                child: Text("Tittle*",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
              ),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: Tittleee,
                length: 50,
                keytype: TextInputType.name,
                hinttext: "Tittle",
              ),

              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10),
                child: Text("Points per \u20B9100* ",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
              ),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: point_per_rupeesss,
                length: 50,
                keytype: TextInputType.name,
                hinttext: "point per 100 rupees",
              ),

              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10),
                child: Text(
                  "Minimum redeemable points *",
                  style: TextStyle(color: Colors.black87, fontSize: 16),
                ),
              ),
              Signup_textfilled(
                textfilled_height: 17,
                textfilled_weight: 1,
                textcont: mini_redeemable_pointss,
                length: 50,
                keytype: TextInputType.name,
                hinttext: "Minimum redeemable points",
              ),

              const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 10),
                child: Text("Value of one point*",
                    style: TextStyle(color: Colors.black87, fontSize: 16)),
              ),
              // Signup_textfilled(
              //   textfilled_height: 17,
              //   textfilled_weight: 1,
              //   textcont: value_of_one_pointt,
              //   length: 50,
              //   keytype: TextInputType.name,
              //   hinttext: "Value of one point",
              //   onchangeButton: onChaneData,
              //
              // ),

              Material(
                elevation: 1,
                borderRadius: BorderRadius.circular(7),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7)),
                  height: h / 17,
                  width: w / 1,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextFormField(
                        controller: value_of_one_pointt,
                        keyboardType: TextInputType.name,
                        onTap: () async {
                          allFill = false;
                          if (Tittleee.text.isNotEmpty ||
                              value_of_one_pointt.text.isNotEmpty ||
                              point_per_rupeesss.text.isNotEmpty ||
                              mini_redeemable_pointss.text.isNotEmpty) {
                            allFill = true;
                          }
                        },
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Value of one point",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (Tittleee.text.isEmpty ||
                          value_of_one_pointt.text.isEmpty ||
                          point_per_rupeesss.text.isEmpty ||
                          mini_redeemable_pointss.text.isEmpty) {
                        Get.snackbar("Notification", "Fill all fields",
                            backgroundColor: Colors.redAccent[100],
                            snackPosition: SnackPosition.TOP);
                      } else {
                        loaltyfild();
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: allFill == true
                          ? MaterialStateProperty.all(Colors.green)
                          : MaterialStateProperty.all(Colors.grey),

                      // MaterialStateProperty.resolveWith<Color>(
                      //       (Set<MaterialState> states) {
                      //     if (Tittleee.text.isEmpty ||
                      //         value_of_one_pointt.text.isEmpty ||
                      //         point_per_rupeesss.text.isEmpty ||
                      //         mini_redeemable_pointss.text.isEmpty) {
                      //
                      //       return Colors.grey;
                      //     }
                      //     allFill=true;
                      //     return Colors.green;
                      //   },
                      // ),
                    ),
                    child: const Text("Submit"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onChaneData() {}
  String? retrievedId;
  TextEditingController Tittleee = TextEditingController();
  TextEditingController value_of_one_pointt = TextEditingController();
  TextEditingController mini_redeemable_pointss = TextEditingController();
  TextEditingController point_per_rupeesss = TextEditingController();
  Future loaltyfild() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/add_loyaltycart';
    final Map<String, dynamic> data = {
      'shopId': retrievedId.toString(),
      'title': Tittleee.text.toString(),
      'point_per_rupees': point_per_rupeesss.text.toString(),
      'value_of_one_point': value_of_one_pointt.text.toString(),
      'mini_redeemable_points': mini_redeemable_pointss.text.toString(),
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      print('API Response: ${response.body}');
      var loyalty = jsonDecode(response.body);
      print("teYKyyyyyyyyyyyyyyyyyyyyyyyyyyDDDyyyyyyyyyyyyyyyyyy");
      print(loyalty);
      loyaltyData = [];
      loyaltyData.add(loyalty);
      print("dfdsfaaaaaaaaaad listinggggggggggggggggggggggggggggggg");
      print(loyaltyData);
      isloading = true;
      print(loyalty["result"]);
      print(loyaltyData[0]["result"]);
      await prefs.setString('result', loyaltyData[0]["result"]);
      print(loyalty["result"]);
      // Navigator.pushReplacement(
      // context,
      // MaterialPageRoute(
      // builder: (context) => MyGradientContainer(),
      // ),
      // );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Card Update Sucesfully'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      print('idddd $retrievedId');
    } else {
      print('Failed to post data. Error: ${response.statusCode}');
    }
  }
}
