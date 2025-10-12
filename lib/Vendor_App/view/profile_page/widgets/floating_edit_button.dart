import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class FloatingEditButton extends StatelessWidget {
  final bool isEditing;
  final Animation<double> animation;
  final VoidCallback onToggle;

  const FloatingEditButton({
    super.key,
    required this.isEditing,
    required this.animation,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: FloatingActionButton.extended(
            onPressed: onToggle,
            backgroundColor: isEditing ? Colors.green.shade600 : AppColors.btnColor,
            foregroundColor: Colors.white,
            elevation: 12,
            heroTag: "edit_profile",
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isEditing ? Icons.save_outlined : Icons.edit_outlined,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  isEditing ? 'Save Profile' : 'Edit Profile',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
