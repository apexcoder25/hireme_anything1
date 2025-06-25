import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/agree.dart';
import 'package:hire_any_thing/data/getx_controller/user_side/user_profile_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';
import 'package:hire_any_thing/views/About/about_screen.dart';
import 'package:hire_any_thing/views/HomePage/home_page.dart';
import 'package:hire_any_thing/views/UserHomePage/user_home_page.dart';
import 'package:hire_any_thing/views/contactUs/contact_us.dart';
import 'package:hire_any_thing/views/user_booking_details/views/my_booking_screen.dart';
import 'package:hire_any_thing/views/user_profle/user_profle_screen.dart';
import 'package:hire_any_thing/views/why_choose_us_screen/why_choose_us_screen.dart';

class UserDrawer extends StatefulWidget {
  final ValueChanged<int> onItemSelected;

  const UserDrawer({super.key, required this.onItemSelected});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  @override
  Widget build(BuildContext context) {
    final UserProfileController controller = Get.find<UserProfileController>();
    final SessionManageerUserSide session = SessionManageerUserSide();

    final List<Map<String, dynamic>> drawerItems = [
      {'icon': Icons.home, 'title': 'Home Page', 'screen': () => UserHomePageScreen()},
      {'icon': Icons.login, 'title': 'Login/SignUp', 'screen': () => const Agree_screen()},
      {'icon': Icons.functions, 'title': 'Why Choose Us', 'screen': () =>  WhyChooseUsScreen()},
      {'icon': Icons.book_online, 'title': 'Book Services', 'screen': () => ServicesScreen()},
      {'icon': Icons.contact_page_outlined, 'title': 'Contact Us', 'screen': () => const ContactUsScreen()},
      {'icon': Icons.info_rounded, 'title': 'About', 'screen': () => const AboutScreen()},
    ];

    return Drawer(
      backgroundColor: const Color(0xff1D1E22),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Obx(() {
  
        final items = List<Map<String, dynamic>>.from(drawerItems);
        if (controller.isLogin.value) {
          items.add({'icon': Icons.logout, 'title': 'Log Out', 'screen': () => const Agree_screen()});
          items.insert(2, {'icon': Icons.book_online, 'title': 'My Bookings', 'screen': () => MyBookingsScreen()});
          items.insert(5, {'icon': Icons.book_online, 'title': 'User Profile', 'screen': () => UserProfileScreen()});
          items.removeAt(1); 
        }

        return ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildDrawerHeader(controller),
            ...items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return _buildDrawerItem(
                icon: item['icon'],
                title: item['title'],
                selected: index == 0,
                onTap: () {
                  widget.onItemSelected(index);
                  if (item['title'] == 'Log Out') {
                    _showLogoutDialog(context, session);
                  } else if (item['screen'] != null) {
                    Navigator.pop(context);
                    Get.to(item['screen']());
                  }
                },
              );
            }).toList(),
          ],
        );
      }),
    );
  }

  Widget _buildDrawerHeader(UserProfileController controller) {
    return DrawerHeader(
      decoration: const BoxDecoration(color: Color(0xff1D1E22)),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        var profile = controller.profile.value;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://hireanything.com/image/Hireanything.jpg'),
            ),
            const SizedBox(height: 20),
            Text(
              profile?.firstName != null && profile?.lastName != null
                  ? "${profile!.firstName} ${profile!.lastName}"
                  : "Please Login",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
      selected: selected,
      selectedTileColor: Colors.white.withOpacity(0.1),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context, SessionManageerUserSide session) {
    Navigator.pop(context); // Close drawer
    Get.dialog(
      AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              session.removeToken();
              Get.back();
              Get.offAll(() => const Agree_screen());
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}