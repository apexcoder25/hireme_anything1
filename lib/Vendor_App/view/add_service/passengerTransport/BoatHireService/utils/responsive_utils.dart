// import 'package:flutter/material.dart';

// class ResponsiveUtils {
//   // Screen size getters
//   static double getScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
//   static double getScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
  
//   // Device type detection
//   static bool isMobile(BuildContext context) => getScreenWidth(context) < 600;
//   static bool isTablet(BuildContext context) => getScreenWidth(context) >= 600 && getScreenWidth(context) < 1024;
//   static bool isDesktop(BuildContext context) => getScreenWidth(context) >= 1024;
  
//   // Responsive padding
//   static double getResponsivePadding(BuildContext context) {
//     if (isMobile(context)) return 16.0;
//     if (isTablet(context)) return 24.0;
//     return 32.0;
//   }
  
//   // Responsive font sizing
//   static double getResponsiveFontSize(BuildContext context, double baseFontSize) {
//     final screenWidth = getScreenWidth(context);
//     if (screenWidth < 360) return baseFontSize * 0.9;
//     if (screenWidth > 500) return baseFontSize * 1.1;
//     return baseFontSize;
//   }
  
//   // Responsive spacing
//   static double getResponsiveSpacing(BuildContext context, double baseSpacing) {
//     if (isMobile(context)) return baseSpacing;
//     if (isTablet(context)) return baseSpacing * 1.2;
//     return baseSpacing * 1.5;
//   }
  
//   // Responsive margins
//   static EdgeInsets getResponsiveMargin(BuildContext context) {
//     final padding = getResponsivePadding(context);
//     return EdgeInsets.all(padding);
//   }
  
//   // Responsive button height
//   static double getButtonHeight(BuildContext context) {
//     if (isMobile(context)) return 48.0;
//     if (isTablet(context)) return 52.0;
//     return 56.0;
//   }
  
//   // Responsive container constraints
//   static BoxConstraints getResponsiveConstraints(BuildContext context) {
//     final screenWidth = getScreenWidth(context);
//     if (screenWidth > 1200) {
//       return const BoxConstraints(maxWidth: 1000);
//     }
//     return BoxConstraints(maxWidth: screenWidth * 0.95);
//   }
// }
