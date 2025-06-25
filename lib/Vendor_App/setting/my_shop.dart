import 'package:hire_any_thing/Vendor_App/uiltis/color.dart';
import 'package:flutter/material.dart';

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

class Myshop extends StatefulWidget {
  @override
  State<Myshop> createState() => _MyshopState();
}

class _MyshopState extends State<Myshop> {
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
  //   Uri.parse('http://103.104.74.215:3092/vendor/api/getVenderProfile');
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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
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

  Widget buildImageSection() {
    return Container(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          scrollDirection: Axis.horizontal,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: colors.white,
        backgroundColor: colors.button_color,
        title: const Text('Shop Detail'),
      ),
      body:
          // isLoading
          //     ? Center(
          //   child: LoadingAnimationWidget.fourRotatingDots(
          //     color: const Color.fromARGB(255, 12, 110, 42),
          //     size: 50,
          //   ),
          // )
          //     :
          SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileInfo('Shop Name', "abcd"),
            // buildProfileInfo('Legal Name', vendorProfile?.data?.legalnameee),
            buildProfileInfo('Mobile Number', "123456789"),
            buildProfileInfo('Email Id', "text123@gmail.com"),
            buildProfileInfo('Address', "XYZ 1232456"),
            buildProfileInfo('Area', "XYZ"),
            buildProfileInfo('Delivery Charge', '₹ 40'),
            // buildProfileInfo('Max Distance', '${vendorProfile?.data.maxdistanceee} km'),
            // buildProfileInfo('Flat Delivery Charge', '₹ ${vendorProfile?.data.flatdeliverycharge}'),
            // buildProfileInfo('Minimum Order', '₹ ${vendorProfile?.data.minorder}'),
            // buildProfileInfo('Account Number', vendorProfile?.data.acc_nomb.toString()),
            // buildProfileInfo('IFSC Code', vendorProfile?.data.ifsccodee.toString()),
            // buildProfileInfo('Manager Name', vendorProfile?.data.managernamee.toString()),
            buildProfileInfo('Open Time', "10:00 AM"),
            buildProfileInfo('Close Time', "9:00 PM"),
            // buildProfileInfo('II - Open Time', vendorProfile?.data.openTimead.toString()),
            // buildProfileInfo('II - Close Time', vendorProfile?.data.closeTimead.toString()),
            // buildProfileInfo('II - Shop Address', vendorProfile?.data.shopAddressad),
            // if (vendorProfile!.data.shopImage.isNotEmpty) buildImageSection(),
          ],
        ),
      ),
    );
  }
}
