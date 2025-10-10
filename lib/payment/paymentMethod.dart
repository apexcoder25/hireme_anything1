import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/AppImages.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:hire_any_thing/User_app/views/booking_success.dart';

import '../navigation_bar.dart';
class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,

        title: Text(
          "Payment Method",
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
      body: SingleChildScrollView(
        child: Container(color: Colors.grey.shade100,
          height: MediaQuery.of(context).size.height*100/100,
          width: MediaQuery.of(context).size.width*100/100,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*5/100,),
              Container(height: MediaQuery.of(context).size.height*35/100,
              width: MediaQuery.of(context).size.width*100/100,
              child:  CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/paymentcard.png"),
              ),),
              SizedBox(height: MediaQuery.of(context).size.height*2/100,),
        
              Container(padding: EdgeInsets.only(left: 10),
                height: MediaQuery.of(context).size.height*6.5/100,
                width: MediaQuery.of(context).size.width*90/100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
        
                ),
                child: TextFormField(maxLength: 30,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Account Number",
                    counterText: "",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*2/100,),
        
              Container(padding: EdgeInsets.only(left: 10),
                height: MediaQuery.of(context).size.height*6.5/100,
                width: MediaQuery.of(context).size.width*90/100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
        
                ),
                child: TextFormField(maxLength: 30,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Card Number",
                    counterText: "",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*2/100,),
        
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(padding: EdgeInsets.only(left: 10),
                    height: MediaQuery.of(context).size.height*6.5/100,
                    width: MediaQuery.of(context).size.width*40/100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
        
                    ),
                    child: TextFormField(maxLength: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Exp. Date",
                        counterText: "",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
        
                  Container(padding: EdgeInsets.only(left: 10),
                    height: MediaQuery.of(context).size.height*6.5/100,
                    width: MediaQuery.of(context).size.width*40/100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
        
                    ),
                    child: TextFormField(maxLength: 3,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "CVV Code",
                        counterText: "",
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
        
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*2/100,),
              InkWell(onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingSuccessfulPage()));
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
        ),
      ),

    );
  }
}
