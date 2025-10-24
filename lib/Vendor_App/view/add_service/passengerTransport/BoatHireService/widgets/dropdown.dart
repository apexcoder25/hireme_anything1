// import 'package:flutter/material.dart';
// import 'package:hire_any_thing/utilities/colors.dart';
// import '../utils/responsive_utils.dart';

// class ProfessionalDropdown extends StatelessWidget {
//   final String label;
//   final String? value;
//   final List<String> items;
//   final Function(String?) onChanged;
//   final bool isRequired;
//   final Widget? prefixIcon;
//   final String? helperText;
//   final bool enabled;
//   final String? Function(String?)? validator;

//   const ProfessionalDropdown({
//     Key? key,
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.isRequired = false,
//     this.prefixIcon,
//     this.helperText,
//     this.enabled = true,
//     this.validator,
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
        
//         // Dropdown Field
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
//           child: DropdownButtonFormField<String>(
//             value: value?.isEmpty == true ? null : value,
//             items: items.map((String item) {
//               return DropdownMenuItem<String>(
//                 value: item,
//                 child: Text(
//                   item,
//                   style: TextStyle(
//                     fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
//                     color: AppColors.grey900,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               );
//             }).toList(),
//             onChanged: enabled ? onChanged : null,
//             validator: validator,
//             decoration: InputDecoration(
//               prefixIcon: prefixIcon != null 
//                 ? Padding(
//                     padding: const EdgeInsets.all(12),
//                     child: prefixIcon,
//                   )
//                 : null,
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
//             dropdownColor: AppColors.white,
//             elevation: 8,
//             borderRadius: BorderRadius.circular(8),
//             style: TextStyle(
//               fontSize: ResponsiveUtils.getResponsiveFontSize(context, 14),
//               color: AppColors.grey900,
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
