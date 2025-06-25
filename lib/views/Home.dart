import 'dart:async';

import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:hire_any_thing/views/Category/sub_categories_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../payment/Address.dart';
import '../utilities/constant.dart';
import '../utilities/custom_indicator.dart';
import 'Category/all_category_screen.dart';
import 'EnquiryFormActivity.dart';
import 'Notification_list.dart';
import 'Searchlist.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPage = 0;
  int _currentPage1 = 0;

  List test = ["Blood", "Urine", "Heart"];

  String? InitialdropdownValueCountry = 'New York';

  TextEditingController _controller = TextEditingController();
  late Timer _timer;
  int _currentIndex = 0;
  List<String> _autoTypeTexts = [
    '\'limousine\'',
    '\'Boat\'',
    '\'Coach\' ',
    '\'Minibus\''
  ];

  String _typedText = '';

  late FocusNode _focusNode = FocusNode();

  List<Map<String, String>> topCategory = [
    {"image": "assets/new/limousine.jpg", "name": "Limousine Hire"},
    {"image": "assets/new/minibus.jpeg", "name": "Minibus Hire"},
    {"image": "assets/new/Coach.jpeg", "name": "Coach Hire"},
    {
      "image": "assets/new/Horse and Carriage.jpeg",
      "name": "Horse and Carriage Hire"
    },
    {"image": "assets/new/Boat.jpeg", "name": "Boat Hire"},
    {"image": "assets/new/FuneralCar.webp", "name": "Funeral Car Hire"},
    {
      "image": "assets/new/ChauffeurDrivenPrestige .jpg",
      "name": "Chauffeur Driven Prestige Car Hire"
    },
    {
      "image": "assets/new/Horse and Carriage.jpeg",
      "name": "Horse and Carriage Hire"
    },
    {"image": "assets/new/limousine.jpg", "name": "Limousine Hire"},
  ];

  Future<dynamic> getAddress() async {
    final sessionManager =
        await SessionManageerUserSide(); // Initialize session manager

    dynamic address = await sessionManager.getAddress();
    return address;
  }

  bool loader = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      loader = true;
    });
    Future.microtask(() => apiServiceUserSide.getHomeFirstBanner());
    Future.microtask(() => apiServiceUserSide.getHomeFooterBanner());
    Future.microtask(() => apiServiceUserSide.getCategoryList());
    Future.microtask(() => apiServiceUserSide.getOfferList());
    Future.microtask(() => _getCurrentLocation()).whenComplete(() {
      _getCurrentLocation();
      setState(() {
        loader = false;
      });
    });

    _focusNode.addListener(_onFocusChange);
    _startAutoTyping();
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _timertravelDis?.cancel();
    _scrollController.dispose();
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

  List title = [
    "Hire Anything, Anytime",
    "Hire Anything & Save 20%",
    "20% Discount on All Hires"
  ];
  List des = [
    "Hire professionals or tools easily, with flexible options and reliable service",
    "Enjoy 20% off all hires—services or equipment, save now!",
    "Get 20% off all hires—services and equipment, limited time!"
  ];

  ScrollController _scrollController = ScrollController();
  Timer? _timertravelDis;
  double _scrollPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final UserBasicGetxController userBasicGetxController =
        Get.put(UserBasicGetxController());

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            toolbarHeight: 80,
            title: InkWell(
              onTap: () async {
                final sessionManager =
                    await SessionManageerUserSide(); // Initialize session manager
                var lat = await sessionManager.getLatitude();
                var long = await sessionManager.getLongitude();
                var getpincode = await sessionManager.getPincode();
                var addredss = await sessionManager.getAddress();
                var getstreet = await sessionManager.getStreet();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Address(
                      lat: lat,
                      long: long,
                      addredss: addredss,
                      pincode: getpincode,
                      street: getstreet,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: kPrimaryColor,
                      ),
                      FutureBuilder(
                        future: getAddress(),
                        builder: (ctx, snapshot) {
                          // Displaying LoadingSpinner to indicate waiting state
                          return Flexible(
                            child: Text(
                              "${snapshot.data ?? ""}",
                              maxLines: 2,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal),
                            ),
                          );
                        },

                        // Future that needs to be resolved
                        // inorder to display something on the Canvas
                      ),
                      const Icon(Icons.keyboard_arrow_down_outlined,
                          color: Colors.black, size: 20),
                    ],
                  )
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => NotificationList(),
                    ),
                  );
                },
                icon: SvgPicture.asset(
                  'assets/icons/solar_bell-bold.svg',
                  semanticsLabel: 'My SVG Image',
                  color: Colors.grey,
                  height: h / 35,
                ),
              )
            ],
          ),
          body: (loader == true)
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.blue,
                ))
              : LoaderOverlay(
                  useDefaultLoading: false,
                  overlayWidgetBuilder: (_) {
                    //ignored progress for the moment
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => Search(),
                                  ),
                                );
                              },
                              child: SizedBox(
                                  height: h / 15,
                                  width: w / 1.1,
                                  child: TextFormField(
                                      controller: TextEditingController(
                                          text: _typedText),
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
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const Search(),
                                          ),
                                        );
                                      },
                                      enabled: false,
                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.search,
                                              color: Colors.grey),
                                          hintText: "",
                                          hintStyle: TextStyle(fontSize: 14),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey)),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey))))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: h / 50,
                        ),
                        Container(
                          height: h / 4,
                          width: w / 1,
                          //padding: EdgeInsets.all(4),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 3)
                            ],
                          ),
                          child: (userBasicGetxController
                                  .getHomebannerFirstList!.bannerList.isEmpty)
                              ? Container(
                                  width: w / 1,
                                  decoration: BoxDecoration(
                                    //  color: color,
                                    borderRadius: BorderRadius.circular(10),
                                    // boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                                  ),
                                  // padd
                                )
                              : CarouselSlider.builder(
                                  itemCount: userBasicGetxController
                                      .getHomebannerFirstList
                                      ?.bannerList
                                      .length,
                                  itemBuilder:
                                      (context, indexHomeBanner, realIndex) {
                                    print(
                                        "userBasicGetxController.getHomebannerFirstList?.bannerList.length=>${userBasicGetxController.getHomebannerFirstList?.bannerList.length}");
                                    // String imageurl = image[ImageIndex];
                                    print("realIndex=>${realIndex}");
                                    print("index=>${indexHomeBanner}");

                                    return Container(
                                      width: w / 1,
                                      decoration: BoxDecoration(
                                        //  color: color,
                                        borderRadius: BorderRadius.circular(10),
                                        // boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                                      ),
                                      // padding: EdgeInsets.only(left: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          appUrlsUserSide.baseUrlImages +
                                              userBasicGetxController
                                                  .getHomebannerFirstList!
                                                  .bannerList[indexHomeBanner]
                                                  .bannerImage
                                                  .toString(),
                                          width: 130,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    height: 300,
                                    autoPlay: true,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: true,
                                    aspectRatio: isPortrait ? 1.40 : 2.0,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentPage1 = index;
                                      });
                                    },
                                  ),
                                ),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        CustomPageIndicator(
                          currentPage: _currentPage1,
                          itemCount: 3, // Replace 3 with your actual item count
                          dotColor: Colors.grey, // Customize dot color
                          activeDotColor:
                              kPrimaryColor, // Customize active dot color
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Align(
                        //   alignment: Alignment.topLeft,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
                        //     child: Text(
                        //       "Travel more, spend less",
                        //       style:
                        //       TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        //     ),
                        //   ),
                        // ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title Section
                            const Text(
                              "Travel more, spend less",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Row of Info Cards
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                        userBasicGetxController.getoffersList!
                                            .bannerList.length, (index) {
                                      return travelDisCard(
                                          userBasicGetxController.getoffersList!
                                              .bannerList[index].title,
                                          userBasicGetxController.getoffersList!
                                              .bannerList[index].description);
                                    })),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Top Category",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllCategoryScreen()));
                              },
                              child: Text(
                                "View more",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF295AB3),
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          height: h * .02,
                        ),

                        //------------------ Top Categories GridView----------------

                        Container(
                          child: GridView.builder(
                            // padding: EdgeInsets.only(bottom: 5),
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: (userBasicGetxController
                                        .getCategoryListList!
                                        .bannerList
                                        .length >
                                    9)
                                ? 9
                                : userBasicGetxController
                                    .getCategoryListList?.bannerList.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 1.75 / 2),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  context.loaderOverlay.show();
                                  userBasicGetxController
                                      .clearCategoryBannerList();
                                  userBasicGetxController
                                      .clearSubCategoryBannerList();
                                  Map<String, dynamic>? data = {
                                    "categoryId": userBasicGetxController
                                        .getCategoryListList!
                                        .bannerList[index]
                                        .categoryId
                                  };
                                  Future.microtask(() => apiServiceUserSide
                                      .getSubcategoryBannerList(data));
                                  Future.microtask(() => apiServiceUserSide
                                          .getSubcategoryList(data)
                                          .whenComplete(() {
                                        context.loaderOverlay.hide();
                                        Get.to(SubCategoriesScreen(
                                            cat_name: topCategory[index]
                                                ["name"]));
                                      }));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        // Shadow color
                                        spreadRadius: 1,
                                        // How much the shadow spreads
                                        blurRadius: 1,
                                        // How blurred the shadow is
                                        offset: Offset(0, 1), // Shadow offset
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 90,
                                          width: 110,
                                          margin: EdgeInsets.all(3),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(
                                              "${appUrlsUserSide.baseUrlImages}${userBasicGetxController.getCategoryListList!.bannerList[index].categoryImage}",
                                              fit: BoxFit.fill,
                                              errorBuilder: (BuildContext,
                                                  Object, StackTrace) {
                                                return Text('');
                                              },
                                            ),
                                          )),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        // topCategory[index]["name"].toString(),
                                        userBasicGetxController
                                            .getCategoryListList!
                                            .bannerList[index]
                                            .categoryName
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        //======New And Noteworthy Container=======//

                        Container(
                          height: 10,
                          color: Colors.grey.shade100,
                        ),
                        Container(
                            width:
                                MediaQuery.of(context).size.width * 100 / 100,
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              elevation: 3,
                              shadowColor: Colors.white,
                              child: Container(
                                height: h / 4,
                                width: w / 1.1,
                                decoration: BoxDecoration(
                                  color: Color(0xffE6F4EF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          right: 0,
                                          bottom: 60,
                                          top: 10,
                                          child: Image.asset(
                                            "assets/images/Ellipse 4.png",
                                          )),
                                      Positioned(
                                        right: -20,
                                        bottom: 0,
                                        top: 0,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(50)),
                                          child: Image.asset(
                                            "assets/images/call.png",
                                            height: h / 1.4,
                                            width: w / 1.4,
                                            fit: BoxFit
                                                .contain, // Ensure the image covers the entire area
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          SizedBox(
                                            width: w / 1.5,
                                            child: const Text(
                                              "Call Or Chat With our Expert",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight
                                                      .w600), // Adjusted font size
                                            ),
                                          ),
                                          SizedBox(height: h / 100),
                                          SizedBox(
                                            width: w / 1.9,
                                            child: const Text(
                                              "Need Help? Talk to our Experts! ",
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(0xff7A8980),
                                              ), // Adjusted font size
                                            ),
                                          ),
                                          SizedBox(height: h / 40),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             Categories_Screen(gender:"female")));
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EnquiryFormActivity()));
                                                },
                                                child: Container(
                                                  height: h / 20,
                                                  width: w / 3.7,
                                                  decoration: BoxDecoration(
                                                    color: kPrimaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: [
                                                      // BoxShadow(
                                                      //   color: kTextColor2.withOpacity(0.5),
                                                      //   blurRadius: 10,
                                                      //   spreadRadius: 2,
                                                      //   offset: Offset(0, 4),
                                                      // ),
                                                    ], // Adjusted borderRadius
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Icon(Icons.call,
                                                          color: Colors.white,
                                                          size: h /
                                                              40), // Adjusted icon size
                                                      const Text(
                                                        "Enquiry now",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 12,
                                                          // Adjusted font size
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: w / 40),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),

                        // Container(
                        //   height: 140,
                        //   width: w / 1,
                        //   padding: EdgeInsets.all(1),
                        //   decoration: BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius: BorderRadius.circular(20),
                        //       boxShadow: [
                        //         BoxShadow(color: Colors.grey, blurRadius: 3)
                        //       ]),
                        //   child:
                        SizedBox(
                            height: 140,
                            width: w / 1,
                            child: (userBasicGetxController
                                    .getHomeFooterbannerFirstList!
                                    .bannerList
                                    .isEmpty)
                                ? Container(
                                    width: w / 1,
                                    decoration: BoxDecoration(
                                      //  color: color,
                                      borderRadius: BorderRadius.circular(10),
                                      // boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3)],
                                    ),
                                    // padd
                                  )
                                : CarouselSlider.builder(
                                    itemCount: userBasicGetxController
                                        .getHomeFooterbannerFirstList
                                        ?.bannerList
                                        .length,
                                    itemBuilder:
                                        (context, indexHomeFooter, realIndex) {
                                      List<String> image = [
                                        "assets/new/Boat.jpeg",
                                        "assets/new/ChauffeurDrivenPrestige .jpg",
                                        "assets/new/Horse and Carriage.jpeg",
                                      ];
                                      int Imageindex =
                                          indexHomeFooter % image.length;
                                      String Imageurl = image[Imageindex];

                                      return Container(
                                        // height:80,
                                        // width: 200,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  appUrlsUserSide
                                                          .baseUrlImages +
                                                      userBasicGetxController
                                                          .getHomeFooterbannerFirstList!
                                                          .bannerList[
                                                              indexHomeFooter]
                                                          .bannerImage
                                                          .toString(),
                                                ),
                                                fit: BoxFit.fill),
                                            color: kPrimaryColor,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 3)
                                            ]),
                                      );
                                    },
                                    options: CarouselOptions(
                                      viewportFraction: 1.0,
                                      height: 300,
                                      autoPlay: true,
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                      enlargeCenterPage: true,
                                      aspectRatio: isPortrait ? 1.40 : 2.0,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentPage1 = index;
                                        });
                                      },
                                    ),
                                  )),
                        // ),
                        // ),

                        const SizedBox(
                          height: 20,
                        ),

                        // LoyaltyCardScreen()
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _showDialogs(BuildContext context) {
    final selectedValue = 'Info'.obs;

    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          title: Text(
            "Upload Health Records",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please upload of valid Health Records from your doctor",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Image.asset("assets/images/uploadsf.png")),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                "Manish_Blood_Test_20241...",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11,
                                    color: kindicatorColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Myself',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      width: w / 1.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Myself',
                              style: TextStyle(
                                  color: Color(0xff2B2B2B),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Obx(() => DropdownButton<String>(
                                    value: selectedValue.value,
                                    onChanged: (newValue) {
                                      selectedValue.value = newValue!;
                                    },
                                    items: <String>['Info', 'Warning', 'Error']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Type of record',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    )),
                SizedBox(height: 15),
                Container(
                  height: 50,
                  width: w / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Report',
                          style: TextStyle(
                              color: Color(0xff2B2B2B),
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => DropdownButton<String>(
                                value: selectedValue.value,
                                onChanged: (newValue) {
                                  selectedValue.value = newValue!;
                                },
                                items: <String>['Info', 'Warning', 'Error']
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            SizedBox(height: 15),
            Container(
              height: 50,
              width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: kPrimaryColor,
              ),
              child: InkWell(
                onTap: () {},
                child: Center(
                    child: Text(
                  'Save',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                )),
              ),
            ),
          ],
        );
      },
    );
  }

  callNumber() async {
    const number = '+911234567890';
    // bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  Widget _buildCard(String title, String description, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  travelDisCard(title, des) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          height: 120,
          child: Card(
            color: Colors.blue,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "Genius",
                    "$title",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    // "Chauhan, you're at Genius Level 1 in our loyalty programme",
                    "$des",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
      ],
    );
  }

  String _locationMessage = "";

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = "Location services are disabled.";
      });
      return;
    }

    // Check location permission

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        setState(() {
          _locationMessage = "Location permissions are denied.";
        });
        return;
      }
    }

    // Get current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get address from coordinates
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // Extract address details
    Placemark place = placemarks[0];
    String fullAddress =
        "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";

    setState(() {
      _locationMessage =
          "Latitude: ${position.latitude}, Longitude: ${position.longitude}\nAddress: $fullAddress";
    });
    print("place=>${place}");

    Map<String, dynamic>? data = {
      "street": "${place.street}",
      'address':
          "${place.street} ${place.subLocality} ${place.administrativeArea.toString()} ${place.postalCode.toString()} ${place.country.toString()}",
      'pincode': place.postalCode.toString(),
      "state": place.administrativeArea.toString(),
      "city_name": place.locality.toString(),
      "latitude": position.latitude.toString(),
      "longitude": position.longitude.toString(),
      'type': "",
    };

    Future.microtask(() => apiServiceUserSide.addUserAddress(data))
        .whenComplete(() {
      setState(() {});
    });

    // await _getAreaName(position.latitude, position.longitude);
    return;
  }
}
