import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class HiSignup extends StatelessWidget {
  const HiSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.kkPrimaryColor]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 70.0, left: 22),
        child: Text(
          'Create Your\nAccount',
          style: TextStyle(
              fontSize: 30.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
