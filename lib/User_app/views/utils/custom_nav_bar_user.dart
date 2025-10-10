// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hire_any_thing/views/HomePage/home_page.dart';
// import 'package:hire_any_thing/views/UserHomePage/user_home_page.dart';


// // Define enum for better readability
// enum _SelectedTab { home, search, book_service, about, contact }

// class BottomNavigationScreen extends StatefulWidget {
//   @override
//   _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
// }

// class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
//   int _currentIndex = 0;

//   // List of screens
//   final List<Widget> _screens = [
//     UserHomePageScreen(),
//     ServicesScreen(),
//     // BookServiceScreen(),
//     // AboutScreen(),
//     // ContactScreen(),
//   ];

//   void _onTabTapped(int index) {
//     if (!mounted || _currentIndex == index) return; // Prevent unnecessary rebuilds

//     setState(() {
//       _currentIndex = index;
//     });

//     // Navigate without clearing the navigation stack
//     switch (_SelectedTab.values[index]) {
//       case _SelectedTab.home:
//         Get.to(() => UserHomePageScreen(), transition: Transition.fade);
//         break;
//       case _SelectedTab.search:
//         Get.to(() => ServicesScreen(), transition: Transition.fade);
//         break;
//       case _SelectedTab.book_service:
//         // Get.to(() => BookServiceScreen(), transition: Transition.fade);
//         break;
//       case _SelectedTab.about:
//         // Get.to(() => AboutScreen(), transition: Transition.fade);
//         break;
//       case _SelectedTab.contact:
//         // Get.to(() => ContactScreen(), transition: Transition.fade);
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: Colors.white,
//         color: Colors.blue,
//         buttonBackgroundColor: Colors.blue,
//         height: 60,
//         items: const [
//           Icon(Icons.home, size: 30, color: Colors.white),
//           Icon(Icons.search, size: 30, color: Colors.white),
//           Icon(Icons.add, size: 30, color: Colors.white),
//           Icon(Icons.info, size: 30, color: Colors.white),
//           Icon(Icons.contact_mail, size: 30, color: Colors.white),
//         ],
//         onTap: _onTabTapped,
//       ),
//     );
//   }
// }
