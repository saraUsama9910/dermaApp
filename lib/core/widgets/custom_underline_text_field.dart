import 'package:flutter/material.dart';
import 'package:graduation/core/utils/app_colors.dart';

class CustomUnderlineTextField extends StatelessWidget {
  const CustomUnderlineTextField({
    super.key,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.hasSuffixIcon = false,
    this.labelText,
    this.hasLabelText = false,
    this.labelStyle,
    this.suffixOnTap,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;
  final bool hasSuffixIcon;
  final String? labelText;
  final bool hasLabelText;
  final TextStyle? labelStyle;
  final void Function()? suffixOnTap;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(),
          suffixIcon: hasSuffixIcon
              ? GestureDetector(
                  onTap: suffixOnTap,
                  child: Icon(
                    suffixIcon ?? Icons.check,
                    color: AppColors.kGreyColor,
                  ),
                )
              : null,
          label: hasLabelText
              ? Text(
                  labelText!,
                  style: labelStyle ??
                      const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.kBlueColor,
                      ),
                )
              : null),
    );
  }
}
