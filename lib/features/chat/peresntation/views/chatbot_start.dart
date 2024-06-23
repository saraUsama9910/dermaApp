import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/routes/routes.dart';

import '../../../../core/utils/app_colors.dart';

// ignore: camel_case_types
class chatbotStartView extends StatelessWidget {
  const chatbotStartView({Key? key}) : super(key: key);

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
          const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Image(
              image: AssetImage('assets/images/chatbot.png'),
            ),
          ),
          Text(
            'Start With Chat-Bot',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.sp,
              color: AppColors.kBlueColor,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.kChatbotView);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                height: 53.h,
                width: 320.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [
                    AppColors.primaryColor,
                    AppColors.kkPrimaryColor
                  ]),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
