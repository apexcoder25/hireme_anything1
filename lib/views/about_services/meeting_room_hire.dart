// import 'package:flutter/material.dart';
// import 'package:hire_any_thing/utilities/constant.dart';
// import 'package:hire_any_thing/views/widget/about_service.dart';
// import 'package:hire_any_thing/views/widget/service_section.dart';
// import 'package:hire_any_thing/views/widget/why_choose_us.dart';

// class MeetingRoomHireScreen extends StatelessWidget {
//   const MeetingRoomHireScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Meeting Room Hire"),
//         centerTitle: true,
//       ),
//       backgroundColor: AppColors.background,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//              const AboutService(),
//              const SizedBox(height: 10,),
//             const WhyChooseUs(),
//             ServiceSection(
//               title: "OUR MEETING ROOM HIRE EXCELLENCE",
//               items: [
//                 {
//                   'title': "Modern & Professional Spaces",
//                   'description': "Our meeting rooms are designed to create an ideal environment for focus and collaboration.",
//                   'icon': Icons.check_circle,
//                   'iconColor': AppColors.accentBlue,
//                 },
//                 {
//                   'title': "Fully Equipped Rooms",
//                   'description': "Access to high-speed internet, AV systems, and other tools ensures seamless presentations and discussions.",
//                   'icon': Icons.computer,
//                   'iconColor': AppColors.accentGreen,
//                 },
//                 {
//                   'title': "Support When You Need It",
//                   'description': "Our on-site staff is always ready to assist with technical setup and other requirements.",
//                   'icon': Icons.support_agent,
//                   'iconColor': AppColors.accentPurple,
//                 },
//                 {
//                   'title': "Transparent Pricing",
//                   'description': "Affordable rates with no hidden fees, giving you confidence in your budget planning.",
//                   'icon': Icons.monetization_on,
//                   'iconColor': AppColors.accentYellow,
//                 },
//               ],
//             ),
           
//             // Add more sections as needed
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class MeetingRoomHireScreen extends StatelessWidget {
   const MeetingRoomHireScreen({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
          Icon(Icons.error,size: 100,),
          Text(
            "This service is not available yet",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )
        ],),

      )
    );

  }
}