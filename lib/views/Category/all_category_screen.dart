import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/api_service/api_service_user_side.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../Vendor_App/uiltis/color.dart';
import '../../data/getx_controller/user_side/user_basic_getx_controller.dart';
import '../../utilities/constant.dart';
import 'sub_categories_screen.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final UserBasicGetxController userBasicGetxController =
        Get.put(UserBasicGetxController());

    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: colors.white,
        backgroundColor: colors.button_color,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Service'),
          ],
        ),
      ),
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayWidgetBuilder: (_) {
          //ignored progress for the moment
          return Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: GridView.builder(
            // padding: EdgeInsets.only(bottom: 5),
            // physics: NeverScrollableScrollPhysics(),
            itemCount:
                userBasicGetxController.getCategoryListList!.bannerList.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.75 / 2),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  context.loaderOverlay.show();
                  userBasicGetxController.clearCategoryBannerList();
                  userBasicGetxController.clearSubCategoryBannerList();
                  Map<String, dynamic>? data = {
                    "categoryId": userBasicGetxController
                        .getCategoryListList!.bannerList[index].categoryId
                  };
                  Future.microtask(
                      () => apiServiceUserSide.getSubcategoryBannerList(data));
                  Future.microtask(() => apiServiceUserSide
                          .getSubcategoryList(data)
                          .whenComplete(() {
                        context.loaderOverlay.hide();
                        Get.to(SubCategoriesScreen(cat_name: ""));
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height: 90,
                          width: 110,
                          margin: EdgeInsets.all(3),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              "${appUrlsUserSide.baseUrlImages}${userBasicGetxController.getCategoryListList!.bannerList[index].categoryImage}",
                              fit: BoxFit.fill,
                            ),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        userBasicGetxController
                            .getCategoryListList!.bannerList[index].categoryName
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
      ),
    );
  }
}
