import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';

class PostWithImageContainer extends StatelessWidget {
  const PostWithImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 20.w, top: 10.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 10.w),
                  child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.cA98AB0, width: 1.5.w)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                    ImageConstants.manCommentImage,
                                  ),
                                  fit: BoxFit.contain)),
                        ),
                      )),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sara Osama',
                        style: AppStyles.textStyle(
                          color: AppColors.black,
                          weight: FontWeight.w700,
                          size: 13,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          '2m ago',
                          style: AppStyles.textStyle(
                            color: AppColors.black,
                            weight: FontWeight.w400,
                            size: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 6.h),
                  child: SizedBox(
                      width: 15.w,
                      height: 15.h,
                      child: SvgPicture.asset(
                        ImageConstants.elipsisIcon,
                        color: AppColors.cA98AB0,
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsetsDirectional.only(start: 15.w, top: 10.h, end: 25.w),
            child: Text(
              'This text is an example of text that can be replaced in the same space, this text has been generated. This text is an example of text that can be replaced in the same space',
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: AppStyles.textStyle(
                color: AppColors.black,
                size: 14,
                weight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Image.asset(ImageConstants.photoForPostImage),
          Padding(
            padding:
                EdgeInsetsDirectional.only(start: 15.w, end: 25.w, top: 20.h),
            child: Row(
              children: [
                Container(
                  width: 75.w,
                  height: 27.h,
                  decoration: BoxDecoration(
                      color: AppColors.cF7D2DC,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8.w,
                      ),
                      const Icon(
                        FontAwesomeIcons.heart,
                        color: AppColors.cD6204E,
                      ),
                      const Spacer(),
                      Text(
                        '201',
                        style: AppStyles.textStyle(
                            color: AppColors.black,
                            weight: FontWeight.w400,
                            size: 12),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 75.w,
                  height: 27.h,
                  decoration: BoxDecoration(
                      color: AppColors.cD4C4D7,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8.w,
                      ),
                      const Icon(
                        FontAwesomeIcons.comment,
                        color: AppColors.cA98AB0,
                      ),
                      const Spacer(),
                      Text(
                        '123',
                        style: AppStyles.textStyle(
                            color: AppColors.black,
                            weight: FontWeight.w400,
                            size: 12),
                      ),
                      SizedBox(
                        width: 14.w,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: SvgPicture.asset(
                      ImageConstants.paperPlaneIcon,
                      color: AppColors.cA98AB0,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            width: double.infinity,
            height: 20.h,
            color: AppColors.cF1F1F0,
          )
        ],
      ),
    );
  }
}
