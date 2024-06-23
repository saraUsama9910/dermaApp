


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/fontweight_helper.dart';
import '../../../../core/widgets/resuable_text.dart';
import '../../data/models/comments_model/comments_data.dart';

class UpdateCommentWidget extends StatelessWidget {
  const UpdateCommentWidget({
    super.key,
    required this.commentData,
    required this.postId,
  });

  final CommentData? commentData;
  final num postId;

  @override
  Widget build(BuildContext context) {
    final communityCubit = BlocProvider.of<GlobalCommunityCubit>(context);
    return AlertDialog(
        contentPadding: EdgeInsetsDirectional.only(bottom: 20.h),
        actionsPadding: EdgeInsetsDirectional.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
        ),
        content: Padding(
          padding: EdgeInsetsDirectional.only(top: 10.h, start: 10.h,end: 10.w),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ResuableText(
                  text: 'Update This Comment',
                  color: AppColors.c383940,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                SizedBox(
                  height: 10.h,
                ),
                const ResuableText(
                  text: 'add your new comment',
                  color: AppColors.c677583,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  controller: communityCubit.updateCommentControllerForPostDetailsScreen,
                  cursorColor: AppColors.kkPrimaryColor,
                  decoration:
                  const InputDecoration(
                    contentPadding: EdgeInsetsDirectional.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(
                        color: AppColors.kkPrimaryColor,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                      BorderSide(
                        color: AppColors.kkPrimaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ResuableText(
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                      fontSize: 13,
                      fontWeight: FontWeightHelper.regular,
                      color: AppColors.c141619,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ResuableText(
                      onTap: () async {
                        await communityCubit.updateComment(
                            newContent: communityCubit
                                .updateCommentControllerForPostDetailsScreen
                                .text,
                            commentId: commentData!.id!);
                        communityCubit.updateCommentController.clear();
                        await communityCubit.getCommentsForPost(postId: postId);
                        Navigator.pop(context);
                      },
                      text: 'Update',
                      color: AppColors.kkPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ],
                )
              ]),
        ));
  }
}