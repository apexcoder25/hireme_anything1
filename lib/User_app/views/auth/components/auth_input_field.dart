import 'package:flutter/material.dart';
import 'package:hire_any_thing/utilities/colors.dart';

class AuthInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLength;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const AuthInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    required this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.onChanged,
    this.validator,
  });

  static final BoxDecoration _inputFieldDecoration = BoxDecoration(
    color: AppColors.surfaceLight,
    borderRadius: BorderRadius.circular(12),
    border: const Border.fromBorderSide(
      BorderSide(color: AppColors.borderLight),
    ),
  );

  static const TextStyle _inputTextStyle = TextStyle(
    fontSize: 15,
    color: AppColors.textPrimary,
  );

  static const TextStyle _hintTextStyle = TextStyle(color: AppColors.textLight);

  static const TextStyle _labelStyle = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(labelText!, style: _labelStyle),
          const SizedBox(height: 10),
        ],
        DecoratedBox(
          decoration: _inputFieldDecoration,
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            style: _inputTextStyle,
            maxLength: maxLength,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: _hintTextStyle,
              prefixIcon: Icon(prefixIcon, color: AppColors.textLight),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(18),
              counterText: "",
            ),
          ),
        ),
      ],
    );
  }
}
