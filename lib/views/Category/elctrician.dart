import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/AppConstant.dart';
import 'package:hire_any_thing/views/subCategoryPage/electricianDetail.dart';
import 'package:hire_any_thing/views/subCategoryPage/electrician_subcategori.dart';

import '../../navigation_bar.dart';
import '../../utilities/constant.dart';

class Electrician_Screen extends StatefulWidget {
  const Electrician_Screen({super.key});

  @override
  State<Electrician_Screen> createState() => _Electrician_ScreenState();
}

class _Electrician_ScreenState extends State<Electrician_Screen> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,

        title: Text(
          "Service",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
      body: Container(padding: EdgeInsets.all(5),
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 100 / 100,
        width: MediaQuery.of(context).size.width * 100 / 100,
        child: SingleChildScrollView(
          child: Column(
            children: [



              SingleChildScrollView(
                child: Container(padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),
                    ),
                    border: Border.all(color: Colors.grey.shade50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white
                      )
                    ]
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*3/100,),

                      Text("Electrician, Plumber & Carpenter",style: AppConstant.Electrcian,),
                      SizedBox(height: MediaQuery.of(context).size.height*5/100,),
                      Text("Home repairs",style: AppConstant.HomeRepairs,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Column(
                              children: [
                                Container(
                                  height: h / 8.5,
                                  width: w / 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ElectricianSubcategory()));
                                        },
                                        child: Container(
                                            height: h / 13,
                                            width: w / 6,
                                            child: Image.asset(
                                              "assets/icons/wiring.png",
                                            )),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Electricians",
                                  style:AppConstant.subcategoritext_elctrician)
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),

                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ElectricianSubcategory()));
                                },
                                child: Container(
                                  height: h / 8.5,
                                  width: w / 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: Container(
                                          height: h / 13,
                                          width: w / 6,
                                          child: Image.asset(
                                            "assets/icons/stabilizator.png",
                                          ))),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Plumber",
                                style: AppConstant.subcategoritext_elctrician,
                              ),
                            ],
                          ),
                          SizedBox(width: 10,),

                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ElectricianSubcategory()));
                                },
                                child: Container(
                                  height: h / 8.5,
                                  width: w / 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: Container(
                                          height: h / 13,
                                          width: w / 6,
                                          child: Image.asset(
                                            "assets/icons/switch.png",
                                          ))),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Carpenter",
                                style: AppConstant.subcategoritext_elctrician,
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*5/100,),
                      
                      Text("Home installation",style: AppConstant.HomeRepairs,),

                      SizedBox(height: MediaQuery.of(context).size.height*2/100,),

                      Column(
                        children: [
                          Container(
                            height: h / 8.5,
                            width: w / 4,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ElectricianSubcategory()));
                                  },
                                  child: Container(
                                      height: h / 13,
                                      width: w / 6,
                                      child: Image.asset(
                                        "assets/icons/wiring.png",
                                      )),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Furnitire\nAssembly",
                              style:AppConstant.subcategoritext_elctrician)
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height*5/100,),

                      Text("Buy Product",style: AppConstant.HomeRepairs,),

                      SizedBox(height: MediaQuery.of(context).size.height*1/100,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Column(mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: h / 8.5,
                                  width: w / 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ElectricianSubcategory()));
                                        },
                                        child: Container(
                                            height: h / 13,
                                            width: w / 6,
                                            child: Image.asset(
                                              "assets/icons/wiring.png",
                                            )),
                                      )),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(height: 60,width: 60,
                                  child: Text(
                                      "Native\nWater\nPurifier",
                                      style:AppConstant.subcategoritext_elctrician),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),

                          Column(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ElectricianSubcategory()));
                                },
                                child: Container(
                                  height: h / 8.5,
                                  width: w / 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                      child: Container(
                                          height: h / 13,
                                          width: w / 6,
                                          child: Image.asset(
                                            "assets/icons/stabilizator.png",
                                          ))),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(height: 60,width: 80,
                                child: Text(textAlign:TextAlign.center,
                                  "Native\nSmart locks",
                                  style: AppConstant.subcategoritext_elctrician,
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),



                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
