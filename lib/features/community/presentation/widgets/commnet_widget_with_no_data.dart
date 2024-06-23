import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:shimmer/shimmer.dart';

class CommentWidgetWithNoData extends StatelessWidget {
  const CommentWidgetWithNoData({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.white,
            highlightColor: AppColors.cCAB4CF,
            child: Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.cA98AB0, width: 1.5.w)),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://avatars.githubusercontent.com/u/150288890?v=4'),
                            fit: BoxFit.contain)),
                  ),
                )),
          ),
          SizedBox(
            width: 8.w,
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 8.h),
            child: SizedBox(
              width: 220.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: AppColors.white,
                    highlightColor: AppColors.cCAB4CF,
                    child: Text(
                      'Owner_Name',
                      style: AppStyles.textStyle(
                        color: AppColors.black,
                        weight: FontWeight.w700,
                        size: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(top: 5.h),
                    child: Shimmer.fromColors(
                      baseColor: AppColors.white,
                      highlightColor: AppColors.cCAB4CF,
                      child: Text(
                        'This text is an example of text that can be replaced in the same space. This text has been generated. This text is an example of text that can be replaced in the same space.',
                        style: AppStyles.textStyle(
                          color: AppColors.black,
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsetsDirectional.only(top: 5.h),
                      child: Shimmer.fromColors(
                        baseColor: AppColors.white,
                        highlightColor: AppColors.cCAB4CF,
                        child: const ResuableText(
                          text: '2 h',
                          fontSize: 10,
                          color: AppColors.cC4C4C4,
                        ),
                      ))
                ],
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsetsDirectional.only(top: 10.h),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.white,
                  highlightColor: AppColors.cCAB4CF,
                  child: Icon(
                    FontAwesomeIcons.heart,
                    color: AppColors.cA98AB0,
                    size: 18.sp,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Shimmer.fromColors(
                  baseColor: AppColors.white,
                  highlightColor: AppColors.cCAB4CF,
                  child: const ResuableText(
                    text: '1999',
                    fontSize: 10,
                    color: AppColors.c515258,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 10.h),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const showBigDialougForComment();
                        },
                      );
                    },
                    child: SizedBox(
                        width: 15.w,
                        height: 15.h,
                        child: SvgPicture.asset(
                          ImageConstants.elipsisIcon,
                          color: AppColors.cA98AB0,
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class showBigDialougForComment extends StatelessWidget {
  const showBigDialougForComment({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cD4C4D7,
      contentPadding: EdgeInsetsDirectional.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15.h,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cA98AB0,
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.update,
                      color: AppColors.white,
                    ))),
                SizedBox(
                  width: 10.w,
                ),
                const ResuableText(
                  text: 'Modify Comment',
                  color: AppColors.white,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsetsDirectional.only(
                        start: 15, end: 15, top: 5, bottom: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r)),
                    actionsPadding: EdgeInsetsDirectional.zero,
                    title: const Center(
                      child: ResuableText(
                        text: 'Delete Comment',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: const ResuableText(
                        fontSize: 14,
                        text:
                            'Are you sure you want to permanently remove this comment from App?'),
                    actions: [
                      Column(
                        children: [
                          const LineWidget(
                            color: AppColors.c808080,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                      color: AppColors.c808080,
                                      width: 1.w,
                                    ))),
                                    child: const Center(
                                      child: ResuableText(
                                        text: 'Cancel',
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.cA98AB0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    height: 40.h,
                                    decoration: const BoxDecoration(),
                                    child: const Center(
                                      child: ResuableText(text: 'Delete'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  );
                },
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Container(
                    width: 30.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cA98AB0,
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.delete_outline,
                      color: AppColors.white,
                    ))),
                SizedBox(
                  width: 10.w,
                ),
                const ResuableText(
                  color: AppColors.white,
                  text: 'Delete Comment',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }
}
