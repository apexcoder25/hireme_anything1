/*
import 'package:hire_any_thing/views/subCategoryPage/service_list.dart';
import 'package:flutter/material.dart';

import '../../navigation_bar.dart';
class Cleaning_Screen extends StatefulWidget {
  const Cleaning_Screen({super.key});

  @override
  State<Cleaning_Screen> createState() => _Cleaning_ScreenState();
}

class _Cleaning_ScreenState extends State<Cleaning_Screen> {
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
          "Cleaning",
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
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height * 100 / 100,
        width: MediaQuery.of(context).size.width * 100 / 100,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
              ),
              Container(height: 1,
              color: Colors.grey.shade400,),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
              ),

              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Column(
                        children: [
                          Container(
                            height: h / 7,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                                ]),
                            child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoriesListController()));
                                  },
                                  child: Container(
                                      height: h / 13,
                                      width: w / 6,
                                      child: Image.asset(
                                        "assets/icons/doctor-visit.png",
                                      )),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Waxing",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: w / 60,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CategoriesListController()));
                          },
                          child: Container(
                            height: h / 7,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                                ]),
                            child: Center(
                                child: Container(
                                    height: h / 13,
                                    width: w / 6,
                                    child: Image.asset(
                                      "assets/icons/engineering.png",
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Bleach",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: w / 60,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoriesListController()));
                          },
                          child: Container(
                            height: h / 7,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(color: Colors.grey.shade300, blurRadius: 3)
                                ]),
                            child: Center(
                                child: Container(
                                    height: h / 13,
                                    width: w / 6,
                                    child: Image.asset(
                                      "assets/icons/skin-treatment.png",
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Facial",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
