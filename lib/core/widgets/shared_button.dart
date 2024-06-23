import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';

class SharedButton extends StatelessWidget {
  final String btnText;
  final Color? textcolor;
  final double? height;
  final TextStyle? btnTextStyle;
  final Color? buttonColor;
  final void Function() onPressed;
  final bool hasBorderRadius;
  final double? borderRadiusValue;
  final double? width;
  final bool hasBorder;

  const SharedButton({
    super.key,
    required this.btnText,
    this.textcolor,
    required this.onPressed,
    this.height,
    this.btnTextStyle,
    this.buttonColor,
    this.hasBorderRadius = false,
    this.borderRadiusValue,
    this.width,
    this.hasBorder = false,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width ?? 150.w),
      height: (height ?? 30.h),
      decoration: BoxDecoration(
        border: hasBorder
            ? Border.all(
                color: AppColors.kkPrimaryColor,
              )
            : null,
        borderRadius:
            hasBorderRadius ? BorderRadius.circular(borderRadiusValue!) : null,
        color: buttonColor ?? AppColors.kkPrimaryColor,
      ),
      child: MaterialButton(
          onPressed: onPressed,
          child: Center(
            child: Text(btnText, style: btnTextStyle ?? AppStyles.textStyle()),
          )),
    );
  }
}
