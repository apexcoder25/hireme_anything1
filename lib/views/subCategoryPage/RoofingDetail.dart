import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../navigation_bar.dart';
import '../../utilities/constant.dart';
import '../date_timeSelect.dart';

class RoofingDetail extends StatefulWidget {
  const RoofingDetail({super.key});

  @override
  State<RoofingDetail> createState() => _RoofingDetailState();
}

class _RoofingDetailState extends State<RoofingDetail> {
  List<bool> isExpandedList = List.filled(4, false);
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
            "Roofing",
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
    body: Container(height: h,
      width: w,color: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*1/100,),
              Row(
                children: [
                  Container(alignment: Alignment.center,padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height*5/100,
                    width:MediaQuery.of(context).size.width*40/100,
                    color: kwhiteColor,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Top Rated",style: TextStyle(fontWeight: FontWeight.bold),),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*1/100,),
                  Container(alignment: Alignment.center,padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height*5/100,
                    width:MediaQuery.of(context).size.width*25/100,
                    color: kwhiteColor,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Icon(Icons.sort_by_alpha_sharp),
                        Text("Sort",style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),

                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*1/100,),
                  Container(alignment: Alignment.center,padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height*5/100,
                    width:MediaQuery.of(context).size.width*25/100,
                    color: kwhiteColor,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Icon(Icons.filter_alt_rounded),
                        Text("Filter",style: TextStyle(fontWeight: FontWeight.bold),),
                      ],
                    ),)
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*2/100,
              ),
              ListView.builder(
                  itemCount: 4,
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
                      "John Smith",
                      "Jane Doe",
                      "Alice Johnson",
                      "Bob Brown",
                    ];

                    int imageIndex = index % images.length;
                    int nameIndex = index % names.length;

                    String imageUrl = images[imageIndex];
                    String name = names[nameIndex];
                    String $rating ="";
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRect(

                          child: Card(
                            elevation: 1,
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Stack(children: [
                                    Row(
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceEvenly,
                                      children: [
                                        CircleAvatar(
                                          radius: w / 12,
                                          backgroundImage: AssetImage(
                                            imageUrl,
                                          ),
                                        ),
                                        SizedBox(
                                          width: w / 20,
                                        ),
                                        Text(
                                          name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      bottom: h / 80,
                                      left: w / 9,
                                      child: SvgPicture.asset(
                                        "assets/images/Starlogo.svg",
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: h / 50,
                                      left: w / 7.8,
                                      child: SvgPicture.asset(
                                        "assets/images/ticklogo.svg",
                                        height: 8,
                                        color: Colors.white,
                                      ),
                                    )
                                  ]),
                                  SizedBox(
                                    height: h / 50,
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/star.svg",
                                        height: 20,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: w / 50,
                                      ),
                                      Text(
                                        "5.0",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        " (1.1k Rating)",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10),
                                      ),
                                      SizedBox(
                                        width: w / 20,
                                      ),

                                    ],
                                  ),
                                  SizedBox(
                                    height: h / 100,
                                  ),

                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/location.svg",
                                        color: kPrimaryColor,
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: w / 50,
                                      ),
                                      Container(
                                        width: w / 1.5,
                                        child: Text(
                                          "2 km from you",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h / 100,
                                  ),
                                  Row(
                                    children: [

                                      SizedBox(
                                        width: w / 65,
                                      ),
                                      Container(
                                        width: w / 2.5,
                                        child: const Text(
                                          "\u{20B9}${320}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DateShow()));
                                      },
                                        child: Container(
                                          height: h * 0.05,
                                          width: w * 0.36,
                                          decoration: BoxDecoration(
                                            color: kTextColor2,
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: kTextColor2
                                                    .withOpacity(0.5),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                                offset: Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: const Center(
                                              child: Text(
                                                "Add To Cart ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    // fontSize isPortrait ? 16 : 20,
                                                    fontWeight: FontWeight.w600),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
            ],
          ),
        ),
      ),

    ),);
  }
}
