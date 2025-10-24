import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/agree.dart';
import 'package:hire_any_thing/User_app/views/main_dashboard/controllers/user_dashboard_controller.dart';
import 'package:hire_any_thing/User_app/views/user_profle/controller/user_profile_controller.dart';
import 'package:hire_any_thing/data/session_manage/session_user_side_manage.dart';

class UserDrawer extends StatefulWidget {
  final UserDashboardController controller;

  const UserDrawer({super.key, required this.controller});

  @override
  State<UserDrawer> createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  final UserProfileController profileController = Get.find<UserProfileController>();

  Future<void> _loadUserData() async {
    await profileController.fetchProfile();
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Row(
            children: [
              Icon(
                Icons.logout,
                color: Colors.red.shade600,
                size: 24,
              ),
              const SizedBox(width: 10),
              const Text(
                "Logout",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          content: const Text(
            "Are you sure you want to log out from your account?",
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Show loading
                Get.dialog(
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                  barrierDismissible: false,
                );

                try {
                  final sessionManager = SessionManageerUserSide();
                  await sessionManager.removeToken();

                  // Close loading dialog
                  Get.back();
                  // Close logout dialog
                  Get.back();
                  // Close drawer
                  Get.back();

                  // Navigate to login screen
                  Get.offAll(() => const Agree_screen());

                  Get.snackbar(
                    'Success',
                    'Logged out successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 2),
                  );
                } catch (e) {
                  // Close loading dialog
                  Get.back();

                  Get.snackbar(
                    'Error',
                    'Failed to logout. Please try again.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff1D1E22),
        ),
        child: Column(
          children: [
            // Header with profile info
            Obx(() {
              var profile = profileController.profile.value!.data;
              bool isLoggedIn = profileController.isLogin.value;
              
              return DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xff1D1E22),
                ),
                child: Column(
                  children: [
                    // Profile Image with border
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        // backgroundImage: isLoggedIn && profile?.profileImage != null && profile!.profileImage!.isNotEmpty
                        //     ? NetworkImage(profile.profileImage!)
                        //     : const NetworkImage('https://hireanything.com/image/Hireanything.jpg'),
                        // radius: 35,
                        // backgroundColor: Colors.grey.shade300,
                        // onBackgroundImageError: (exception, stackTrace) {
                        //   print('Profile image load error: $exception');
                        // },
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Name
                    Text(
                      isLoggedIn && profile?.firstName != null && profile?.lastName != null
                          ? '${profile!.firstName} ${profile.lastName}'
                          : 'Please Login',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (isLoggedIn && profile?.email != null)
                      Text(
                        profile!.email ?? '',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              );
            }),
            // Navigation Items
            Expanded(
              child: Obx(() {
                bool isLoggedIn = profileController.isLogin.value;
                
                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    // Home Page (Always visible)
                    _buildNavigationItem(
                      icon: Icons.home_outlined,
                      activeIcon: Icons.home,
                      title: 'Home Page',
                      index: 0,
                    ),

                    // Login/SignUp (Only when not logged in)
                    if (!isLoggedIn)
                      _buildLoginItem(),

                    // My Bookings (Only when logged in)
                    if (isLoggedIn)
                      _buildNavigationItem(
                        icon: Icons.book_online_outlined,
                        activeIcon: Icons.book_online,
                        title: 'My Bookings',
                        index: 1,
                      ),

                    // Why Choose Us
                    _buildNavigationItem(
                      icon: Icons.functions_outlined,
                      activeIcon: Icons.functions,
                      title: 'Why Choose Us',
                      index: 2,
                    ),

                    // Book Services
                    _buildNavigationItem(
                      icon: Icons.miscellaneous_services_outlined,
                      activeIcon: Icons.miscellaneous_services,
                      title: 'Book Services',
                      index: 3,
                    ),

                    // User Profile (Only when logged in)
                    if (isLoggedIn)
                      _buildNavigationItem(
                        icon: CupertinoIcons.profile_circled,
                        activeIcon: CupertinoIcons.person_fill,
                        title: 'User Profile',
                        index: 4,
                      ),

                    // Contact Us
                    _buildNavigationItem(
                      icon: Icons.contact_page_outlined,
                      activeIcon: Icons.contact_page,
                      title: 'Contact Us',
                      index: 5,
                    ),

                    // About
                    _buildNavigationItem( 
                      icon: Icons.info_outline,
                      activeIcon: Icons.info,
                      title: 'About',
                      index: 6,
                    ),

                    // Divider
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Divider(
                        color: Colors.white24,
                        thickness: 0.5,
                      ),
                    ),

                    // Logout (Only when logged in)
                    if (isLoggedIn)
                      _buildLogoutItem(),
                  ],
                );
              }),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  const Divider(
                    color: Colors.white24,
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'HireAnything User',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationItem({
    required IconData icon,
    required IconData activeIcon,
    required String title,
    required int index,
  }) {
    return Obx(() {
      bool isSelected = widget.controller.selectedIndex.value == index;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Icon(
            isSelected ? activeIcon : icon,
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            size: 22,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.8),
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          trailing: isSelected
              ? Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                )
              : null,
          onTap: () {
            _handleNavigation(title, index);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          hoverColor: Colors.white.withOpacity(0.05),
          splashColor: Colors.white.withOpacity(0.1),
        ),
      );
    });
  }

  void _handleNavigation(String title, int index) {
    Navigator.of(context).pop(); // Close drawer
    
    switch (title) {
      case 'Home Page':
        widget.controller.changeTab(0);
        break;
      case 'My Bookings':
        widget.controller.changeTab(1);
        break;
      case 'Why Choose Us':
        // Navigate to external screen
        widget.controller.changeTab(2);
        break;
      case 'Book Services':
        // Navigate to external screen
        widget.controller.changeTab(3);
        break;
      case 'User Profile':
        widget.controller.changeTab(4);
        break;
      case 'Contact Us':
        widget.controller.changeTab(5);
        break;
      case 'About':
        widget.controller.changeTab(6);
        break;
    }
  }

  Widget _buildLogoutItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          Icons.logout_outlined,
          color: Colors.red.shade400,
          size: 22,
        ),
        title: Text(
          'Log Out',
          style: TextStyle(
            color: Colors.red.shade400,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        onTap: () {
          _showLogoutDialog(context);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hoverColor: Colors.white.withOpacity(0.05),
        splashColor: Colors.white.withOpacity(0.1),
      ),
    );
  }

  Widget _buildLoginItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.transparent,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(
          Icons.login_outlined,
          color: Colors.green.shade400,
          size: 22,
        ),
        title: Text(
          'Login/SignUp',
          style: TextStyle(
            color: Colors.green.shade400,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        onTap: () {
          Navigator.of(context).pop(); // Close drawer
          Get.to(() => const Agree_screen());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hoverColor: Colors.white.withOpacity(0.05),
        splashColor: Colors.white.withOpacity(0.1),
      ),
    );
  }
}
