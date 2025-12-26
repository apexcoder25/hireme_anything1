import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Auth/agree.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/addServiceScreen1/AddServiceWizardScreen.dart';
import 'package:hire_any_thing/Vendor_App/view/main_dashboard/controllers/vendor_dashboard_controller.dart';
import 'package:hire_any_thing/data/getx_controller/vender_side/profile_controller.dart';
import 'package:hire_any_thing/data/services/api_service_vendor_side.dart';
import 'package:hire_any_thing/data/session_manage/session_vendor_side_manager.dart';

class VendorDrawer extends StatefulWidget {
  final VendorDashboardController controller;

  const VendorDrawer({super.key, required this.controller});

  @override
  State<VendorDrawer> createState() => _VendorDrawerState();
}

class _VendorDrawerState extends State<VendorDrawer> {
  Future<void> _loadToken() async {
    dynamic token = await SessionVendorSideManager().getToken() ?? "";
    print("Loaded Tokens $token");
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
            "Are you sure you want to log out from your vendor account?",
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
                Get.dialog(
                  const Center(child: CircularProgressIndicator()),
                  barrierDismissible: false,
                );

                try {
                  final sessionManager = SessionVendorSideManager();
                  await sessionManager.deleteSession();

                  Get.back(); // Close loading
                  Get.back(); // Close dialog
                  Get.back(); // Close drawer

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
                  Get.back(); // Close loading
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
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
    _loadToken();
  }

  @override
  Widget build(BuildContext context) {
    final apiService = Get.put(ApiServiceVenderSide());
    final ProfileController profileController =
        Get.put(ProfileController(apiService: apiService));

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(color: Color(0xff1D1E22)),
        child: Column(
          children: [
            // Header with profile
            Obx(() {
              var profile = profileController.profile.value;
              return DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xff1D1E22)),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                      ),
                      child: CircleAvatar(
                        backgroundImage: profile?.vendorImage != null && profile!.vendorImage.isNotEmpty
                            ? NetworkImage(profile.vendorImage)
                            : const AssetImage('assets/image_new/user.png') as ImageProvider,
                        radius: 35,
                        backgroundColor: Colors.grey.shade300,
                        onBackgroundImageError: (_, __) {},
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      profile?.name ?? 'Vendor Name',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (profile?.email != null)
                      Text(
                        profile!.email,
                        style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
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
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  _buildNavigationItem(
                    icon: Icons.dashboard_outlined,
                    activeIcon: Icons.dashboard,
                    title: 'Dashboard',
                    index: 0,
                  ),
                  _buildNavigationItem(
                    icon: CupertinoIcons.profile_circled,
                    activeIcon: CupertinoIcons.person_fill,
                    title: 'Vendor Profile',
                    index: 1,
                  ),
                  // NEW: Add Services → Wizard
                  _buildNavigationItem(
                    icon: Icons.add_business_outlined,
                    activeIcon: Icons.add_business,
                    title: 'Add Services',
                    index: 2,
                    onTapOverride: () {
                      Navigator.of(context).pop(); // Close drawer
                      Get.to(() => AddServiceWizardScreen()); // Open wizard
                    },
                  ),
                  _buildNavigationItem(
                    icon: Icons.stacked_line_chart_outlined,
                    activeIcon: Icons.stacked_line_chart,
                    title: 'Booking',
                    index: 3,
                  ),
                  _buildNavigationItem(
                    icon: Icons.business_outlined,
                    activeIcon: Icons.business,
                    title: 'Company Info',
                    index: 4,
                  ),
                  _buildNavigationItem(
                    icon: Icons.payment_outlined,
                    activeIcon: Icons.payment,
                    title: 'Account & Payment',
                    index: 5,
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Divider(color: Colors.white24, thickness: 0.5),
                  ),

                  _buildLogoutItem(),
                ],
              ),
            ),

            // Footer
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Divider(color: Colors.white24, thickness: 0.5),
                  const SizedBox(height: 10),
                  Text(
                    'HireAnything Vendor',
                    style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
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
    VoidCallback? onTapOverride,
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
                  decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                )
              : null,
          onTap: onTapOverride ??
              () {
                widget.controller.changeTab(index);
                Navigator.of(context).pop(); // Close drawer
              },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          hoverColor: Colors.white.withOpacity(0.05),
          splashColor: Colors.white.withOpacity(0.1),
        ),
      );
    });
  }

  Widget _buildLogoutItem() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Icon(Icons.logout_outlined, color: Colors.red.shade400, size: 22),
        title: Text(
          'Logout',
          style: TextStyle(color: Colors.red.shade400, fontSize: 15),
        ),
        onTap: () => _showLogoutDialog(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        hoverColor: Colors.white.withOpacity(0.05),
        splashColor: Colors.white.withOpacity(0.1),
      ),
    );
  }
}