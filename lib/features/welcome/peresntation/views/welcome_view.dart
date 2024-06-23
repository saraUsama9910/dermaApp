import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/routes/routes.dart';

import '../../../../core/utils/app_colors.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.white,
              AppColors.white,
            ],
          ),
        ),
        child: Column(children: [
          const Spacer(),
          const Image(
            image: AssetImage('assets/images/welcome.png'),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            'Welcome',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.sp,
              color: AppColors.kBlueColor,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.kLoginView);
            },
            child: Container(
              height: 50.h,
              width: 320.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Center(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kBlueColor),
                ),
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.kSignupView);
            },
            child: Container(
              height: 50.h,
              width: 320.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [AppColors.primaryColor, AppColors.kkPrimaryColor]),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          )
        ]),
      ),
    );
  }
}
