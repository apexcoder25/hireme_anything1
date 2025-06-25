// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class HeroSlider extends StatefulWidget {
//   @override
//   _HeroSliderState createState() => _HeroSliderState();
// }

// class _HeroSliderState extends State<HeroSlider> {
//   int _currentIndex = 0;

//   final List<String> imageUrls = [
//     'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?auto=format&fit=crop&w=1200&q=75',
//     'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=2070&auto=format&fit=crop',
//     'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=2071&auto=format&fit=crop'
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final double height = MediaQuery.of(context).size.height;
//     final double width = MediaQuery.of(context).size.width;

//     return SizedBox(
//       height: height * 0.5, // Ensure Stack has a fixed height
//       child: Stack(
//         children: [
//           // Background Image Carousel
//           SizedBox(
//             height: height * 0.3, // Set height to avoid layout issues
//             width: double.infinity,
//             child: CarouselSlider(
//               options: CarouselOptions(
//                 height: height * 0.3,
//                 autoPlay: true,
//                 autoPlayInterval: Duration(seconds: 5),
//                 enlargeCenterPage: true,
//                 viewportFraction: 1.0,
//                 onPageChanged: (index, reason) {
//                   setState(() {
//                     _currentIndex = index;
//                   });
//                 },
//               ),
//               items: imageUrls.map((imagePath) {
//                 return Container(
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: NetworkImage(imagePath),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),

//           // Overlay Content
//           Positioned(
//             top: height * 0.1, // Position text within safe space
//             left: 0,
//             right: 0,
//             child: Column(
//               children: [
//                 Text(
//                   "Professional Tutoring",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   "Expert tutors for all subjects and levels",
//                   style: TextStyle(
//                     color: Colors.white70,
//                     fontSize: 18,
//                   ),
//                 ),
//                 SizedBox(height: 20),

//                 // Search Bar (Disabled in UI for now)
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 30),
//                   padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Row(
//                     children: [
//                       // You can enable these fields when needed
//                       // Expanded(
//                       //   child: TextField(
//                       //     decoration: InputDecoration(
//                       //       hintText: "Category",
//                       //       hintStyle: TextStyle(color: Colors.white),
//                       //       border: InputBorder.none,
//                       //     ),
//                       //   ),
//                       // ),
//                       // Expanded(
//                       //   child: TextField(
//                       //     decoration: InputDecoration(
//                       //       hintText: "Select Category First",
//                       //       hintStyle: TextStyle(color: Colors.white),
//                       //       border: InputBorder.none,
//                       //     ),
//                       //   ),
//                       // ),
//                       // ElevatedButton(
//                       //   style: ElevatedButton.styleFrom(
//                       //     backgroundColor: Colors.orange,
//                       //     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       //   ),
//                       //   onPressed: () {},
//                       //   child: Text("Search"),
//                       // ),
//                     ],
//                   ),
//                 ),

//                 SizedBox(height: 20),

//                 // Feature Boxes
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     FeatureBox(title: "24/7", subtitle: "Available"),
//                     SizedBox(width: 20),
//                     FeatureBox(title: "100%", subtitle: "Success"),
//                     SizedBox(width: 20),
//                     FeatureBox(title: "Fast", subtitle: "Response"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Feature Box Widget
// class FeatureBox extends StatelessWidget {
//   final String title;
//   final String subtitle;

//   FeatureBox({required this.title, required this.subtitle});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.white, width: 1.5),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             subtitle,
//             style: TextStyle(
//               color: Colors.white70,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
