import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hire_any_thing/Vendor_App/view/add_service/passengerTransport/image_controller.dart';
import 'package:hire_any_thing/Vendor_App/view/profile_page/components/editable_avatar.dart';
import 'package:hire_any_thing/data/models/vender_side_model/profile_model.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileModel profile;
  final bool isEditing;
  final ImageController imgController;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.isEditing,
    required this.imgController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: SafeArea(
        bottom: false, // Allow content to go under bottom curve
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 24), // Reduced bottom padding
          child: Column(
            mainAxisSize: MainAxisSize.min, // Critical: Don't expand unnecessarily
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => EditableAvatar(
                    imageUrl: imgController.vendorImage.value,
                    isEditing: isEditing,
                  )),
              const SizedBox(height: 12),
              Flexible( // Prevents overflow when content grows
                child: _buildBasicInfo(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          profile.name.isNotEmpty ? profile.name : "Vendor Profile",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        const SizedBox(height: 12),
        if (profile.email.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.email_outlined, size: 16, color: Colors.grey.shade600),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    profile.email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}