// import 'dart:convert';

// import 'package:get/get.dart';
// import 'package:hire_any_thing/data/models/user_side_model/aboutModel.dart';
// import 'package:http/http.dart' as http;

// class AboutController extends GetxController{
//   var aboutInfo = <AboutModel>[].obs;
//   var isLoading = false.obs;


//   final String apiUrl = "https://admin.hireanything.com/api/aboutus";
//    @override
//   void onInit() {
//     fetchAboutInfo();
//     super.onInit();
//   }


//   Future<void> fetchAboutInfo() async {

//     isLoading(true);

//     try {

//       final response =await http.get(Uri.parse(apiUrl));

//       if(response.statusCode == 200){
//         List<dynamic> jsonData = jsonDecode(response.body);

//         aboutInfo.value = jsonData.map((e) => AboutModel.fromJson(e)).toList();

//       }
//       else{
//         Get.snackbar("Error", "Failed to Load About Info.");
//       }
      
//     } catch (e) {
//         Get.snackbar("Error", "Failed to Load About Info. ${e}");
      
//     }
//     finally{
//       isLoading(false);
//     }
//   }




  
// }