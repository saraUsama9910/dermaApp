import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_colors.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem(
      {super.key, required this.isSelected, required this.icon});

  final IconData icon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.w,
      height: 30.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: isSelected == true ? AppColors.cD9D9D9 : AppColors.white,
      ),
      child: Icon(
        icon,
        size: 35,
        color: AppColors.primaryColor,
      ),
    );
  }
}
