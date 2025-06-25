import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cutom_widgets/button.dart';
import '../../cutom_widgets/signup_textfilled.dart';
import '../../uiltis/color.dart';
import '../Navagation_bar.dart';

class Product extends StatefulWidget {
  final mrp;
  final sale;

  const Product({super.key,required this.mrp,required this.sale});
  @override
  State<Product> createState() => _ExistingProductState();
}

class _ExistingProductState extends State<Product> {
  File? _image;
  String? retrievedId;

  @override
  void initState() {
    super.initState();
    Dropdownone();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('-------Retrieved data fil shop ID: $retrievedId');
        print('-------Retrieved data fil shop ID: $retrievedId');
      } else {}
    });
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
    print("data fill -----------Retrieved ID: $retrievedId");
  }

  List subtype = [];
  String? selectedValueone;
  List<String> optionsone = ['meat', 'fish', 'chikan', 'mass'];

  List<String> gstlist = ['0', '5', '12', '18', '28'];
  String? selectedgst;

  List<Map<String, dynamic>> categories = [];
  String? selectedCategory;
  String? selectedCategoryId;

  Future Dropdownone() async {
    final response = await http.get(
        Uri.parse('https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/category_list'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['result'] == 'true') {
        final categoryData = data['data'];
        setState(() {
          categories = List<Map<String, dynamic>>.from(categoryData);
        });
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  String? code;
  List<Widget> selectedImagesWidgetsList = [];
  TextEditingController shopname = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController brandname = TextEditingController();
  TextEditingController barcodess = TextEditingController();
  TextEditingController varientt = TextEditingController();
  TextEditingController mrpricee = TextEditingController();
  TextEditingController salepricee = TextEditingController();
  TextEditingController descri = TextEditingController();

  uploadUpdateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedProductId = prefs.getString('selectedProductId') ?? "";
    print("Selected Product ID in another screen: $selectedProductId");

    var uri = Uri.parse(
        "https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/update_shopProduct");
    var request = http.MultipartRequest('POST', uri);

    // if (imagefiles != null && imagefiles!.isNotEmpty) {
    //   for (var image in imagefiles!) {
    //     var stream = http.ByteStream(image.openRead());
    //     var length = await image.length();
    //     var multipartFile = http.MultipartFile(
    //       'images',
    //       stream,
    //       length,
    //       filename: 'image_${DateTime.now().toLocal()}.jpeg',
    //       contentType: MediaType('image', 'jpeg'),
    //     );
    //     request.files.add(multipartFile);
    //   }
    // }

    request.fields['productId'] = selectedProductId;
    if (selectedValue != null && selectedValue!.isNotEmpty) {
      request.fields['subcategory'] = selectedValue!;
    }
    /*
    if (productname.text.isNotEmpty) {
      request.fields['products_name'] = productname.text;
    }
    if (brandname.text.isNotEmpty) {
      request.fields['brand_name'] = brandname.text;
    }
    if (barcodess.text.isNotEmpty) {
      request.fields['barcodes'] = barcodess.text;
    }
    if (selectedgst != null && selectedgst!.isNotEmpty) {
      request.fields['gst'] = selectedgst!;
    }
    if (varientt.text.isNotEmpty) {
      request.fields['variants'] = varientt.text;
    }*/
    if (mrpricee.text.isNotEmpty) {
      request.fields['mrp_price'] = mrpricee.text;
    }
    if (salepricee.text.isNotEmpty) {
      request.fields['sale_price'] = salepricee.text;
    }
    // if (descri.text.isNotEmpty) {
    //   request.fields['description'] = descri.text;
    // }

    try {
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);
      print(jsonResponse);
      if (response.statusCode == 200) {
        print(
            "-------------------------Update product--------------------------------");
        return "done";
      } else {
        print("Failed to upload. Status code: ${response.statusCode}");
        print(
            "-------------------------Update product failed--------------------------------");
      }
    } catch (e) {
      print("Failed to update profile: $e");
      print(
          "-------------------------Update no product--------------------------------");
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
        centerTitle: true,
        title: Text("Update Product",
            style: TextStyle(
                fontSize: 20,
                color: colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: (){
                    openImages();
                  },
                  child: Container(
                      height: 100,
                      child: Image.asset("assets/image/uoload_banner.png")),
                ),
              ),*/

              SizedBox(
                height: 30,
              ),
              /*Text("Select Your Category",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child:

                    DropdownButton<String>(
                      value: selectedCategory,
                      hint: Text("Category"),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategory = newValue;
                          // Instead of selectedValueone, set selectedCategoryId here
                          selectedCategoryId = categories.firstWhere(
                                  (category) => category['category_name'] == newValue)['categoryId'];
                          print('Selected Category ID: $selectedCategoryId');
                          print('Selected Category Name: $selectedCategory'); // Print the selected category name
                          subtypelist();
                        });
                      },
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['category_name'],
                          child: Text(category['category_name']),
                        );
                      }).toList(),
                    )

                ),
              ),


              Text("Select Your Sub Category",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child:
                    DropdownButton(
                        value: selectedValue,
                        hint: (subtype.isEmpty)
                            ? Text("Sub-Category")
                            : Text("Select subcategory"),
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue as String?;
                          });
                        },
                        items: subtype.map((it) {
                          return DropdownMenuItem(value: it, child: Text(it));
                        }).toList()),
                  ),
                ),
              ),


              Text("Entre Shop Name",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: shopname,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "Shop",
                ),
              ),


              Text("Entre Product Name",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: productname,
                  length: 50,
                  hinttext: "Products",
                ),
              ),


              Text("Entre Brand Name",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: brandname,
                  length: 50,
                  //keytype: TextInputType.number,
                  hinttext: "Brand",
                ),
              ),
              Text("Entre Barcodes",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: barcodess,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "Barcodes",
                ),
              ),
              Text("Entre Variants In Kg",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: varientt,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "Variants",
                ),
              ),*/
              Text("Entre  Mrp Price*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: mrpricee,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "${widget.mrp}",
                ),
              ),
              Text("Entre Sale Price*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: salepricee,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "${widget.sale}",
                ),
              ),
              /*Text("Select GST %",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButton<String>(
                      value: selectedgst,
                      items: gstlist.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child:
                          Text(value, style: TextStyle(color: Colors.grey)),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Use String? here
                        setState(() {
                          selectedgst = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ),*/
              // Text("Entre Desciption",
              //     style: TextStyle(color: Colors.black87, fontSize: 16)),
              /*SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Signup_textfilled(
                  textfilled_height: 17,
                  textfilled_weight: 1,
                  textcont: descri,
                  length: 50,
                  keytype: TextInputType.name,
                  hinttext: "Entre Desciption",
                ),
              ),*/

              // Button_widget(
              //   buttontext: "Done",
              //   button_height: 20,
              //   button_weight: 1,
              //   onpressed: () {
              //     bool isValid = true;
              //
              //     if (mrpricee.text.isEmpty || salepricee.text.isEmpty) {
              //       // Show a SnackBar with an error message
              //       isValid = false;
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(
              //           content: Text("Mrp Price and Sale Price are required."),
              //         ),
              //       );
              //     } else {
              //       uploadUpdateData();
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => Nav_bar(),
              //           ));
              //     }
              //   },
              // ),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (
                        mrpricee.text.isEmpty || salepricee.text.isEmpty
                        ) {
                          return Colors.grey;
                        }
                        return Colors.green;
                      },
                    ),
                  ),
                  onPressed: () {
                    bool isValid = true;

                    if (
                    mrpricee.text.isEmpty || salepricee.text.isEmpty
                    ) {
                      // Show a SnackBar with an error message
                      isValid = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Mrp Price and Sale Price are required."),
                        ),
                      );
                    } else {
                      uploadUpdateData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Nav_bar(),
                        ),
                      );
                    }
                  },
                  child: Text("Done"),
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? selectedValue;
  final String apiUrl =
      'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/shopcategory_list'; // Replace with your API URL
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  Future subpostData() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'categoryId': selectedCategoryId,
      },
    );
    print('Selected Category ID----: $selectedCategoryId');
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("Error while picking files: $e");
    }
  }

  subtypelist() async {
    var response = await http.post(
        Uri.parse(
            "https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/shopcategory_list"),
        body: {"categoryId": selectedCategoryId.toString()});

    var response_data = json.decode(response.body);
    print(response.body);

    print(response_data);

    if (response.statusCode == 200 &&
        response_data["result"].toString() == "true".toString()) {
      print("Successful");
      subtype.clear();
      print(response_data["data"][0]["subcategory"].toString());
      for (int i = 0; i != response_data["data"].length; i++) {
        print(response_data["data"][i]["subcategory"].toString());
        subtype.add(response_data["data"][i]["subcategory"].toString());
      }
      setState(() {
        selectedValue = response_data["data"][0]["subcategory"].toString();
      });

      print("Done");
      print(subtype);
    } else {}
  }
}
