import 'package:hire_any_thing/Vendor_App/controller/splash.dart';
import 'package:hire_any_thing/Vendor_App/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final splash_controller = Get.put(Splash_controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf5f5f3),
      // backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
          child: InkWell(
        onTap: () {
          Get.to(Login());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/app_logo/SH.png",
                height: 260,
                width: 320,
              )),
        ),
      )),
    );
  }
}
