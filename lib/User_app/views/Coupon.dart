import 'package:flutter/material.dart';
import 'package:hire_any_thing/User_app/views/profile.dart';

import '../../navigation_bar.dart';
import '../../utilities/constant.dart';
import 'booking_success.dart';

class MyCoupons extends StatefulWidget {
  const MyCoupons({super.key});

  @override
  State<MyCoupons> createState() => _MyCouponsState();
}

class _MyCouponsState extends State<MyCoupons> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kwhiteColor,
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        backgroundColor: Colors.white,
        // surfaceTintColor: Colors.transparent,
        forceMaterialTransparency: true,
        title: Text(
          "My Coupons",
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
      body: SingleChildScrollView(
        child: Container(
          color: Colors.grey.shade100,
          height: MediaQuery.of(context).size.height * 100 / 100,
          width: MediaQuery.of(context).size.width * 100 / 100,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 5 / 100,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 35 / 100,
                width: MediaQuery.of(context).size.width * 100 / 100,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/icons/coupon.png"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 2 / 100,
              ),
              Container(
                height: MediaQuery.of(context).size.height * 35 / 100,
                width: MediaQuery.of(context).size.width * 90 / 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: kwhiteColor),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    Text(
                      "You do not have coupons",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
        
        
                    Text(textAlign:TextAlign.center,
                      "Go hunt for vouchers at laundry\nVoucher right away",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey.shade400, fontSize: 15),
                    ), SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 6.5 / 100,
                      width: MediaQuery.of(context).size.width * 70 / 100,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        maxLength: 30,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter the Voucher",
                          counterText: "",
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Navi()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 6 / 100,
                        width: MediaQuery.of(context).size.width * 70 / 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kPrimaryColor,
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    )
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
