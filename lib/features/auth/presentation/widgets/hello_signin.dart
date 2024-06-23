import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class HelloSignin extends StatelessWidget {
  const HelloSignin({super.key});

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
        padding: const EdgeInsets.only(top: 60, left: 22),
        child: Text(
          'Hello\nSign in!',
          style: TextStyle(
              fontSize: 30.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
