import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/views/Home.dart';

import '../navigation_bar.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
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
    child:
      Scaffold(backgroundColor: kwhiteColor,
      appBar: AppBar(toolbarHeight: 60,
        centerTitle: true,
         backgroundColor: Colors.white,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        title: Text(
          "Category",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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
            child: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: Container(color: Colors.grey.shade100,
        padding: EdgeInsets.only(left: 10,right:10),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15,),

            ListView.builder(
              itemCount: 3 ~/ 3, // Dividing by 2 to display two containers in one row
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                List<String> images = [
                  "assets/images/electAvtar.jpg",
                  "assets/images/electAvtar2.jpg",
                  "assets/images/electAvtar.jpg",
                  "assets/images/electAvtar2.jpg",
                ];
                List<String> names = [
                  "Cleaning",
                  "Roofing",
                  "Electrician",
                  "Fitter",
                  "cleaning",
                  "plumbing",
                  "House Repair",
                  "Painting",
                  "Plumber"

                ];


                int startIndex =
                    index * 3; // Calculate the starting index of each row
                String imageUrl1 = images[startIndex % images.length];
                String name1 = names[startIndex % names.length];

                String imageUrl2 = images[(startIndex + 1) % images.length];
                String name2 = names[(startIndex + 1) % names.length];

                String name3 = names[(startIndex + 2)% names.length];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            height: h / 6.5,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter)),
                            child: Center(
                                child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 25,

                                      child: Image.asset(
                                        "assets/icons/roof.png",height: 40,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      name2,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500, fontSize: 14),
                                    ),
                                  ],
                                )),
                          ),


                        ],
                      ),
                    ),
                    SizedBox(width: w/60,),

                    Column(
                      children: [
                        Container(
                          height: h / 6.5,
                          width: w / 3.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                          child: Center(
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,

                                    child: Image.asset(
                                      "assets/icons/electrician.png",height: 30,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    name3,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14),
                                  ),
                                ],
                              )),
                        ),

                      ],
                    ),
                    SizedBox(width: w/60,),
                    Column(
                      children: [
                        Container(
                          height: h / 6.5,
                          width: w / 3.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter)),
                          child: Center(
                              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,

                                    child: Image.asset(
                                      "assets/icons/clean.png",height: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    name1,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500, fontSize: 14),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text("Popular Handryman",style: TextStyle(
              color: kblackTextColor,fontWeight: FontWeight.bold,fontSize: 15
            ),),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              itemCount: 3 ~/ 3, // Dividing by 2 to display two containers in one row
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                List<String> images = [
                  "assets/images/electAvtar.jpg",
                  "assets/images/electAvtar2.jpg",
                  "assets/images/electAvtar.jpg",
                  "assets/images/electAvtar2.jpg",
                ];
                List<String> names = [

                  "john Smith",
                  "Johan Smith",
                  "Alice"

                ];
                List<String> price = [

                  "\u{20B9}500",
                  "\u{20B9}600",
                  "\u{20B9}700"

                ];


                int startIndex =
                    index * 3; // Calculate the starting index of each row
                String imageUrl1 = images[startIndex % images.length];
                String name1 = names[startIndex % names.length];

                String imageUrl2 = images[(startIndex + 1) % images.length];
                String name2 = names[(startIndex + 1) % names.length];

                String name3 = names[(startIndex + 2)% names.length];
                String price1=price[startIndex % price.length];
                String price2= price[startIndex + 1  % price.length];
                String price3 = price[startIndex + 2 % price.length];

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      child: Column(
                        children: [
                          Stack(
                            children:[

                              Container(
                              height: h / 5,
                              width: w / 3.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [
                                        Colors.white,
                                        Colors.white
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter)),
                              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [

                                      Row(
                                        children: [SizedBox(width: 8,),
                                          Icon(Icons.favorite_border,size: 15,color: Colors.grey.shade600,),
                                        ],
                                      ),
                                      Row(
                                        children: [

                                          Text("4.9",style: TextStyle(
                                            color: Colors.grey.shade600
                                          ),),
                                          Icon(Icons.star,color: Colors.yellow,size: 15,),
                                          SizedBox(width: 5,)
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Container(
                                    height: MediaQuery.of(context).size.height*14/100,


                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                      color: kPrimaryColor
                                    ),

                                  ),



                                  // Text(
                                  //   name2,
                                  //   style: TextStyle(
                                  //       fontWeight: FontWeight.w500, fontSize: 14),
                                  // ),
                                ],
                              ),
                            ),
                              Positioned(top: 25,left: 20,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(imageUrl2),


                                ),
                              ),
                              Positioned(top: 100,left: 15,
                                child: Container(
                                  height: 50,
                                  width: 75,
                                  child: Column(
                                    children: [
                                      Text(name1,style: TextStyle(color: kwhiteColor,fontWeight: FontWeight.bold),),
                                      Text(price1,style: TextStyle(color: kwhiteColor,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              )
                          ]),


                        ],
                      ),
                    ),
                    SizedBox(width: w/60,),

                    Column(
                      children: [
                        Stack(
                            children:[

                              Container(
                                height: h / 5,
                                width: w / 3.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.white
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter)),
                                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5,),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Row(
                                          children: [SizedBox(width: 8,),
                                            Icon(Icons.favorite_border,size: 15,color: Colors.grey.shade600,),
                                          ],
                                        ),
                                        Row(
                                          children: [

                                            Text("4.9",style: TextStyle(
                                                color: Colors.grey.shade600
                                            ),),
                                            Icon(Icons.star,color: Colors.yellow,size: 15,),
                                            SizedBox(width: 5,)
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),

                                    Container(
                                      height: MediaQuery.of(context).size.height*14/100,


                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                          color: kPrimaryColor
                                      ),

                                    ),



                                    // Text(
                                    //   name2,
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w500, fontSize: 14),
                                    // ),
                                  ],
                                ),
                              ),
                              Positioned(top: 25,left: 20,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(imageUrl1),


                                ),
                              ),
                              Positioned(top: 100,left: 15,
                                child: Container(
                                  height: 50,
                                  width: 75,
                                  child: Column(
                                    children: [
                                      Text(name3,style: TextStyle(color: kwhiteColor,fontWeight: FontWeight.bold),),
                                      Text(price3,style: TextStyle(color: kwhiteColor,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              )
                            ]),


                      ],
                    ),
                    SizedBox(width: w/60,),
                    Column(
                      children: [
                        Stack(
                            children:[

                              Container(
                                height: h / 5,
                                width: w / 3.5,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                        colors: [
                                          Colors.white,
                                          Colors.white
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter)),
                                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5,),
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [

                                        Row(
                                          children: [SizedBox(width: 8,),
                                            Icon(Icons.favorite_border,size: 15,color: Colors.grey.shade600,),
                                          ],
                                        ),
                                        Row(
                                          children: [

                                            Text("4.9",style: TextStyle(
                                                color: Colors.grey.shade600
                                            ),),
                                            Icon(Icons.star,color: Colors.yellow,size: 15,),
                                            SizedBox(width: 5,)
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),

                                    Container(
                                      height: MediaQuery.of(context).size.height*14/100,


                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                          color: kPrimaryColor
                                      ),

                                    ),



                                    // Text(
                                    //   name2,
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w500, fontSize: 14),
                                    // ),
                                  ],
                                ),
                              ),
                              Positioned(top: 25,left: 20,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage(imageUrl1),


                                ),
                              ),
                              Positioned(top: 100,left: 10,
                                child: Container(
                                  height: 50,
                                  width: 85,
                                  child: Column(
                                    children: [
                                      Text(name2,style: TextStyle(color: kwhiteColor,fontWeight: FontWeight.bold),),
                                      Text(price2,style: TextStyle(color: kwhiteColor,fontWeight: FontWeight.bold),)
                                    ],
                                  ),
                                ),
                              )
                            ]),


                      ],
                    ),
                  ],
                );
              },
            ),

          ],
        ),
      ),
    )));
  }
}
