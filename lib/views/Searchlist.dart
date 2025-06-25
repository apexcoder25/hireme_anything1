import 'dart:async';

import 'package:hire_any_thing/views/service_detail_screen.dart';
import 'package:hire_any_thing/views/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../utilities/constant.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int _currentPage = 0;
  int _currentPage1 = 0;
  bool isLiked = false;

  List test = ["Blood", "Urine", "Heart"];
  TextEditingController _controller = TextEditingController();
  late Timer _timer;
  int _currentIndex = 0;
  List<String> _autoTypeTexts = ['\'Doctor\'', '\'Plumber\'', '\'Haircut\''];
  String _typedText = '';

  late FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _startAutoTyping();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _startAutoTyping() {
    _timer = Timer.periodic(Duration(milliseconds: 150), (timer) {
      if (!_focusNode.hasFocus) {
        setState(() {
          if (_currentIndex < _autoTypeTexts.length) {
            String currentWord = _autoTypeTexts[_currentIndex];
            String newText = "Search For $currentWord";

            if (_typedText != newText) {
              if (_typedText.length < newText.length) {
                _typedText = newText.substring(0, _typedText.length + 1);
              }
            } else {
              _currentIndex++;
              _typedText = 'Search For';
            }
          } else {
            _currentIndex = 0;
          }
        });
      }
    });
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _timer.cancel();
    } else {
      _startAutoTyping();
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SafeArea(
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.black,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          // bottomNavigationBar: Navi(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    child: Text(
                      "Location",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: kPrimaryColor,
                    ),
                    Text(
                      " New York, USA",
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.normal),
                    ),
                    Icon(Icons.keyboard_arrow_down_outlined,
                        color: Colors.black, size: 20),
                  ],
                )
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/carticon.svg',
                  semanticsLabel: 'My SVG Image',
                  // ignore: deprecated_member_use
                  color: Colors.grey,
                  height: h / 35,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  'assets/icons/solar_bell-bold.svg',
                  semanticsLabel: 'My SVG Image',
                  // ignore: deprecated_member_use
                  color: Colors.grey,
                  height: h / 35,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 10, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller:
                                  TextEditingController(text: _typedText),
                              focusNode: _focusNode,
                              readOnly: false,
                              showCursor: true,
                              cursorColor: Colors.black,
                              cursorWidth: 2.0,
                              cursorHeight: 24.0,
                              textAlign: TextAlign.left,
                              autofocus: true,
                              onChanged: (text) {
                                _typedText = text;
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 2),
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.grey),
                                hintText: "John",
                                hintStyle: const TextStyle(fontSize: 14),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      width: 1, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      FilterScreen(),
                                ),
                              );
                            },
                            child: Container(
                              height:45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.5),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Icon(
                                  Icons.filter_alt_rounded,
                                  color: Colors.white,
                                  size: 32,
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Great! Please select the hire_any_thing which suits you best",
                              style: TextStyle(
                                  color: klightblackTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),


                        ],
                      ),

                    ],
                  ),
                ),
                Container(
                  height: h,
                  width: w,
                  color: Colors.white12,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                            itemCount: 4,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServiceDetailScreen(
                                                cat_name: "Mini Bus",
                                                image:
                                                    "assets/new/Horse and Carriage.jpeg",
                                              )));
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      height: h * .36,
                                      margin: EdgeInsets.only(
                                          left: 15, right: 15, bottom: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Container(
                                              height: h * .2,
                                              width: double.infinity,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: Image.asset(
                                                    "assets/new/Horse and Carriage.jpeg",
                                                    alignment: Alignment.center,
                                                    fit: BoxFit.cover,
                                                  )),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Horse and Carriage",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      "\$5000",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: kPrimaryColor),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color:
                                                          Colors.grey.shade400,
                                                      size: 17,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "Austria",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "-",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Icon(
                                                      Icons.star_border,
                                                      color:
                                                          Colors.grey.shade400,
                                                      size: 17,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "4.9 (12.6k)",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade400,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                //  3 containe rs
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * .25,
                                                      height: h * .05,
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .person_outline,
                                                            size: 17,
                                                          ),
                                                          SizedBox(
                                                            width: h * .01,
                                                          ),
                                                          Text(
                                                            "4 Guests",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   width: w * .25,
                                                    //   height: h * .05,
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Icon(
                                                    //         Icons.bed_outlined,
                                                    //         size: 17,
                                                    //       ),
                                                    //       SizedBox(
                                                    //         width: h * .01,
                                                    //       ),
                                                    //       Text(
                                                    //         "2 Beds",
                                                    //         style: TextStyle(
                                                    //             fontSize: 12,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold),
                                                    //       )
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                    // Container(
                                                    //   width: w * .25,
                                                    //   height: h * .05,
                                                    //   child: Row(
                                                    //     children: [
                                                    //       Icon(
                                                    //         Icons
                                                    //             .bathtub_outlined,
                                                    //         size: 17,
                                                    //       ),
                                                    //       SizedBox(
                                                    //         width: h * .01,
                                                    //       ),
                                                    //       const Text(
                                                    //         "2 Baths",
                                                    //         style: TextStyle(
                                                    //             fontSize: 12,
                                                    //             fontWeight:
                                                    //                 FontWeight
                                                    //                     .bold),
                                                    //       )
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      top: h * .03,
                                      right: w * .1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isLiked = !isLiked;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            size: 17,
                                            isLiked
                                                ? Icons.favorite
                                                : Icons
                                                    .favorite_border, // Unliked icon
                                            // color: kPrimaryColor,
                                            color:Color(0xFF25D366),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
