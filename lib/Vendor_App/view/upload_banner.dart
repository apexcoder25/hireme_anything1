import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../uiltis/color.dart';

class UploadBanner extends StatefulWidget {
  const UploadBanner({Key? key});

  @override
  State<UploadBanner> createState() => _UploadBannerState();
}

class _UploadBannerState extends State<UploadBanner> {
  final picker = ImagePicker();
  String? id;
  bool isLoading = true;
  bool isButtonEnabled = false;
  List<String> bannerStatusList = [];

  @override
  void initState() {
    super.initState();
    _loadId();
    Timer(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  _loadId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getString('id');
      print("banner-----$id-----");
      bannerget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colors.button_color,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Upload Banner",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  openImages();
                },
                child: Container(
                    height: 100,
                    child: Image.asset("assets/image/image-processing.png")),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                child: ElevatedButton(
                  onPressed: isButtonEnabled
                      ? () async {
                          await _uploadImages();
                          Get.back();
                        }
                      : null, // Disable button if images are not selected
                  style: ElevatedButton.styleFrom(
                    foregroundColor: isButtonEnabled
                        ? Colors.green
                        : Colors
                            .grey, // Change color based on button enable/disable
                  ),
                  child: Container(
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'Upload Banners',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              if (isLoading)
                LoadingAnimationWidget.fourRotatingDots(
                  color: Color.fromARGB(255, 12, 110, 42),
                  size: 50,
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    if (banners.isNotEmpty)
                      Container(
                        height: 450,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: banners.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3) ??
                                        Colors.transparent,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      'http://103.104.74.215:3092/uploads/${banners[index]}',
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showOptions(context, index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.5)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: GestureDetector(
                                    onTap: () {
                                      _showOptions(context, index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.list,
                                        color: Colors.black87,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                if (banners.isNotEmpty &&
                                    banners.length == bannerStatusList.length &&
                                    bannerStatusList[index] == "0")
                                  Center(
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        'Deactivated',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      )
                    else
                      Column(
                        children: [
                          Lottie.asset(
                            'assets/gif/homeempty.json',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                          Text('No banners available'),
                        ],
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future _uploadImages() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/shop_banner'),
      );
      if (id != null) {
        request.fields['shopId'] = id!;
      } else {
        print('ID is null, cannot upload images');
        return;
      }

      for (var image in imagefiles!) {
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = http.MultipartFile(
          'shopbanner',
          stream,
          length,
          filename: 'image_${DateTime.now().toLocal()}.jpeg',
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        print('Images uploaded successfully');
        print('API Response: $responseBody');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Banners Uploded Sucesfully'),
            duration: Duration(seconds: 2), // Adjust the duration as needed
            backgroundColor: Colors.green,
          ),
        );
      } else {
        print('Images upload failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
    print('ID: $id');
  }

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<String> banners = [];
  List<String> bannerId = [];

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      if (pickedfiles != null && pickedfiles.isNotEmpty) {
        setState(() {
          isButtonEnabled = true;
          imagefiles = pickedfiles;
        });
      } else {
        setState(() {
          isButtonEnabled = false;
        });
        print("No image is selected.");
      }
    } catch (e) {
      print("Error while picking files: $e");
    }
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        print("FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF ${bannerId[index]}");
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () {
                print('Delete tapped for index $index');
                _performAction(index);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.block, color: Colors.red),
              title: Text('Deactivate', style: TextStyle(color: Colors.red)),
              onTap: () {
                print('Deactivate tapped for index $index');
                _performActionad(index, "0"); // 0 for deactivate
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Banner Deactivate successfully'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.check, color: Colors.green),
              title: Text('Activate', style: TextStyle(color: Colors.green)),
              onTap: () {
                print('Activate tapped for index $index');
                _performActionad(index, "1"); // 1 for activate
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Banner Activate successfully'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
            // ListTile(
            //   leading: Icon(Icons.picture_as_pdf, color: Colors.black),
            //   title: Text('Upload PDF', style: TextStyle(color: Colors.black)),
            //   onTap: () {
            //     print('pdf tapped for index $index');
            //     // _pdfshowPopup(context, index);
            //   },
            // ),
          ],
        );
      },
    );
  }

  Future<void> bannerget() async {
    if (id == null) {
      print('Retrieved ID is null--------------banner');
      return;
    }
    final url = Uri.parse(
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/get_shop_banner');
    print("inside api $id");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'shopId': id!,
      }),
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print('Response data: ${response.body}');
      final responseData = json.decode(response.body);
      print("RRRRRRRRRRRRRRRR ${responseData['data']}");

      if (responseData['data'] != null) {
        var mm = responseData['data'];
        var count = responseData['count'];

        print("MMMMMMMMMMMMMMMMMMMMMMMMMMM ${mm}");

        for (var i = 0; i < count; i++) {
          print("MMMMMMMMMMMMMMMMMMMMMMMMMMM ${mm[i]["shopbanner"]}");
          //
          // var bannerData = responseData[i]['shopbanner'];
          // final bannerStatusData = responseData["data"]['banner_status'];
          banners.add(mm[i]['shopbanner']);
          bannerId.add(mm[i]['_id']);
          bannerStatusList.add(mm[i]['banner_status'].toString());
        }
        print("BBBBBBBBBBBBBBBBB ${banners}");
      } else {
        print('"data" is null or not present in the response data');
      }
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  Future<void> _performAction(int index) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? shopIdd = prefs.getString('id');
      print("$shopIdd");

      final url = Uri.parse(
          'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/delete_banner');
      print(bannerId[index]);
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'shopId': shopIdd,
          'bannerId': bannerId[index].toString(),
        }),
      );

      if (response.statusCode == 200) {
        print('Request successful');
        print('Response data: ${response.body}');
        setState(() {
          if (index < banners.length) {
            banners.removeAt(index);
          }
          if (index < bannerStatusList.length) {
            bannerStatusList.removeAt(index);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Banner deleted successfully'),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );

        print('Request failed with status: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Error performing request: $e');
    }
  }

  Future<void> _performActionad(int index, String action) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? shopIdd = prefs.getString('id');
      print("$shopIdd");

      final url = Uri.parse(
          'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/update_shop_banner_status');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'shopId': shopIdd,
          'bannerId': bannerId[index],
          'banner_status': action,
        }),
      );

