import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.only(top: 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Center(
              child: ResuableText(
                  text: 'Logout',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.c242424),
            ),
            SizedBox(
              height: 9.h,
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
              child: Container(
                child: const Center(
                  child: ResuableText(
                    text:
                        'You’ll need to enter your email\n     and password next time\n            you want to login',
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.c242424,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
              width: double.infinity,
              height: 40.h,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: Colors.grey.withOpacity(.5), width: 1.5.w))),
              child: Row(
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: const Center(
                        child: ResuableText(
                          text: 'Cancel',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.kkPrimaryColor,
                        ),
                      ),
                    ),
                  )),
                  VerticalDivider(
                    color: Colors.grey.withOpacity(.5),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.clear();
                      exit(0);
                    },
                    child: Container(
                      child: const Center(
                        child: ResuableText(
                          text: 'Logout',
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppColors.cFF0000,
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
