import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/global_file.dart';
import 'package:image_picker/image_picker.dart';
import '../data/api_service/api_service_user_side.dart';
import '../navigation_bar.dart';
import '../utilities/constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => getUserDetailFromSession()).whenComplete((){
      setState(() {
      });
    });

  }
  TextEditingController emailController = TextEditingController();

  String? name;
  String? mobile;
  String? email;
  String? counrtyCode;

  String? genderName;
  String? imageName;

  getUserDetailFromSession() async {
    final sessionManager = await SessionManageerUserSide(); // Initialize session manager
    name=await sessionManager.getName();
    email=await sessionManager.getEmail();
    mobile=await sessionManager.getEmail();
    counrtyCode=await sessionManager.getCountryCode();
    emailController.text=email.toString();
    genderName=await sessionManager.getGender();
    imageName=await sessionManager.getUserImage();

  }



  final List<String> options = ['Select Gander', 'Male', 'Female'];
  // late final emailController = TextEditingController();

  // late  var userdetail = UserData[0]['data'];
  String selectedOption = "Male";

  String? _pickedImagePath;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Handle picked image file
      setState(() {
        _pickedImagePath = pickedFile.path;
        iamgePath = "";
      });
    }
  }

  // String path = UserData[0]['path'];
  String iamgePath = "assets/images/myprofile.png";


  // String? _pickedImagePath;

  bool isMaleSelected = true;
  bool isChecked = true;


  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    print("genderName=>${genderName}");
    return Scaffold(
      appBar: PreferredSize(
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
            shadowColor:Colors.red,
          
            elevation: 0,
            centerTitle: true,
            backgroundColor:Color(0xFF295AB3),
            // surfaceTintColor: Colors.transparent,
            // forceMaterialTransparency: true,
            title: Text(
              "Edit Profile",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18, fontWeight: FontWeight.w500),
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
                child: Icon(Icons.arrow_back_ios_new_sharp,
                  color: Colors.white,)),
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
                  GestureDetector(
                      onTap:_pickImage,
                    child: Stack(children: [
                      (imageName!="" && _pickedImagePath == null)?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50), // Adjust the radius as needed
                        child: Image.network("${appUrlsUserSide.baseUrlImages}${imageName}",
                          height: 100,
                          width: 100,
                          fit: BoxFit.fill,
                          errorBuilder: (BuildContext, Object, StackTrace) {
                            return   CircleAvatar(
                                radius: w / 12,
                                // backgroundImage: AssetImage(
                                //   "assets/images/myprofile.png",
                                // ),
                                child: Icon(Icons.account_circle_sharp,size:60,color: Colors.white,));
                          },

                        ),
                      )
             :
                      _pickedImagePath != null

                          ? CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(File(_pickedImagePath!))):

                      // iamgePath.length != 0
                      //     ? CircleAvatar(
                      //     radius: w / 12,
                      //     backgroundImage: NetworkImage('$path$iamgePath'))
                      //     : _pickedImagePath != null
                      //     ? CircleAvatar(
                      //     radius: w / 12,
                      //     backgroundImage: FileImage(File(_pickedImagePath!)))
                      //     :
                      CircleAvatar(
                        radius: 60,
                        // backgroundImage: AssetImage(
                        //   "assets/images/myprofile.png",
                        // ),
                       child: Icon(Icons.account_circle_sharp,size:120,color: Colors.white,),
                      ),
                      Positioned(
                        bottom: 0,
                        // right: w / 10,
                        right: 0,

                        child: Image.asset(
                          "assets/images/kk.png",
                          // color: kPrimaryColor,
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        // right: w / 10,
                        right: 6,
                        child: Image.asset(
                          "assets/images/pen3.png",
                          color: kPrimaryColor,
                        ),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${name ??""}",
                    style: TextStyle(
                      color:Colors.white,
                        fontSize: 20, fontWeight: FontWeight.bold),
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
                          Icon(
                            Icons.phone,
                            size: 24,
                            color:Colors.white,
                            // color: kPrimaryColor,
                          ),
                          Text(
                            "${counrtyCode}${mobile}",
                            style: TextStyle(
                                color:Colors.white,
                                // color: Color(0xff9399A7),
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '|',
                            style:
                            TextStyle(
                                // color: kPrimaryColor,
                                color:Colors.white,
                                fontSize: 15),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.mail,
                            size: 24,
                            // color: kPrimaryColor,
                            color:Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "${email}",
                            style: TextStyle(
                                color:Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                // color: Color(0xff686978)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            Align(alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Text(
          'Email',
          style:
          (TextStyle(color: kPrimaryColor, fontSize: 16)),
        ),
      ),
    ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              // height: h,
              // width: w,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "oops";
                      } else {
                        return null;
                      }
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 1,left: 8),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: "Email",
                    ),
                  ),
                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Gender',
                      style:
                      (TextStyle(color: kPrimaryColor, fontSize: 16)),
                    ),
                  ),
              SizedBox(
                height: 10,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // isMaleSelected = true;
                          genderName="Male";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: (genderName=="Male")?Colors.red[700] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.male, color: (genderName=="Male") ? Colors.white : Colors.grey),
                            SizedBox(width: 8),
                            Text(
                              'Male',
                              style: TextStyle(
                                color: (genderName=="Male") ? Colors.white : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          // isMaleSelected = false;
                          genderName="Female";
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: (genderName=="Female") ? Colors.red[700]: Colors.grey[200] ,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.female, color: (genderName=="Female")? Colors.white : Colors.grey  ),
                            SizedBox(width: 8),
                            Text(
                              'Female',
                              style: TextStyle(
                                color: (genderName=="Female") ? Colors.white:Colors.grey  ,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

                  Divider(
                    color: Color(0xffF1F5F8),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      final sessionManager = await SessionManageerUserSide(); // Initialize session manager
                      String?  userId= await sessionManager.getUserId();
                      String?  token= await sessionManager.getToken();

                      Future.microtask(() =>apiServiceUserSide.updateUserProfile(
                          "${userId}",
                          "${_pickedImagePath ?? ""}",
                          name,
                          email,
                          token.toString(),
                          genderName

                      )).whenComplete((){
                        // setState(() {
                        //   loader=false;
                        // });
                      });

                      // Future.microtask(() => apiServiceUserSide.);

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => Navi()
                      //     )
                      // );
                    },
                    child: Container(
                        height: h / 20,
                        alignment: Alignment.center,
                        width: w / 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kPrimaryColor),
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),


                ],
              ),
            ),
      SizedBox(
        height: 5,
      ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     Checkbox(
      //       value: isChecked,
      //       onChanged: (bool? value) {
      //         setState(() {
      //           isChecked = value ?? false;
      //         });
      //       },
      //       activeColor:Color(0xFF295AB3), //, // Checkbox color when checked
      //     ),
      //     RichText(
      //       text: TextSpan(
      //         children: [
      //           TextSpan(
      //             text: 'I agree to the ',
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontSize: 16,
      //             ),
      //           ),
      //           TextSpan(
      //             text: 'Terms & Conditions',
      //             style: TextStyle(
      //               color: Color(0xFF295AB3), //, // Highlighted color
      //               fontSize: 16,
      //               decoration: TextDecoration.underline,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
          ],
        ),
      ),
    );
  }
}
