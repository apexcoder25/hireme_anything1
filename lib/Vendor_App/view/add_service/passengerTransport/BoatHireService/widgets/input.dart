// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:hire_any_thing/utilities/colors.dart';
// import '../utils/responsive_utils.dart';

// class ProfessionalInput extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final String hintText;
//   final bool isRequired;
//   final int maxLines;
//   final TextInputType keyboardType;
//   final Widget? prefixIcon;
//   final Widget? suffixIcon;
//   final String? helperText;
//   final List<TextInputFormatter>? inputFormatters;
//   final String? Function(String?)? validator;
//   final bool enabled;
//   final VoidCallback? onTap;
//   final bool readOnly;

//   const ProfessionalInput({
//     Key? key,
//     required this.label,
//     required this.controller,
//     required this.hintText,
//     this.isRequired = false,
//     this.maxLines = 1,
//     this.keyboardType = TextInputType.text,
//     this.prefixIcon,
//     this.suffixIcon,
//     this.helperText,
//     this.inputFormatters,
//     this.validator,
//     this.enabled = true,
//     this.onTap,
//     this.readOnly = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Label
//         Padding(
//           padding: const EdgeInsets.only(bottom: 6),
//           child: RichText(
//             text: TextSpan(
//               style: TextStyle(
//                 fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
//                 fontWeight: FontWeight.w500,
//                 color: enabled ? AppColors.grey900 : AppColors.grey500,
//               ),
//               children: [
//                 TextSpan(text: label),
//                 if (isRequired)
//                   const TextSpan(
//                     text: ' *',
//                     style: TextStyle(
//                       color: AppColors.error,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
        
//         // Input Field
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8),
//             boxShadow: [
//               BoxShadow(
//                 color: AppColors.grey300.withOpacity(0.2),
//                 blurRadius: 4,
//                 offset: const Offset(0, 1),
//               ),
//             ],
//           ),
//           child: TextFormField(
//             controller: controller,
//             keyboardType: keyboardType,
//             maxLines: maxLines,
//             inputFormatters: inputFormatters,
//             validator: validator,
//             enabled: enabled,
//             readOnly: readOnly,
//             onTap: onTap,
//             style: TextStyle(
//               fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
//               color: enabled ? AppColors.grey900 : AppColors.grey500,
//               fontWeight: FontWeight.w400,
//             ),
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(
//                 color: AppColors.grey500,
//                 fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
//               ),
//               prefixIcon: prefixIcon != null 
//                 ? Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: prefixIcon,
//                   )
//                 : null,
//               suffixIcon: suffixIcon,
//               filled: true,
//               fillColor: enabled ? AppColors.white : AppColors.grey100,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppColors.grey300),
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppColors.grey300),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppColors.btnColor, width: 2),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppColors.error),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppColors.error, width: 2),
//               ),
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide(color: AppColors.grey200),
//               ),
//               contentPadding: EdgeInsets.all(
//                 ResponsiveUtils.isMobile(context) ? 12 : 16,
//               ),
//             ),
//           ),
//         ),
        
//         // Helper Text
//         if (helperText != null)
//           Padding(
//             padding: const EdgeInsets.only(top: 4, left: 2),
//             child: Text(
//               helperText!,
//               style: TextStyle(
//                 fontSize: ResponsiveUtils.getResponsiveFontSize(context, 11),
//                 color: AppColors.grey600,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }
