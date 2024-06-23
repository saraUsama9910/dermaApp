
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/resuable_text.dart';

class NoPostsWidget extends StatelessWidget {
  const NoPostsWidget({
    super.key,this.widgetTitle,
  });


  final String? widgetTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:  EdgeInsetsDirectional.only(top: 30.h),
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: AppColors.kkPrimaryColor,
                  width: 2.w
              ),

            ),
            child: Icon(Icons.camera_alt_outlined,
              color: AppColors.kkPrimaryColor,size: 40.sp,),

          ),
        ),
        SizedBox(height: 20.h,),
        ResuableText(
          text: widgetTitle??'No Posts Yet',
          color: AppColors.kkPrimaryColor,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        )
      ],);
  }
}
