
// import 'package:flutter/material.dart';
// import 'package:hire_any_thing/utilities/colors.dart';
// import '../utils/responsive_utils.dart';

// class ProfessionalProgressBar extends StatelessWidget {
//   final int currentStep;
//   final int totalSteps;
//   final String stepTitle;
//   final Set<int> completedSteps;

//   const ProfessionalProgressBar({
//     Key? key,
//     required this.currentStep,
//     required this.totalSteps,
//     required this.stepTitle,
//     this.completedSteps = const {},
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final padding = ResponsiveUtils.getResponsivePadding(context);
    
//     return Container(
//       width: double.infinity,
//       color: AppColors.white,
//       child: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(padding),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
              
//               Row(
//                 children: [
                  
//                   Container(
//                     width: 36,
//                     height: 36,
//                     decoration: BoxDecoration(
//                       color: AppColors.btnColor,
//                       borderRadius: BorderRadius.circular(8),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.btnColor.withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back_sharp,
//                       color: AppColors.white,
//                       size: 20,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
                  
//                   // Title Section
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Boat Hire Form',
//                           style: TextStyle(
//                             fontSize: ResponsiveUtils.getResponsiveFontSize(context, 20),
//                             fontWeight: FontWeight.w600,
//                             color: AppColors.grey900,
//                             letterSpacing: -0.2,
//                           ),
//                         ),
//                         const SizedBox(height: 2),
//                         Text(
//                           'Step $currentStep of $totalSteps: $stepTitle',
//                           style: TextStyle(
//                             fontSize: ResponsiveUtils.getResponsiveFontSize(context, 13),
//                             color: AppColors.grey600,
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 8),
//                 ],
//               ),
              
//               const SizedBox(height: 16),
              
//               // Progress Section
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Progress Text
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         '${((currentStep / totalSteps) * 100).toInt()}% Complete',
//                         style: TextStyle(
//                           fontSize: ResponsiveUtils.getResponsiveFontSize(context, 11),
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.grey600,
//                         ),
//                       ),
//                       Text(
//                         '$currentStep/$totalSteps',
//                         style: TextStyle(
//                           fontSize: ResponsiveUtils.getResponsiveFontSize(context, 11),
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.primaryDark,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
                  
//                   // Progress Bar
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(4),
//                       child: LinearProgressIndicator(
//                         value: currentStep / totalSteps,
//                         backgroundColor: AppColors.grey200,
//                         valueColor: AlwaysStoppedAnimation<Color>(AppColors.btnColor),
//                         minHeight: 6,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
