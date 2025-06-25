import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/add_service_screen_1.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/profile_page.dart';
import 'package:hire_any_thing/Vendor_App/view/serviceses/add_servie_home.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/profile_controller.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';
import 'package:hire_any_thing/res/routes/routes.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Future<void> _loadToken() async {
    dynamic token = await SessionVendorSideManager().getToken() ?? "";
    print("Loaded Token: $token");
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                final sessionManager = SessionVendorSideManager();
                await sessionManager.deleteSession();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Get.offAllNamed(UserRoutesName.homeUserView);
              },
              child: const Text("Logout"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final apiService = Get.put(ApiServiceVenderSide());
    final ProfileController controller = Get.put(ProfileController(apiService: apiService));

    return Align(
      alignment: Alignment.centerLeft,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.7,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0xff1D1E22),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Obx(() {
                var profile = controller.profile.value;
                return DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xff1D1E22)),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: profile?.vendorImage != null && profile!.vendorImage.isNotEmpty
                            ? NetworkImage(profile.vendorImage)
                            : const NetworkImage('https://via.placeholder.com/150'),
                        radius: 40,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        profile?.name ?? 'User Name',
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                );
              }),
              _buildItem(
                icon: Icons.dashboard,
                title: 'Dashboard',
                onTap: () {
                  Get.to(() => HomePageAddService());
                },
              ),
              _buildItem(
                icon: CupertinoIcons.profile_circled,
                title: 'Vendor Profile',
                onTap: () {
                  Get.to(() => ProfilePage());
                },
              ),
              _buildItem(
                icon: Icons.miscellaneous_services,
                title: 'Vendor Services',
                onTap: () {
                  Get.to(() => AddServiceScreenFirst());
                },
              ),
              _buildItem(
                icon: Icons.stacked_line_chart_outlined,
                title: 'Booking Status',
                onTap: () {},
              ),
              _buildItem(
                icon: Icons.payment,
                title: 'Account And Payment',
                onTap: () {
                  Get.toNamed(VendorRoutesName.accountsAndManagementScreen);
                },
              ),
              _buildItem(
                icon: Icons.logout,
                title: 'Log Out',
                onTap: () {
                  _showLogoutDialog(context);
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem({required IconData icon, required String title, required GestureTapCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}