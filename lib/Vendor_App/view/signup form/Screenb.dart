import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hire_any_thing/Vendor_App/view/edit_profile/edit_profile_vender_screen.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utilities/constant.dart';
import '../../uiltis/color.dart';
import 'package:image_picker/image_picker.dart';
class VendorProfile {
  dynamic result;
  String message;
  VendorData data;

  VendorProfile({
    required this.result,
    required this.message,
    required this.data,
  });

  factory VendorProfile.fromJson(Map<String, dynamic> json) {
    return VendorProfile(
      result: json['result'],
      message: json['message'],
      data: VendorData.fromJson(json['data']),
    );
  }
}

class VendorData {
  GeoLocation geoLocation;
  String id;
  int mobile;
  String qrCode;
  String shopName;

  String openTime;
  String shopAddress;
  String closeTime;

  String openTimead;
  String shopAddressad;

  String areaa;
  String closeTimead;

  List<String> shopImage;
  List<String> categoryId;
  int shopStatus;
  int approveStatus;
  int actStatus;
  DateTime createdAt;
  DateTime updatedAt;
  String fcm;
  int otp;

  int delcharge;
  int flatdeliverycharge;
  int distanceee;

  int maxdistanceee;

  int minorder;
  String acc_nomb;
  String ifsccodee;
  String managernamee;

  String? emailiddddd;
  String? legalnameee;

  VendorData({
    required this.geoLocation,
    required this.emailiddddd,
    required this.legalnameee,
    required this.id,
    required this.mobile,
    required this.qrCode,
    required this.shopName,
    required this.openTime,
    required this.shopAddress,
    required this.closeTime,
    required this.openTimead,
    required this.shopAddressad,
    required this.areaa,
    required this.closeTimead,
    required this.shopImage,
    required this.categoryId,
    required this.shopStatus,
    required this.approveStatus,
    required this.actStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.fcm,
    required this.otp,
    required this.delcharge,
    required this.flatdeliverycharge,
    required this.distanceee,
    required this.maxdistanceee,
    required this.minorder,
    required this.acc_nomb,
    required this.ifsccodee,
    required this.managernamee,
  });

  factory VendorData.fromJson(Map<String, dynamic> json) {
    return VendorData(
      geoLocation: GeoLocation.fromJson(json['geo_location'] ?? {}),
      id: json['_id'] ?? '',
      legalnameee: json['legal_name'] ?? '',
      emailiddddd: json['email'] ?? '',
      mobile: json['mobile'] ?? 0,
      qrCode: json['qr_code'] ?? '',
      shopName: json['shop_name'] ?? '',
      openTime: json['open_time'] ?? '',
      shopAddress: json['shop_address'] ?? '',
      areaa: json['area'] ?? '',
      closeTime: json['close_time'] ?? '',
      openTimead: json['o_time'] ?? '',
      shopAddressad: json['addr'] ?? '',
      closeTimead: json['c_time'] ?? '',
      shopImage: List<String>.from(json['shop_image'] ?? []),
      categoryId: List<String>.from(json['categoryId'] ?? []),
      shopStatus: json['shop_status'] ?? 0,
      approveStatus: json['approve_status'] ?? 0,
      actStatus: json['act_status'] ?? 0,
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
      fcm: json['fcm'] ?? '',
      otp: json['otp'] ?? 0,
      delcharge: json['delivery_charge'] ?? 0,
      flatdeliverycharge: json['flat_delivery_charge'] ?? 0,
      distanceee: json['distance'] ?? 0,
      maxdistanceee: json['max_distance'] ?? 0,
      minorder: json['min_order'] ?? 0,
      acc_nomb: json['acc_no'] ?? '',
      ifsccodee: json['ifsc_code'] ?? '',
      managernamee: json['manager_name'] ?? '',
    );
  }
}

class GeoLocation {
  String type;
  List<double> coordinates;

