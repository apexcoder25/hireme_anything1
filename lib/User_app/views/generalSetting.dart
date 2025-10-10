import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:hire_any_thing/utilities/constant.dart';
import 'package:flutter/material.dart';
import 'package:hire_any_thing/User_app/views/EditProfile.dart';
import '../../navigation_bar.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {


  @override
  void initState() {
    Future.microtask(() => getUserDetailFromSession()).whenComplete((){
      setState(() {
      });
    });
    // TODO: implement initState
    super.initState();
  }
  String? name;
  String? mobile;
  String? email;
  String? counrtyCode;
  String? gender;
  String? imageName;


  getUserDetailFromSession() async {
    final sessionManager = await SessionManageerUserSide(); // Initialize session manager
    name=await sessionManager.getName();
    email=await sessionManager.getEmail();
    mobile=await sessionManager.getEmail();
    counrtyCode=await sessionManager.getCountryCode();
    gender=await sessionManager.getGender();
    imageName=await sessionManager.getUserImage();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      appBar:PreferredSize(
          preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF295AB3), // AppBar background color
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF295AB3), // Border color
                width: 2.0, // Border width
              ),
            ),
          ),
          child: AppBar(
            centerTitle: true,
            // backgroundColor: Colors.transparent,
            // surfaceTintColor: Colors.transparent,
            forceMaterialTransparency: true,
            title: const Text(
              "General setting",
              style: TextStyle(color:Colors.white,fontSize: 18, fontWeight: FontWeight.w500),
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
                child: Icon(Icons.arrow_back_ios_new_sharp,color:Colors.white)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // height: h / 4.5,
              padding: const EdgeInsets.all(16),
              // margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF295AB3), // Border color
                      width: 2.0, // Border width
                    ),
                  ),
                  // color: Colors.white,
                  color:  Color(0xFF295AB3),
                  borderRadius: BorderRadius.only(
                      bottomLeft:Radius.circular(10) ,
                      bottomRight: Radius.circular(10)

                  ),
                  // border: Border.all(width: 1, color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade50,
                      blurRadius: 2,
                    ),
                  ]),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // Adjust the radius as needed
                    child: Image.network("${appUrlsUserSide.baseUrlImages}${imageName}",
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      errorBuilder: (BuildContext, Object, StackTrace) {
                        return   CircleAvatar(
                            radius: 60,
                            // backgroundImage: AssetImage(
                            //   "assets/images/myprofile.png",
                            // ),
                            child: Icon(Icons.account_circle_sharp,size:120,color: Colors.white,));
                      },

                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 60,
                  //   // backgroundImage: const AssetImage(
                  //   //   "assets/images/myprofile.png",
                  //   // ),
                  //   child:Icon(Icons.account_circle_sharp,size:120,color: Colors.white,),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${name ?? ""}",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  Container(
                    // color: Colors.red,
                    width: w,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: h / 20),
                          SizedBox(width: 30),
                          const Icon(
                            Icons.phone,
                            size: 24,
                            color: Colors.white,
                          ),
                           Text(
                            "${counrtyCode}${mobile}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            '|',
                            style: TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          const Icon(
                            Icons.mail,
                            size: 24,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                           Text(
                            "$email ?? ""}",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color:Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              // height: h,
              width: w,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Email',
                          style: (TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                        ),
                         Text(
                          '${email ?? ""}',
                          style:
                              (TextStyle(color: kPrimaryColor, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        const Text(
                          'Gender',
                          style: (TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          )),
                        ),

                         Text(
                          '${gender ?? ""}',
                          style:
                              (TextStyle(color: kPrimaryColor, fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Color(0xffF1F5F8),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),


            InkWell(
              onTap: () {


                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile()
                    )
                );
              },
              child: Container(
                  height: h / 20,
                  alignment: Alignment.center,
                  width: w / 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor),
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
            )

          ],
        ),
      ),
    );
  }
}
