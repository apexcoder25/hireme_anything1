import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../cutom_widgets/signup_textfilled.dart';
import '../../uiltis/color.dart';
import '../Navagation_bar.dart';
import '../add_category.dart';

class ExistingProduct extends StatefulWidget {
  const ExistingProduct({super.key});

  @override
  State<ExistingProduct> createState() => _ExistingProductState();
}

class _ExistingProductState extends State<ExistingProduct> {
  String? selectedVariant;
  bool isLoading = false;
  File? _image;
  String? retrievedId;
  final imageUrl = "http://103.104.74.215:3092/uploads";

  @override
  void initState() {
    super.initState();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        print('-------Retrieved data fil shop ID: $retrievedId');
        dropdownnew();
        // Dataproname();
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

  //List<String> optionsone = ['meat', 'fish', 'chikan', 'mass'];

  List<String> gstlist = ['0', '5', '12', '18', '28', '8'];
  String selectedgst = "0";

  List<Map<String, dynamic>> categories = [];
  String? selectedCategory;
  String? selectedCategoryId;
  String? caegoryiddd;
  String? code;
  String barcodeResult = "Scan a barcode";

  TextEditingController shopname = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController brandname = TextEditingController();
  TextEditingController barcodess = TextEditingController();
  TextEditingController varientt = TextEditingController();
  TextEditingController mrpricee = TextEditingController();
  TextEditingController salepricee = TextEditingController();
  TextEditingController descri = TextEditingController();
  TextEditingController searchbyname = TextEditingController();

  uploadData(String selectedCategory) async {
    var uri = Uri.parse(
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/create_shopProduct');
    var request = http.MultipartRequest('POST', uri);

    if (imageFiles != null) {
      for (var image in imageFiles!) {
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = http.MultipartFile(
          'images',
          stream,
          length,
          filename: 'image_${DateTime.now().toLocal()}.jpeg',
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }
    } else {
      for (var image in selectedqrcode!) {
        print(image.toString() + "jhsjjscbjbcsj");
        var stream = http.ByteStream(image.openRead());
        var length = await image.length();
        var multipartFile = http.MultipartFile(
          'images',
          stream,
          length,
          filename: 'image_${DateTime.now().toLocal()}.jpeg',
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }
    }

    request.fields['shopId'] = retrievedId.toString();
    request.fields['category'] = selectedCategory;
    print("$selectedCategoryId");
    request.fields['subcategory'] = selectedValue.toString();
    request.fields['products_name'] = productname.text.toString();
    request.fields['brand_name'] = brandname.text.toString();
    request.fields['barcodes'] = barcodess.text.toString();
    request.fields['variants'] = varientt.text.toString();
    request.fields['mrp_price'] = mrpricee.text.toString();
    request.fields['sale_price'] = salepricee.text.toString();
    // request.fields['description'] = descri.text.toString();

    if (descri.text.isNotEmpty) {
      request.fields['description'] = descri.text.toString();
    }

    request.fields['gst'] = selectedgst.toString();

    try {
      var response = await request.send();
      var responseString = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseString);
      print(jsonResponse);

      if (response.statusCode == 200) {
        return "done";
      } else {
        print("Failed to upload. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Failed to update profile: $e");
    }
  }

  uploadData1(String selectedCategory) async {
    Map body = {
      'images': selectedproduc[0].toString(),
      "shopId": retrievedId.toString(),
      "category": selectedCategory,
      "subcategory": selectedValue.toString(),
      "products_name": productname.text.toString(),
      "brand_name": brandname.text.toString(),
      "variants": varientt.text.toString(),
      "barcodes": barcodess.text.toString(),
      "mrp_price": mrpricee.text.toString(),
      "gst": selectedgst.toString(),
      "sale_price": salepricee.text.toString(),
      "description": descri.text.toString(),
    };

    try {
      var res = await http.post(
          Uri.parse(
              'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/create_masterProduct'),
          body: body);
      var resData = json.decode(res.body);
      print("dhflkdhfl" + resData.toString());
      if (res.statusCode == 200 &&
          resData["result"].toString() == "true".toString()) {
      } else {}
    } catch (e) {}
  }

  List<String> searchResults = [];
  List<String> varientsssss = [];

  Future<void> _searchProducts(String searchTerm) async {
    const String apiUrl = '';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({"products_name": searchbyname.text.toString()}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['result'] == 'true') {
        setState(() {
          searchResults = List<String>.from(
              data['data'].map((result) => result['product_name'].toString()));
          varientsssss = List<String>.from(
              data['data'].map((result) => result['variants'].toString()));
        });
      } else {
        print("Error: ${data['message']}");
      }
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  // Dataproname();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: colors.white),
        ),
        backgroundColor: colors.button_color,
        elevation: 0,
        centerTitle: true,
        title: const Text("Add New Product",
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
              ListView.builder(
                itemCount: searchResults.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 15),
                    child: GestureDetector(
                      onTap: () {
                        Dataproname(searchResults[index].toString());
                        setState(() {
                          searchResults.clear();
                          varientsssss.clear();
                        });
                        // print(searchResults[index].toString());
                      },
                      child: Row(
                        children: [
                          Text(searchResults[index],
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(
                            width: 11,
                          ),
                          Text(varientsssss[index],
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    openImages();
                  },
                  child: Container(
                      height: 90,
                      child: Image.asset("assets/image/image-processing.png")),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Visibility(
                  visible: selectedImages.isEmpty
                      ? selectedproduc.isNotEmpty
                      : selectedImages.isNotEmpty,
                  child: buildSelectedImages(selectedImages),
                ),
              ),
              const Text("Select Your Category*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0, top: 10),
                child: Container(
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade200,
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    width: double.infinity,
                    child: DropdownButton<String>(
                      value: selectedCategory,
                      underline: Container(
                        height: 0,
                      ),
                      hint: const Text("Category"),
                      onChanged: (newValue) {
                        setState(() {
                          selectedCategory = newValue;
                          selectedCategoryId = categories.firstWhere(
                              (category) =>
                                  category['category_name'] ==
                                  newValue)['categoryId'];
                          print('Selected Category ID: $selectedCategoryId');
                          print(
                              'Selected Category Name: $selectedCategory'); // Print the selected category name
                          subtypelist();
                        });
                      },
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category['category_name'],
                          child: Text(category['category_name']),
                        );
                      }).toList(),
                    )),
              ),
              const Text("Select Your Sub Category*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  width: double.infinity,
                  // color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DropdownButton(
                        underline: Container(
                          height: 0,
                        ),
                        value: selectedValue,
                        hint: (subtype.isEmpty)
                            ? const Text("Subcategory")
                            : const Text("Select subcategory"),
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
              const Text("Product Name*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Signup_textfilled(
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    textcont: productname,
                    length: 50,
                    hinttext: "Products",
                  ),
                ),
              ),
              const Text("Brand Name*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Signup_textfilled(
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    textcont: brandname,
                    length: 50,
                    //keytype: TextInputType.number,
                    hinttext: "Brand",
                  ),
                ),
              ),
              const Text("Variants*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Signup_textfilled(
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    textcont: varientt,
                    length: 50,
                    keytype: TextInputType.name,
                    hinttext: "Variants",
                  ),
                ),
              ),
              const Text("Mrp Price*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Signup_textfilled(
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    textcont: mrpricee,
                    length: 50,
                    keytype: TextInputType.phone,
                    hinttext: "Mrp",
                  ),
                ),
              ),
              const Text("Sale Price*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Signup_textfilled(
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    textcont: salepricee,
                    length: 50,
                    keytype: TextInputType.phone,
                    hinttext: "Sale Price",
                  ),
                ),
              ),
              const Text("Desciption*",
                  style: TextStyle(color: Colors.black87, fontSize: 16)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 1,
                            blurRadius: 1)
                      ]),
                  child: Signup_textfilled(
                    textfilled_height: 17,
                    textfilled_weight: 1,
                    textcont: descri,
                    length: 50,
                    keytype: TextInputType.name,
                    hinttext: "Desciption",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (selectedImages.isNotEmpty ||
                              selectedproduc.isNotEmpty) {
                            if (selectedCategory == null ||
                                    productname.text.isEmpty ||
                                    brandname.text.isEmpty ||
                                    // barcodess.text.isEmpty ||
                                    varientt.text.isEmpty ||
                                    mrpricee.text.isEmpty ||
                                    salepricee.text.isEmpty ||
                                    selectedgst == null
                                //|| descri.text.isEmpty
                                ) {
                              return Colors.grey;
                            }
                            return Colors.green;
                          }
                          return Colors.grey;
                        },
                      ),
                    ),
                    onPressed: () async {
                      if (selectedImages.isNotEmpty ||
                          selectedproduc.isNotEmpty) {
                        if (selectedCategory == null ||
                                productname.text.isEmpty ||
                                brandname.text.isEmpty ||
                                // barcodess.text.isEmpty ||
                                varientt.text.isEmpty ||
                                mrpricee.text.isEmpty ||
                                salepricee.text.isEmpty ||
                                selectedgst == null
                            //|| descri.text.isEmpty
                            ) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Please fill in all fields and select an image.'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else if (selectedproduc.isNotEmpty) {
                          await uploadData1(selectedCategory!);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Nav_bar(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product uploaded successfully'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          await uploadData(selectedCategory!);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              // builder: (context) => Nav_bar(),
                              builder: (context) => const Add_category(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product uploaded successfully'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an image.'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text(
                        "Done"), // You can customize the child text as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? selectedValue;
  final String apiUrl =
      'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/shopcategory_list';

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

  subtypelist() async {
    print("********$selectedCategoryId");
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

  Future dropdownnew() async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/get_category_list';
    final Map<String, dynamic> data = {
      'shopId': retrievedId.toString(),
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['result'] == 'true') {
        final categoryData = data['data'];
        setState(() {
          categories = List<Map<String, dynamic>>.from(categoryData);
        });
      }
      print("Response: ${response.body}");
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  String safeString(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is List && value.isNotEmpty && value[0] is String) {
      return value[0];
    } else {
      return "";
    }
  }

  void Dataproname(String product_namee) async {
    print("11111111");
    print("$retrievedId");
    print("$product_namee");
    final String url =
        "https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/search_master_list";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          //"products_name": searchbyname.text.toString(),
          "products_name": product_namee.toString(),
        }),
      );

      if (response.statusCode == 200) {
        print("Response: ${response.body}");
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        Map<String, dynamic> data = jsonResponse['data'];

        caegoryiddd = jsonResponse['categoryId'];
        print("fgfdgfdggf$caegoryiddd");

        String safeString(dynamic value) {
          if (value is String) {
            return value;
          } else if (value is List && value.isNotEmpty && value[0] is String) {
            return value[0];
          } else {
            return "";
          }
        }

        setState(() {
          productname.text = safeString(data['product_name']);
          brandname.text = safeString(data['brand_name']);
          barcodess.text = safeString(data['barcode']);
          varientt.text = safeString(data['variants']);
          mrpricee.text = safeString(data['mrp_price']);
          salepricee.text = safeString(data['sale_price']);
          descri.text = safeString(data['description']);
          selectedgst = safeString(data['gst'].toString());
          print("778hsjshjcjxb" + safeString(data['category_name'].toString()));
          selectedCategory = safeString(data['category_name'].toString());
          selectedCategoryId = caegoryiddd;
          selectedproduc = data['images'];
        });

        await subtypelist();

        _showAutoHidePopup(context);
        print("Product Name: ${productname.text}");
        print("Brand Name: ${brandname.text}");
        print("Barcodes: ${barcodess.text}");
        print("Variants: ${varientt.text}");
        print("MRP Price: ${mrpricee.text}");
        print("Sale Price: ${salepricee.text}");
        print("Description: ${descri.text}");
        print("GST: $selectedgst");
        print("Category: $selectedCategory");
        print("Selected Value: $selectedValue");
        print("ID: $selectedCategoryId");
      } else {
        else_showAutoHidePopup(context);
        print("Error: ${response.statusCode}");
        print(response.body);
      }
    } catch (e) {
      else_showAutoHidePopup(context);
      print("Exception: $e");
    }
  }

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imageFiles;
  List<File> selectedImages = [];
  List selectedproduc = [];
  List selectedqrcode = [];

  Future<void> openImages() async {
    try {
      final ImagePicker _picker = ImagePicker();
      List<XFile>? pickedFiles;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shadowColor: Colors.green,
            title: const Text(
              "Choose an option",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context,
                      [await _picker.pickImage(source: ImageSource.camera)]);
                },
                child: const Text('Camera',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 5,
              ),
              SimpleDialogOption(
                onPressed: () async {
                  pickedFiles = await _picker.pickMultiImage();
                  Navigator.pop(context, pickedFiles);
                },
                child: const Text('Gallery',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ),
            ],
          );
        },
      );

      if (pickedFiles != null && pickedFiles!.isNotEmpty) {
        setState(() {
          imageFiles = pickedFiles;
          selectedImages
              .addAll(pickedFiles!.map((file) => File(file.path)).toList());
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("Error while picking files: $e");
    }
  }

  Widget buildSelectedImages(List<File> selectedImages) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: selectedImages.isEmpty
            ? selectedproduc.length
            : selectedImages.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(8),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: selectedImages.isEmpty
                    ? Image.network(
                            "http://103.104.74.215:3026/uploads/${selectedproduc.elementAt(index)}")
                        .image
                    : Image.file(selectedImages[index]).image,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  // void Datainset_qr(String scannedCode) async {
  //   print("11111111");
  //   print("$retrievedId");
  //   print("$scannedCode");
  //   final String url =
  //       "https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/productInsert_toQr";
  //
  //   try {
  //     final response = await http.post(
  //       Uri.parse(url),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode({
  //         //"shopId": "65698899a286659227113e6f",
  //         "shopId": retrievedId.toString(),
  //         //"barcode": "12345",
  //         "barcode": scannedCode.toString(),
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print("Response: ${response.body}");
  //       Map<String, dynamic> jsonResponse = json.decode(response.body);
  //       Map<String, dynamic> data = jsonResponse['data'];
  //
  //       caegoryiddd = jsonResponse['categoryId'];
  //       print("fgfdgfdggf$caegoryiddd");
  //
  //       String safeString(dynamic value) {
  //         if (value is String) {
  //           return value;
  //         } else if (value is List && value.isNotEmpty && value[0] is String) {
  //           return value[0];
  //         } else {
  //           return "";
  //         }
  //       }
  //
  //       setState(() {
  //         productname.text = safeString(data['product_name']);
  //         brandname.text = safeString(data['brand_name']);
  //         barcodess.text = safeString(data['barcode']);
  //         varientt.text = safeString(data['variants']);
  //         mrpricee.text = safeString(data['mrp_price']);
  //         salepricee.text = safeString(data['sale_price']);
  //         descri.text = safeString(data['description']);
  //         selectedgst = safeString(data['gst'].toString());
  //         print("778hsjshjcjxb" + safeString(data['category_name'].toString()));
  //         selectedCategory = safeString(data['category_name'].toString());
  //         selectedCategoryId = caegoryiddd;
  //         selectedproduc = data['images'];
  //       });
  //
  //       await subtypelist();
  //
  //       _showAutoHidePopup(context);
  //       print("Product Name: ${productname.text}");
  //       print("Brand Name: ${brandname.text}");
  //       print("Barcodes: ${barcodess.text}");
  //       print("Variants: ${varientt.text}");
  //       print("MRP Price: ${mrpricee.text}");
  //       print("Sale Price: ${salepricee.text}");
  //       print("Description: ${descri.text}");
  //       print("GST: $selectedgst");
  //       print("Category: $selectedCategory");
  //       print("Selected Value: $selectedValue");
  //       print("ID: $selectedCategoryId");
  //     } else {
  //       else_showAutoHidePopup(context);
  //       print("Error: ${response.statusCode}");
  //       print(response.body);
  //     }
  //   } catch (e) {
  //     else_showAutoHidePopup(context);
  //     print("Exception: $e");
  //   }
  // }

  void _showAutoHidePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Product Found Sucesfully In Master Database'),
        );
      },
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  void else_showAutoHidePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text('Product not Found In Master Database'),
        );
      },
    );
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
  }
}
