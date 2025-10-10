import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_basic_getx_controller.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/User_app/views/subCategoryPage/service_list.dart';

import '../../../navigation_bar.dart';

class SubCategoriesScreen extends StatefulWidget {
  final cat_name;

  const SubCategoriesScreen({super.key, this.cat_name});

  @override
  State<SubCategoriesScreen> createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  List<String> imagesMen = [
    "assets/men/clean shave.jpeg",
    "assets/men/Face & Neck Detan.jpeg",
    "assets/men/Facial & Cleanup.jpeg",
    "assets/men/Foot + Calf Massage.jpeg",
    "assets/men/Grooming essentials.jpeg",
    "assets/men/Hair-Color.jpg",
    "assets/men/Hand Detan Pack.jpeg",
    "assets/men/head massage.jpeg",
    "assets/men/massage.jpeg",
    "assets/men/Pedicure.jpeg",
  ];
  List<String> imagesMenName = [
    "Clean shave",
    "Face & Neck detan",
    "Facial & Cleanup",
    "Foot + Calf Massage",
    "Grooming essentials",
    "Hair-Color",
    "Hand Detan Pack",
    "Head massage",
    "Massage",
    "Pedicure"
  ];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    print("widget.gender=>${widget.cat_name}");

    final UserBasicGetxController userBasicGetxController = Get.put(UserBasicGetxController());

    print("userBasicGetxController.categoryBannerList=>${userBasicGetxController.categoryBannerList.length}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,

        title: Text(
          userBasicGetxController.categoryName.toString()?? "Back",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Navi(),
                ),
              );
            },
            child: const Icon(Icons.arrow_back_ios_new_sharp)),),
        
      body:Container(
        // color: Color(0xFFf5f5f3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  ( userBasicGetxController.categoryBannerList.isEmpty)?SizedBox():Container(
                    width: w,
                    height: h * 0.24,
                    margin: EdgeInsets.all(10),
                    child: CarouselSlider.builder(
                        itemCount: userBasicGetxController.categoryBannerList.length,
                        itemBuilder: (context, indexCategorybanner, realIndex) {
                          print("indexCategorybanner=>${indexCategorybanner}_realIndex=${realIndex}");
                          return Material(
                            color: Color(0xFFf5f5f3),
                            borderRadius: BorderRadius.circular(20),
                            elevation: 3,
                            shadowColor: Colors.white,
                            child: Container(
                              height: h / 4,
                              width: w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "${appUrlsUserSide.baseUrlImages}${userBasicGetxController.categoryBannerList[indexCategorybanner].categoryBannerImage}",
                                    ),
                                    fit: BoxFit.fill),
                                color: Color(0xffE6F4EF),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          viewportFraction: 1.0,
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 1.0,
                          onPageChanged: (index, reason) {
                            setState(() {
                              var _currentPage = index;
                            });
                          },
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  (userBasicGetxController.getSubcategoryList!.subcategoryList.isEmpty)?
                  Container(
                    margin: EdgeInsets.only(top: h * 0.2),
                    child:
                  Center(child: Column(
                    children: [
                      Image.asset("assets/icons/empty-box.png",height:100 ,width: 100,fit: BoxFit.fill,),
                    SizedBox(
                      height: 20,
                    ),
                      Text(
                      'No sub-categories available at the moment.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    ],
                  )),)
                      : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      // margin: EdgeInsets.only(left: 8, right: 8),
                      child: GridView.builder(
                        // padding: EdgeInsets.only(bottom: 5),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: userBasicGetxController.getSubcategoryList?.subcategoryList.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 1.75 / 2),
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Map<String,dynamic>? requestedData={
                                "subcategoryId":"${userBasicGetxController.getSubcategoryList?.subcategoryList![index].subcategoryId}"
                              };
                              userBasicGetxController.clearServiceList();
                              Future.microtask(() => apiServiceUserSide.vendorServiceList(requestedData)).whenComplete((){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceListScreen(
                                              cat_name: widget.cat_name,
                                            )));
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: kwhiteColor,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      height: 90,
                                      width: 110,
                                      margin: EdgeInsets.all(3),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                          "${appUrlsUserSide.baseUrlImages}${userBasicGetxController.getSubcategoryList?.subcategoryList[index].subcategoryImage}",
                                          fit: BoxFit.fill,
                                          errorBuilder: (BuildContext, Object, StackTrace){
                                            return Text("");
                                          },
                                        ),
                                      )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${userBasicGetxController.getSubcategoryList?.subcategoryList[index].subcategoryName}",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
