import 'dart:convert';
import 'package:fancy_button_flutter/fancy_button_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../uiltis/color.dart';
import 'add_product/product.dart';

class Cate_product_list extends StatefulWidget {
  const Cate_product_list({super.key});

  @override
  State<Cate_product_list> createState() => _Cate_product_listState();
}

class _Cate_product_listState extends State<Cate_product_list> {
  String? retrievedId;
  String catname = "";
  String productIds = "";
  bool isLoading = true;
  TextEditingController _searchController = TextEditingController();
  List<Category> categories = [];
  List<Category> filteredCategories = [];
  List<dynamic> categoryData = [];

  @override
  void initState() {
    super.initState();
    getCategoryFromSharedPreferences();
    sendPostRequest();
    getIdFromSharedPreferences().then((_) {
      if (retrievedId != null) {
        sendPostRequest();
        loadListWithLoader();
      }
    });
    sendPostRequest();
  }

  Future getCategoryFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final selectedCategory = prefs.getString('selectedCategory');
    if (selectedCategory != null) {
      catname = selectedCategory;
    }
  }

  Future<void> getIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    retrievedId = prefs.getString('id');
  }

  List<List<bool>> isSelectedList = [];
  void toggleSelection(int itemIndex, int buttonIndex) {
    setState(() {
      for (int index = 0; index < isSelectedList[itemIndex].length; index++) {
        isSelectedList[itemIndex][index] = (index == buttonIndex);
      }
    });
  }
  Future<void> loadListWithLoader() async {
    await sendPostRequest();
    setState(() {
      isLoading = false;
      isSelectedList = List.generate(filteredCategories.length, (_) => [true, false]);
    });
  }


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colors.scaffold_background_color,
      appBar: AppBar(
        foregroundColor: colors.white,
        backgroundColor: colors.button_color,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Sub Product",
          style: TextStyle(
              fontSize: 20, color: colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: Color.fromARGB(255, 12, 110, 42),
          size: 50,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15),
          child: Column(
            children: [
              Container(
                height: 55,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search product',
                    labelStyle: TextStyle(color: Colors.grey),
                    hintText: 'search product',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),

                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      filteredCategories = categories
                          .where((category) =>
                      category.productsname
                          .toLowerCase()
                          .contains(value.toLowerCase()) ||
                          category.barcodes.any((barcode) => barcode
                              .toLowerCase()
                              .contains(value.toLowerCase())))
                          .toList();

                      sortFilteredCategories(value);
                    });
                  },
                ),
              ),
              SizedBox(
                height: h / 60,
              ),

              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredCategories.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 13.0),
                    child: GestureDetector(
                      onTap: () {
                        showProductDetails(filteredCategories[index]);
                      },
                      child: Material(
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          height: h / 12,
                          width: w / 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 13.0,
                                top: 10,
                                right: 15,
                                bottom: 10),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: h / 12,
                                  width: w / 10,
                                  child: Image.network(
                                      filteredCategories[index]
                                          .image),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 2, left: 5),
                                  child: SizedBox(
                                    width: w / 6,
                                    child: Text(
                                        filteredCategories[index]
                                            .productsname,
                                        style: TextStyle(
                                            fontSize: 15)),
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  child: filteredCategories[index]
                                      .stockStatus ==
                                      1
                                      ? Container(
                                    child: Text(
                                      'Out of stock',
                                      style: TextStyle(
                                          color: Colors.red),
                                    ),
                                  )
                                      : Text(
                                    'In stock',
                                    style: TextStyle(
                                        color: Colors.green),
                                  ),
                                ),
                                SizedBox(width: w / 21.5),
                                Row(
                                  children: [
                                    Text(
                                      'GHS ${filteredCategories[index].price.toString()}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    PopupMenuButton<int>(
                                      onSelected: (value) async {
                                        if (value == 1) {
                                          final selectedProductId =
                                              filteredCategories[
                                              index]
                                                  .productId;
                                          SharedPreferences prefs =
                                          await SharedPreferences
                                              .getInstance();
                                          prefs.setString(
                                              'selectedProductId',
                                              selectedProductId);
                                        } else if (value == 2) {
                                          final selectedProductId =
                                              filteredCategories[
                                              index]
                                                  .productId;
                                          showDeleteConfirmationDialog(
                                              selectedProductId);
                                          sendPostRequest();
                                        }
                                      },
                                      itemBuilder:
                                          (BuildContext context) {
                                        return <PopupMenuEntry<
                                            int>>[
                                          PopupMenuItem<int>(
                                            value: 1,
                                            child: Text('Update'),
                                            onTap: () {
                                              // print("hjhjbjkbjkb"+.toString());
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder:
                                              //         (context) =>
                                              //         Product(mrp: categoryData[index]["mrp_price"], sale: categoryData[index]["price"],
                                              //         ),
                                              //   ),
                                              // );
                                            },
                                          ),
                                          PopupMenuItem<int>(
                                            value: 2,
                                            child: Text('Delete'),
                                            onTap: () {
                                              // Handle delete option
                                            },
                                          ),
                                          filteredCategories[index].stockStatus == 1
                                              ? PopupMenuItem<int>(
                                            value: 3,
                                            child: Text(
                                                'In Stock',
                                                style: TextStyle(
                                                    color: Colors
                                                        .green)),
                                            onTap: () async {
                                              await stockstatus(
                                                  filteredCategories[index].productId);
                                              // Update stock status and rebuild the UI
                                              setState(() {
                                                filteredCategories[index].stockStatus = 0;
                                              });
                                            },
                                          )
                                              : PopupMenuItem<int>(
                                            value: 3,
                                            child: Text(
                                                'Out Stock',
                                                style: TextStyle(
                                                    color: Colors
                                                        .red)),
                                            onTap: () async {
                                              await stockstatus(filteredCategories[index].productId);
                                              setState(() {
                                                filteredCategories[index].stockStatus = 1;
                                              });
                                            },
                                          ),
                                        ];
                                      },
                                      child: Icon(
                                        Icons.more_vert,
                                        size: 18,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  showProductDetails(Category product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          title: Text(product.productsname,style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.image,
                  height: 100,
                ),
                SizedBox(height: 10),
                Text('Price: GHS ${product.price}'),
                Text('MRP Price: GHS ${product.mrp_price}'),
                Text('Stock Status: ${product.stockStatus == 1 ? 'Out of Stock' : 'In Stock'}'),
                Text('GST: ${product.gst}%'),
                Text('Variants: ${product.variants}'),
                for (var entry in product.toJson().entries)
                  if (entry.key != 'image' &&
                      entry.key != 'productId' &&
                      entry.key != 'price' &&
                      entry.key != 'stock_status' &&
                      entry.key != 'variants')
                    Text('${entry.key}: ${entry.value}'),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.teal, // Button color
                  borderRadius: BorderRadius.circular(25), // Button border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.5), // Shadow color
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.teal.shade300], // Gradient colors
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Close',
                    style: TextStyle(
                      color: Colors.white, // Text color
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )



          ],
        );
      },
    );
  }
  Future<void> deleteProduct(String productId) async {
    final String apiUrl =
        'https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/delete_shopProduct';
    final Map<String, dynamic> data = {
      'shopId': retrievedId.toString(),
      'productId': productId,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      await sendPostRequest();
    } else {
      print("Error: ${response.statusCode}");
    }
  }
  void showDeleteConfirmationDialog(String productId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure!"),
          content: Text("You want to delete this product -"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(color: Colors.green, fontSize: 18)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Delete",
                  style: TextStyle(color: Colors.green, fontSize: 18)),
              onPressed: () async {
                await deleteProduct(productId);
                await sendPostRequest();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Product Delete Successfully'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.green,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void sortFilteredCategories(String query) {
    filteredCategories.sort((a, b) {
      bool aProductNameMatches =
      a.productsname.toLowerCase().startsWith(query.toLowerCase());
      bool aBarcodeMatches = a.barcodes.any(
              (barcode) => barcode.toLowerCase().startsWith(query.toLowerCase()));

      bool bProductNameMatches =
      b.productsname.toLowerCase().startsWith(query.toLowerCase());
      bool bBarcodeMatches = b.barcodes.any(
              (barcode) => barcode.toLowerCase().startsWith(query.toLowerCase()));

      if ((aProductNameMatches || aBarcodeMatches) &&
          !(bProductNameMatches || bBarcodeMatches)) {
        return -1;
      } else if (!(aProductNameMatches || aBarcodeMatches) &&
          (bProductNameMatches || bBarcodeMatches)) {
        return 1;
      } else {
        return 0;
      }
    });
  }

  Future<void> stockstatus(String productId) async {
    if (retrievedId == null) {
      return;
    }

    final url =
    Uri.parse('https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/shopStock');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'shopId': retrievedId!,
        'productId': productId.toString(),
      }),
    );

    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('POST request failed with status: ${response.statusCode}');
      print('Response data: ${response.body}');
    }
  }

  Future<void> sendPostRequest() async {
    if (retrievedId == null) {
      return;
    }

    final apiUrl =
    Uri.parse('https://kuchvkharido.xyz/salonHub_Franchise/Vendor_api/product_list');
    final data = {
      'shopId': retrievedId,
      'category_name': catname.toString(),
    };

    try {
      final response = await http.post(
        apiUrl,
        body: data,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        categoryData = jsonResponse['data'];

        setState(() {
          categories = categoryData
              .map((category) => Category.fromJson(category))
              .toList();
          filteredCategories = categories;
        });
      } else {
        print("Request failed with status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}

class Category {
  final String productsname;
  final String image;
  final int price;
  final int mrp_price; // Added MRP Price property
  final String productId;
  int stockStatus;
  final List<String> barcodes;
  final int gst;
  final String variants;

  Category({
    required this.productsname,
    required this.image,
    required this.price,
    required this.mrp_price,
    required this.productId,
    required this.stockStatus,
    required this.barcodes,
    required this.gst,
    required this.variants,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      productsname: json['products_name'],
      image: 'http://103.104.74.215:3092/uploads/${json['image'][0]}',
      price: json['price'],
      mrp_price: json['mrp_price'],
      productId: json['productId'],
      stockStatus: json['stock_status'],
      barcodes: List<String>.from(json['barcodes']),
      gst: json['gst'],
      variants: json['variants'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'price': price,
      'productId': productId,
      'stock_status': stockStatus,
      'barcodes': barcodes,
      'variants': variants,
    };
  }
}
