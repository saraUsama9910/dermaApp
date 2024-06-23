import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';

class HiHome extends StatelessWidget {
  const HiHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.kkPrimaryColor]),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom:500,
          top: 0,
        ),
        child: Row(
          children: [
            AspectRatio(
              aspectRatio:6/6,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImageConstants.welcome),
                  ),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 50, bottom: 5),
              child: Text(
                " Hi!",
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 30.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
