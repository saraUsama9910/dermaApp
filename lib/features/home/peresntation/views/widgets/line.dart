import 'package:flutter/material.dart';
import 'package:graduation/core/utils/app_colors.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: AppColors.kBlueColor,
    );
  }
}
