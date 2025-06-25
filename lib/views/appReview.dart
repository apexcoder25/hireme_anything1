import 'package:flutter/material.dart';
import 'package:hire_any_thing/views/profile.dart';

import '../navigation_bar.dart';
import '../utilities/constant.dart';
class AppReview extends StatefulWidget {
  const AppReview({super.key});

  @override
  State<AppReview> createState() => _AppReviewState();
}

class _AppReviewState extends State<AppReview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        title: Text(
          "App Review",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const Navi(),
                ),
              );
            },
            child: Icon(Icons.arrow_back_ios_new_sharp)),
      ),
      body: SingleChildScrollView(
        child: Container(color: Colors.grey.shade100,
          height: MediaQuery.of(context).size.height*100/100,
          width: MediaQuery.of(context).size.width*100/100,
          child: Column(
            children: [
              Container(height: MediaQuery.of(context).size.height*35/100,
                width: MediaQuery.of(context).size.width*90/100,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/icons/review.png"),fit: BoxFit.fill)
                ),
                ),
              SizedBox(height: MediaQuery.of(context).size.height*2/100,),
              Container(padding: EdgeInsets.only(left: 5,right: 5,top: 5),
                height: MediaQuery.of(context).size.height * 60 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: BoxDecoration(
                  color: kwhiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],

                ),
                child: Column(
                  children: [
                    Text("Please rate the quality of service\nfor the order", textAlign: TextAlign.center,style: TextStyle(
                      color: kblackTextColor,fontWeight: FontWeight.bold,fontSize: 19
                    ),),
                    SizedBox(height: MediaQuery.of(context).size.height*2/100,),

                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star_border,size: 40,),
                        Icon(Icons.star_border,size: 40,),
                        Icon(Icons.star_border,size: 40,),
                        Icon(Icons.star_border,size: 40,),
                        Icon(Icons.star_border,size: 40,),

                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*4/100,),

                    Text("Your Comments and suggestions help us \nimprove the service quality better!",textAlign: TextAlign.center,),
                    SizedBox(height: MediaQuery.of(context).size.height*4/100,),

                    Container(padding: EdgeInsets.only(left: 5),
                      height: MediaQuery.of(context).size.height*15/100,
                      width: MediaQuery.of(context).size.width*80/100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: TextFormField(
                        maxLines: 99,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write your note here"
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height*2/100,),

                    InkWell(onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Navi()));
                    },
                      child: Container(alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height*6/100,
                        width: MediaQuery.of(context).size.width*90/100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kPrimaryColor,

                        ),
                        child: Text(
                          "Save Now",style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18
                        ),
                        ),
                      ),
                    )


                  ],
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
