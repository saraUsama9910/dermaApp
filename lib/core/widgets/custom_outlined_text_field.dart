import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';

class CustomOutlinedTextField extends StatelessWidget {
  final String? hintText;
  final TextStyle? hintStyle;

  final double? height;
  final Color? crusorColor;
  final bool obsecureText;
  final TextEditingController controller;
  final double? borderRadius;
  final Color? textFieldColor;
  final bool hasPrefixIcon;
  final bool hasSuffixIcon;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final Color? borderSideColor;
  final void Function(String)? onFieldSubmitte;
  final String? Function(String?)? validator;
  final void Function()? suffixIconOnTap;
  final double? contentTopPadding;
  final double? contentBottomPadding;

  const CustomOutlinedTextField(
      {super.key,
      required this.controller,
      this.hintText,
      this.hintStyle,
      this.height,
      this.crusorColor,
      this.obsecureText = false,
      this.borderRadius,
      this.textFieldColor,
      this.hasPrefixIcon = false,
      this.hasSuffixIcon = false,
      this.prefixIcon,
      this.suffixIcon,
      this.inputFormatters,
      required this.keyboardType,
      this.borderSideColor,
      this.onFieldSubmitte,
      this.validator,
      this.suffixIconOnTap,
      this.contentTopPadding,
      this.contentBottomPadding});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onFieldSubmitted: onFieldSubmitte,
      controller: controller,
      cursorColor: crusorColor ?? AppColors.black,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      obscureText: obsecureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsetsDirectional.only(
            top: (contentTopPadding ?? 0).h,
            bottom: (contentBottomPadding ?? 5).h,
            start: 10.h),
        prefixIcon: hasPrefixIcon ? Icon(prefixIcon) : null,
        suffixIcon: hasSuffixIcon
            ? GestureDetector(onTap: suffixIconOnTap, child: Icon(suffixIcon))
            : null,
        hintText: hintText,
        hintStyle: hintStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular((borderRadius ?? 8).r),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular((borderRadius ?? 8).r),
            borderSide: BorderSide(
                color: borderSideColor ?? AppColors.cEFEFEF, width: 1.2.w)),
      ),
    );
  }
}
