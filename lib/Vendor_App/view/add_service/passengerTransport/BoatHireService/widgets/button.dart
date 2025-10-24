// import 'package:flutter/material.dart';
// import 'package:hire_any_thing/utilities/colors.dart';
// import '../utils/responsive_utils.dart';

// class ProfessionalButton extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed;
//   final bool isLoading;
//   final bool isOutlined;
//   final Color? backgroundColor;
//   final Color? textColor;
//   final Widget? icon;
//   final double? width;
//   final double? height;
//   final bool isExpanded;
//   final EdgeInsets? padding;
//   final double? borderRadius;

//   const ProfessionalButton({
//     Key? key,
//     required this.text,
//     this.onPressed,
//     this.isLoading = false,
//     this.isOutlined = false,
//     this.backgroundColor,
//     this.textColor,
//     this.icon,
//     this.width,
//     this.height,
//     this.isExpanded = true,
//     this.padding,
//     this.borderRadius,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final buttonHeight = height ?? ResponsiveUtils.getButtonHeight(context);
//     final buttonColor = backgroundColor ?? AppColors.btnColor;
//     final buttonTextColor = textColor ?? (isOutlined ? AppColors.grey700 : AppColors.white);
//     final borderColor = isOutlined ? AppColors.grey400 : buttonColor;
    
//     return Container(
//       width: isExpanded ? double.infinity : width,
//       height: buttonHeight,
//       decoration: BoxDecoration(
//         gradient: isOutlined || isLoading || onPressed == null
//             ? null
//             : LinearGradient(
//                 colors: [buttonColor, buttonColor.withOpacity(0.9)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//         color: isOutlined ? AppColors.white : (onPressed == null ? AppColors.grey300 : null),
//         border: Border.all(
//           color: onPressed == null ? AppColors.grey300 : borderColor,
//           width: isOutlined ? 1.5 : 1,
//         ),
//         borderRadius: BorderRadius.circular(borderRadius ?? 8),
//         boxShadow: isOutlined || isLoading || onPressed == null
//             ? null
//             : [
//                 BoxShadow(
//                   color: buttonColor.withOpacity(0.3),
//                   blurRadius: 6,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: isLoading ? null : onPressed,
//           borderRadius: BorderRadius.circular(borderRadius ?? 8),
//           child: Container(
//             padding: padding ?? EdgeInsets.symmetric(
//               horizontal: ResponsiveUtils.isMobile(context) ? 12 : 16,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (isLoading)
//                   SizedBox(
//                     width: 16,
//                     height: 16,
//                     child: CircularProgressIndicator(
//                       strokeWidth: 2,
//                       valueColor: AlwaysStoppedAnimation<Color>(buttonTextColor),
//                     ),
//                   )
//                 else if (icon != null) ...[
//                   icon!,
//                   const SizedBox(width: 8),
//                 ],
//                 if (!isLoading)
//                   Flexible(
//                     child: Text(
//                       text,
//                       style: TextStyle(
//                         fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
//                         fontWeight: FontWeight.w500,
//                         color: onPressed == null ? AppColors.grey500 : buttonTextColor,
//                         letterSpacing: 0.3,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
