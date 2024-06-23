import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';

class ResuableText extends StatelessWidget {
  const ResuableText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textDecoration,
      this.maxLines,
      this.textOverflow,
      this.onTap});

  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: textOverflow,
        style: AppStyles.textStyle(
            decoration: textDecoration,
            color: color ?? AppColors.black,
            size: (fontSize ?? 15).sp,
            weight: fontWeight ?? FontWeight.w400),
      ),
    );
  }
}
