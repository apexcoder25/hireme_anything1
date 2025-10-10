import 'package:flutter/material.dart';

class VendorAuthLogo extends StatelessWidget {
  final double height;
  final String? customText;

  const VendorAuthLogo({
    super.key,
    this.height = 80,
    this.customText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 800),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Image.asset(
                "assets/app_logo/hireme_anything_logo.png",
                height: height,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: height,
                    width: height,
                    decoration: BoxDecoration(
                      color: const Color(0xff0e53ce),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.business,
                      color: Colors.white,
                      size: 40,
                    ),
                  );
                },
              ),
            );
          },
        ),
        
      ],
    );
  }
}