  GeoLocation({
    required this.type,
    required this.coordinates,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}

class Profileee extends StatefulWidget {
  @override
  State<Profileee> createState() => _ProfileState();
}

class _ProfileState extends State<Profileee> {
  VendorProfile? vendorProfile;
  String? retrievedId;
  bool isLoading = true;

  // Future<void> simulateLoading() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   setState(() {
  //     isLoading = false;
  //   });
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getIdFromSharedPreferences().then((_) {
  //     if (retrievedId != null) {
  //       print('Retrieved new  profile shop ID: $retrievedId');
  //       simulateLoading();
  //       makePostRequest();
  //       loadListWithLoader();
  //     }
  //   });
  // }
  //
  // Future<void> getIdFromSharedPreferences() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   retrievedId = prefs.getString('id');
  //   print("Retrieved ID: $retrievedId");
  // }
  //
  // Future<void> makePostRequest() async {
  //   if (retrievedId == null) {
  //     print('Retrieved ID is null');
  //     return;
  //   }
  //
  //   final url =
  //   Uri.parse('https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/getVenderProfile');
  //   print("inside api $retrievedId");
  //   final response = await http.post(
  //     url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(<String, String>{
  //       'shopId': retrievedId!,
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     print('POST request successful');
  //     print('Response data: ${response.body}');
  //
  //     final parsedResponse = jsonDecode(response.body);
  //
  //     if (parsedResponse['data'] != null) {
  //       vendorProfile = VendorProfile.fromJson(parsedResponse);
  //
  //       if (vendorProfile != null && vendorProfile!.data != null) {
  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         prefs.setInt('mobileNumber', vendorProfile!.data.mobile);
  //         prefs.setString('shopName', vendorProfile!.data.shopName);
  //
  //         setState(() {});
  //       } else {
  //         print('Failed to parse response data or data is null.');
  //       }
  //     } else {
  //       print('Response does not contain "data" property.');
  //     }
  //   } else {
  //     print('POST request failed with status: ${response.statusCode}');
  //     print('Response data: ${response.body}');
  //   }
  // }
  //
  // Future<void> loadListWithLoader() async {
  //   await Future.delayed(const Duration(seconds: 2));
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  Widget buildProfileInfo(String label, String? value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



List list=[1,2,3,4,5,6,7];
  Widget buildImageSection() {
    return Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
          // children: vendorProfile!.data.shopImage
          children: vendorProfile!.data.shopImage
              .map(
                (image) => Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: Card(
                  child: FadeInImage.assetNetwork(
                    placeholder: "assets/placeholder_image.png",
                    image: "http://103.104.74.215:3092/uploads/$image",
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
  // String path = UserData[0]['path'];
  String iamgePath = "assets/images/myprofile.png";


  String? _pickedImagePath;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Handle picked image file
      setState(() {
        _pickedImagePath = pickedFile.path;
        iamgePath = "";
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF295AB3), // AppBar background color
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF295AB3), // Border color
                width: 2.0, // Border width
              ),
            ),
          ),
          child: AppBar(
            centerTitle: true,
            foregroundColor: colors.white,
            backgroundColor: colors.button_color,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Profile'),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileVender()));

                  },
                  child: Container(
                    alignment: Alignment.center,
                    // height: MediaQuery.of(context).size.height * 4 / 100,
                    // width: MediaQuery.of(context).size.width * 40 / 100,
                    height: 30,
                    width:82 ,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "Edit",
                      style: TextStyle(

                          color: Colors.black,
                      fontSize: 16
                          // fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              ],
            ),

          ),
        ),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: h / 4.5,
              padding: const EdgeInsets.all(16),
              // margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:Color(0xFF295AB3), // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  // color: Colors.white,
                  color:  Color(0xFF295AB3),
                  borderRadius: BorderRadius.only(
                      bottomLeft:Radius.circular(10) ,
                      bottomRight: Radius.circular(10)

                  ),
                  // border: Border.all(width: 1, color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 2,
                    ),
                  ]),
              child: Column(

                children: [
                  GestureDetector(
                    onTap:_pickImage,
                    child: Stack(children: [
                      _pickedImagePath != null
                          ? CircleAvatar(
                          radius: w / 12,
                          backgroundImage: FileImage(File(_pickedImagePath!))):

                      // iamgePath.length != 0
                      //     ? CircleAvatar(
                      //     radius: w / 12,
                      //     backgroundImage: NetworkImage('$path$iamgePath'))
                      //     : _pickedImagePath != null
                      //     ? CircleAvatar(
                      //     radius: w / 12,
                      //     backgroundImage: FileImage(File(_pickedImagePath!)))
                      //     :
                      CircleAvatar(
                        radius: w / 12,
                        // backgroundImage: AssetImage(
                        //   "assets/images/myprofile.png",
                        // ),
                        child: Icon(Icons.account_circle_sharp,size:60,color: Colors.white,),
                      ),
                      Positioned(
                        bottom: 0,
                        // right: w / 10,
                        right: 0,

                        child: Image.asset(
                          "assets/images/kk.png",
                          // color: kPrimaryColor,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        // right: w / 10,
                        right: 6,
                        child: Image.asset(
                          "assets/images/pen3.png",
                          color: kPrimaryColor,
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "ABC",
                    style: TextStyle(
                        color:Colors.white,
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    // color: Colors.red,
                    width: w,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: h / 20),
                          SizedBox(width: 30),
                          Icon(
                            Icons.phone,
                            size: 24,
                            color:Colors.white,
                            // color: kPrimaryColor,
                          ),
                          Text(
                            "91123456789",
                            style: TextStyle(
                                color:Colors.white,
                                // color: Color(0xff9399A7),
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '|',
                            style:
                            TextStyle(
                              // color: kPrimaryColor,
                                color:Colors.white,
                                fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.mail,
                            size: 24,
                            // color: kPrimaryColor,
                            color:Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "abc@gmail.com",
                            style: TextStyle(
                              color:Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              // color: Color(0xff686978)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // buildProfileInfo('Shop Name', vendorProfile?.data?.shopName),
            buildProfileInfo('Company Name', "ABC"),
            buildProfileInfo('Mobile Number', "1234567895"),
            buildProfileInfo('Email Id', "test@gmail.com"),
            buildProfileInfo('Address', "xyz 123456"),
            buildProfileInfo('Country/Region', "ABC"),
            buildProfileInfo('Description ', "ABC"),
          ],
        ),
      ),
    );
  }
}
