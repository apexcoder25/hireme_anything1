import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hire_any_thing/Auth/login.dart';
import 'package:hire_any_thing/Auth/phoneLogin.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _phone;
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Sign Up",style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 50 / 100,
                    width: MediaQuery.of(context).size.width * 90 / 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 1 / 100,
                        ),
                        Text(
                          "Sign up with",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "email and phone number",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 7 / 100,
                          width: MediaQuery.of(context).size.width * 80 / 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey.shade300,
                          ),
                          child: TextFormField(
                            maxLength: 50,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              }
                              if (!isValidEmail(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                              prefixIcon: Icon(
                                Icons.email,
                              ),
                              hintText: "johndoe@gmail.com",
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  0.2 /
                                  100,
                              width:
                                  MediaQuery.of(context).size.width * 30 / 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Text("OR"),
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  0.2 /
                                  100,
                              width:
                                  MediaQuery.of(context).size.width * 30 / 100,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: MediaQuery.of(context).size.height * 7 / 100,
                          width: MediaQuery.of(context).size.width * 80 / 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: Colors.grey.shade300,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    30 /
                                    100,
                                child: CountryCodePicker(
                                  initialSelection: 'IN',

                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    50 /
                                    100,
                                child: TextFormField(
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone no';
                                    }
                                    if (value.length < 10) {
                                      return 'Invalid no.';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _phone = value!;
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "111 222 333",
                                    border: InputBorder.none,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                        ),

                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPage()));

                        },
                          child: Container(
                            alignment: Alignment.center,
                            height:
                                MediaQuery.of(context).size.height * 6 / 100,
                            width: MediaQuery.of(context).size.width * 80 / 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.green,
                            ),
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 27 / 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an  acoount ?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                        child: Text(
                          "Signin!",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return email.contains('@');
  }
}
