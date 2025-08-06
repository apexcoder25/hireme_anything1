import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/add_service_screen_1.dart';
import 'package:hire_any_thing/Vendor_App/api_service/api_service_vender_side.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/vender_side_getx_controller.dart';

import '../../../data/session_manage/session_vendor_side_manager.dart';
import '../../../utilities/constant.dart';
import '../../uiltis/color.dart';
import '../edit_service/edit_service_screen.dart';

class ServicesListScreen extends StatefulWidget {
  const ServicesListScreen({super.key});

  @override
  State<ServicesListScreen> createState() => _ServicesListScreenState();
}

class _ServicesListScreenState extends State<ServicesListScreen> {

  final ApiServiceVenderSide apiServiceVenderSide = ApiServiceVenderSide();

  @override
  void initState() {
    super.initState();
    apiServiceVenderSide.vendorServiceList(); 
  }

  @override
  void dispose() {
    apiServiceVenderSide.dispose(); 
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    final VenderSidetGetXController venderSidetGetXController = Get.put(VenderSidetGetXController());

    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        foregroundColor: colors.white,
        backgroundColor: colors.button_color,
        automaticallyImplyLeading: false,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Service'),
            InkWell(
              onTap: () async {

                final sessionManager = await SessionVendorSideManager();

                dynamic categoryId=await sessionManager.getcategoryId();

                Future.microtask(() => apiServiceVenderSide.subcategoryList(categoryId)).whenComplete(() {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddServiceScreenFirst()));
                });

              },
              child: Container(
                alignment: Alignment.center,
                // height: MediaQuery.of(context).size.height * 4 / 100,
                // width: MediaQuery.of(context).size.width * 40 / 100,
                height: 30,
                // width:82 ,
                padding: EdgeInsets.only(left:5.0 ,right: 5.0),
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
                  "Add Service",
                  style: TextStyle(

                      color: Colors.black,
                      fontSize: 16
                    // fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),),
      body:
      StreamBuilder<dynamic>(
        stream: apiServiceVenderSide.serviceListStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: venderSidetGetXController.getServiceList!.vendorServiceList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Stack(
                      children: [
                        Container(
                          height:140,
                          width: w,
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 3)
                              ]),
                          child: Padding(
                            padding:
                            const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              children: [

                                Container(
                                  padding: EdgeInsets.all(8), // Border width
                                  // decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(48), // Image radius
                                      child: Image.network('${appUrlsVendorSide.baseUrlImages}${venderSidetGetXController.getServiceList?.vendorServiceList![index].serviceImage?[0]}',fit: BoxFit.cover,
                                        errorBuilder: (BuildContext, Object, StackTrace){
                                          return Text("");
                                        },
                                      ),
                                    ),
                                  ),
                                ),



                                SizedBox(
                                  width: w / 45,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    SizedBox(
                                      width: w / 2,
                                      child: Text(
                                        'Category : ${venderSidetGetXController.getServiceList?.vendorServiceList![index].serviceName ?? ""}',
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        style: TextStyle(
                                            color:
                                            kPrimaryColor,
                                            fontSize: 14,
                                            fontWeight:
                                            FontWeight
                                                .w800),
                                      ),
                                    ),
                                    SizedBox(
                                      width: w / 2,
                                      child: Text(
                                        "Service : ${venderSidetGetXController.getServiceList?.vendorServiceList![index].serviceName}",
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            color:
                                            klightblackTextColor,
                                            fontSize: 10,
                                            fontWeight:
                                            FontWeight
                                                .w800),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h / 160,
                                    ),
                                    Text(
                                        "Vehicle : ABC22BT"),

                                    SizedBox(
                                      height: h / 160,
                                    ),

                                    //  Todo

                                    Text(
                                      "\$ ${venderSidetGetXController.getServiceList?.vendorServiceList![index].finalPrice}",
                                      style: TextStyle(
                                          color: colors.button_color,
                                          fontSize: 14,
                                          fontWeight:
                                          FontWeight
                                              .w800),),
                                    SizedBox(
                                      height: h / 160,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Icon(
                                          Icons
                                              .calendar_month_rounded,
                                          size: 15,
                                          color:
                                          kPrimaryColor,
                                        ),
                                        Text(
                                          // Todo
                                          "01-10-2024",
                                          style: TextStyle(
                                              color:
                                              klightblackTextColor,
                                              fontSize: 10),
                                        ),
                                        SizedBox(
                                          width: w / 10,
                                        ),
                                        Icon(
                                          Icons.timer,
                                          color:
                                          kPrimaryColor,
                                          size: 15,
                                        ),
                                        Text(
                                          "03:08 PM",
                                          style: TextStyle(
                                              fontSize: 10,
                                              color:
                                              klightblackTextColor),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: h / 160,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                        Positioned(
                            top: 5,
                            right: 8,
                            child: InkWell(
                                onTap: () async {
                                  // Todo
                                  Future.microtask(() => venderSidetGetXController!.setinitalSubCategoryvalue(venderSidetGetXController.getServiceList?.vendorServiceList![index].subcategoryId));
                                  Future.microtask(() =>venderSidetGetXController.setVendorServiceSingleDetail(venderSidetGetXController.getServiceList?.vendorServiceList![index])).whenComplete(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => EditServiceScreenFirst()),
                                    );
                                  });


                                  // Future.microtask(() => apiServiceVenderSide.subcategoryList(categoryId)).whenComplete(() {
                                  //   Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(builder: (context) => EditServiceScreenFirst()),
                                  //   );
                                  // });



                                },
                                child: Icon(Icons.edit,color: Colors.redAccent,size: 30,)))
                      ],
                    ),
                  );
                }
            );
          }
          if (snapshot.connectionState !=ConnectionState.waiting && !snapshot.hasData){

            return Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'No Service Added',
                    overflow:
                    TextOverflow
                        .ellipsis,
                    textAlign:TextAlign.center ,
                    style: TextStyle(
                        color:
                        kPrimaryColor,
                        fontSize: 18,
                        fontWeight:
                        FontWeight
                            .w800),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    // alignment: Alignment.center,
                    child: Text(
                      "You haven't added any services yet. Please add your services to start receiving bookings and reach more customers.",
                      overflow:
                      TextOverflow
                          .ellipsis,
                      textAlign:TextAlign.center ,
                      maxLines: 5,
                      style: TextStyle(
                          color:Colors.grey[500],
                          fontSize: 14,
                          fontWeight:
                          FontWeight
                              .w800),
                    ),
                  ),
                ],
              ),
            ) ;
          }
          return Text("");

        }
      ),

    );
  }
}
