import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';

class Container1 extends StatelessWidget {
  const Container1({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children:
        [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                height: 100.h,
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(32)),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.kkPrimaryColor
                      ],
                    )),
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 4 / 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 2, top: 5),
                        child: Container(
                          // height: MediaQuery.of(context).size.height * .3,
                          // width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(ImageConstants.uploadImage2),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 20.w),
                      child: Text(
                        'Upload Skin Photo',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Upload Your Skin Photo,Please',
            style: TextStyle(color: AppColors.primaryColor, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }
}
