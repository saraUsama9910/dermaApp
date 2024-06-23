



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';

import '../../../../core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import '../../../../core/utils/fontweight_helper.dart';
import '../../../../core/widgets/resuable_text.dart';
import '../../data/models/get_all_posts_model/Data.dart';

class DeletePostWidget extends StatelessWidget {
  const DeletePostWidget({
    super.key,
    required this.getPostData,
  });

  final AllPostsData? getPostData;

  @override
  Widget build(BuildContext context) {
    final communityCubit = BlocProvider.of<GlobalCommunityCubit>(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      titlePadding: EdgeInsetsDirectional.only(top: 20.h),
      contentPadding: EdgeInsetsDirectional.only(start: 10.w,top:10.h,bottom: 15.h,end: 10.w),
      actionsPadding: EdgeInsetsDirectional.zero,
      title: const Center(
        child: ResuableText(
          text: 'Delete this post?',
          fontWeight: FontWeight.bold,
          color: AppColors.c141619,
        ),
      ),
      content: const ResuableText(
          text: 'Items that are deleted you will not\nbe able to recover it.\nAre you sure you want to continue?',
        fontWeight: FontWeightHelper.regular,
        color: AppColors.c677583,

      ),
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
                    onTap: () async
                    {
                      await communityCubit.deletePost(
                          postId: getPostData!.id!);
                      communityCubit.getAllPosts();
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
                          text: 'Delete',
                          fontWeight: FontWeightHelper.regular,
                          color: AppColors.c141619,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: ()
                    {
                      Navigator.pop(context);

                    },
                    child: Container(
                      height: 40.h,
                      decoration: const BoxDecoration(),
                      child: const Center(
                        child: ResuableText(
                          text: 'Cancel',
                          fontWeight: FontWeight.bold,
                          color: AppColors.kkPrimaryColor,
                        ),
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
  }
}
