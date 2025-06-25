import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../cutom_widgets/signup_textfilled.dart';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MyGradientContainer(),
//     );
//   }
// }

class MyGradientContainer extends StatefulWidget {
  @override
  _MyGradientContainerState createState() => _MyGradientContainerState();
}

class _MyGradientContainerState extends State<MyGradientContainer> {
  String? retrievedId;
  String title = 'Title';
  String mini_redeemable_pointsss = "100";
  String value_of_one_pointtt = "100";
  String point_per_rupeesss = "100";
  String loyaltyid = "";
  bool isLoading = false;

  Future<void> saveLoyaltyIdInSharedPreferences(String loyaltyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loyaltyId', loyaltyId);
    print('Loyalty ID saved in shared preferences: $loyaltyId');
  }

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences1();
  }

  Future<void> getIdFromSharedPreferences1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
    if (retrievedId!.isNotEmpty) {
      print('Retrieved profile shop ID: $retrievedId');

      getLoyal();
    } else {}
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("Retrieved ID: $retrievedId");
  }

  Future<void> getLoyal() async {
    if (retrievedId == null) {
      print('Retrieved ID is null');
      setState(() {
        isLoading = false;
      });
      return;
    }

    final url = Uri.parse(
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/get_loyaltycart');
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
      print('Response data: ${response.body}');
      final responseData = jsonDecode(response.body);
      print("datasetuptry all dfffffffffffff");

      print(responseData);
      print("tytle");
      print(responseData['data'][0]['title']);
      print(title);
      saveLoyaltyIdInSharedPreferences(loyaltyid);

      if (responseData['data'] != null && responseData['data'].isNotEmpty) {
        setState(() {
          title = responseData['data'][0]['title'];
          point_per_rupeesss =
              responseData['data'][0]['point_per_rupees'].toString();
          value_of_one_pointtt =
              responseData['data'][0]['value_of_one_point'].toString();
          mini_redeemable_pointsss =
              responseData['data'][0]['mini_redeemable_points'].toString();
          loyaltyid = responseData['data'][0]['_id'].toString();
          isLoading = true;
        });
      }
      print('POST r $loyaltyid');
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Loyalty Card'),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: isLoading != true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20, top: 20),
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.green],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20.0),
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            "Redeemable points : " +
                                "$mini_redeemable_pointsss",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            'Point value : $value_of_one_pointtt',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'point per rupees: $point_per_rupeesss',
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Container(
                            width: 100.0,
                            child: ElevatedButton(
                              onPressed: () {
                                _showPopup(context);

                                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => updateLoyal(),));
                              },
                              style: ElevatedButton.styleFrom(
                                // primary: Colors.cyan,
                                foregroundColor: Colors.cyan,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(color: Colors.white),
                                ),
                              ),
                              child: const Text('Update',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      Image.asset("assets/image/star-removebg-preview (1).png",
                          height: 80),
                    ],
                  ),
                ),
              ));
  }

  TextEditingController udescriptionnn = TextEditingController();
  TextEditingController mini_redeemable_pointsu = TextEditingController();
  TextEditingController uTittleee = TextEditingController();
  TextEditingController point_per_rupeesu = TextEditingController();
  TextEditingController value_of_one_pointu = TextEditingController();

  Future<void> updatecard() async {
    if (loyaltyid == null) {
      print('loyaltyid ID is null');
      return;
    }

    final url = Uri.parse("");
    print("inside api $loyaltyid");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'loyaltyId': loyaltyid.toString(),
        'title': uTittleee.text.toString(),
        'point_per_rupees': point_per_rupeesu.text.toString(),
        'value_of_one_point': value_of_one_pointu.text.toString(),
        'mini_redeemable_points': mini_redeemable_pointsu.text.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
      var updatedata = jsonDecode(response.body);
      print("cleaupddddd complettttttttttttttttttttttttttt");
      print(updatedata);
      Navigator.of(context).pop();
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => Profile()),
      // );
      getIdFromSharedPreferences().then((_) {
        if (retrievedId != null) {
          print('Retrieved profile shop ID: $retrievedId');
          getLoyal();
        } else {}
      });

      print('POST r $loyaltyid');
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          shrinkWrap: true,
          children: [
            AlertDialog(
              actions: <Widget>[
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Text("Tittle",
                        style: TextStyle(color: Colors.black87, fontSize: 16)),
                  ),
                ),
                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: uTittleee,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "$title",
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Text("Point per \u20B9 100*",
                        style: TextStyle(color: Colors.black87, fontSize: 16)),
                  ),
                ),
                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: point_per_rupeesu,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "$point_per_rupeesss",
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Text(
                      "Value of one point *",
                      style: TextStyle(color: Colors.black87, fontSize: 16),
                    ),
                  ),
                ),
                Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: value_of_one_pointu,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "$value_of_one_pointtt",
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10),
                    child: Text("Mini redeemable points",
                        style: TextStyle(color: Colors.black87, fontSize: 16)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Signup_textfilled(
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    textcont: mini_redeemable_pointsu,
                    length: 50,
                    keytype: TextInputType.name,
                    hinttext: "$mini_redeemable_pointsss",
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () async {
                        await updatecard().then((value) => () {
                              print("succesfull");

                              setState(() {});
                            });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side:
                              const BorderSide(color: Colors.black, width: 0.3),
                        ),
                        backgroundColor: Colors.green,
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
