import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_profile_controller.dart';
import 'package:hire_any_thing/res/routes/routes_name.dart';
import 'package:hire_any_thing/splash.dart';
import 'package:hire_any_thing/utilities/AppFonts.dart';
import 'package:hire_any_thing/User_app/views/subCategoryPage/electricianDetail.dart';

ProductDetails? selectedProduct;

Future<void> main() async {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
   // if needed

  // Inject the controller globally
  Get.put(UserProfileController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hire Anything',
        theme: ThemeData(
          fontFamily: AppFont.fontFamily,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        getPages:AppRoutes.appRoutes(),
        // home:EditProfileScreen()

       home: Splash(),
       

       // home: AddServiceScreenServiceSecond()

       // home: AddServiceScreenServiceSecond()

       // home: SendEmailPage()

        // home: Signup()

    );
  }
}