      if (response.statusCode == 200) {
        print('Request successful');
        print('Response data: ${response.body}');
        setState(() {
          bannerStatusList[index] = action;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      print('Error performing request: $e');
    }
  }

  File? selectedFile;

  void pickDocument(BuildContext context, int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });

      // _pdfshowPopup(context, index);
    }
  }

  void uploadpdfffFile(int index) async {
    print("$id");
    print("$index");
    print("$selectedFile");

    if (selectedFile != null) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/shop_pdf'),
        );

        request.files.add(
          await http.MultipartFile.fromPath(
            'shoppdf',
            selectedFile!.path,
            contentType: MediaType('application', 'pdf'),
          ),
        );

        request.fields['shopId'] = id!;
        request.fields['index'] = index.toString();

        var response = await request.send();
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Pdf Upload successfully'),
              duration: Duration(seconds: 2), // Adjust the duration as needed
              backgroundColor: Colors.green,
            ),
          );
          var responseBody = await response.stream.bytesToString();
          print('File uploaded successfully. Response: $responseBody');
        } else {
          print('File upload failed. Status code: ${response.statusCode}');
        }
      } catch (e) {
        print('Error uploading file: $e');
      }
    } else {
      print('No file selected');
    }
  }

  // void _pdfshowPopup(BuildContext context, int index) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Center(child: Text('Select PDF')),
  //         content: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             SizedBox(
  //               height: 100,
  //               child: GestureDetector(
  //                 onTap: () {
  //                   pickDocument(context, index);
  //                 },
  //                 child: Image.asset("assets/image/pdfffdownload.png"),
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Text(
  //               selectedFile != null
  //                   ? 'Selected File: ${selectedFile!.path}'
  //                   : 'No file selected',
  //               style: TextStyle(fontSize: 12),
  //             ),
  //             SizedBox(height: 20),
  //             Container(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   uploadpdfffFile(index);
  //                   // Navigator.pop(context);
  //                   Navigator.pushReplacement(
  //                       context,
  //                       MaterialPageRoute(
  //                         builder: (context) => Nav_bar(),
  //                       ));
  //                   // Get.to(Profile());
  //                 },
  //                 style: ElevatedButton.styleFrom(
  //                   primary: Colors.green,
  //                   onPrimary: Colors.white,
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(5.0),
  //                     side: BorderSide(color: Colors.black, width: 0.3),
  //                   ),
  //                 ),
  //                 child: Text('Upload PDF'),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
