import 'package:flutter/material.dart';

import '../../../navigation_bar.dart';
import '../../../utilities/AppConstant.dart';
import 'Doctor.dart';
import 'elctrician.dart';
import 'sub_categories_screen.dart';

class HomeCare extends StatefulWidget {
  const HomeCare({super.key});

  @override
  State<HomeCare> createState() => _HomeCareState();
}

class _HomeCareState extends State<HomeCare> {
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
          "Home Care",
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
      body:  Container(
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
                            height: h / 10.5,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Doctor_Screen()));
                                  },
                                  child: Container(
                                      height: h / 13,
                                      width: w / 6,
                                      child: Image.asset(
                                        "assets/icons/nursing.png",
                                      )),
                                )),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text("Nurse",
                              style: AppConstant.HomeCategori),
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
                                        Electrician_Screen()));
                          },
                          child: Container(
                            height: h / 10.5,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Container(
                                    height: h / 13,
                                    width: w / 6,
                                    child: Image.asset(
                                      "assets/icons/attendent.png",
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Attendent", style: AppConstant.HomeCategori),
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
                                    builder: (context) => SubCategoriesScreen()));
                          },
                          child: Container(
                            height: h / 10.5,
                            width: w / 3.5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                                child: Container(
                                    height: h / 13,
                                    width: w / 6,
                                    child: Image.asset(
                                      "assets/icons/swipper.png",
                                    ))),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Swipper", style: AppConstant.HomeCategori),
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
