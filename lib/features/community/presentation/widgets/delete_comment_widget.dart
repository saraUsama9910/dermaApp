

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/fontweight_helper.dart';

import '../../../../core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/resuable_text.dart';
import '../../data/models/comments_model/comments_data.dart';
import 'line_widget.dart';

class DeleteCommentWidget extends StatelessWidget {
  const DeleteCommentWidget({
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
      backgroundColor: AppColors.white,
      contentPadding: EdgeInsetsDirectional.only(start: 10.w, end: 10.w,top:5.h,bottom: 15.h),
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      actionsPadding: EdgeInsetsDirectional.zero,
      titlePadding: EdgeInsetsDirectional.only(top: 25),
      title:  Center(
        child: ResuableText(
          text: 'Delete Comment',
          fontWeight: FontWeight.bold,
          color: AppColors.c141619,
        ),
      ),
      content: const ResuableText(
        fontSize: 14,
        text: 'Are you sure you want to permanently remove this comment from App?',
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
                    onTap: ()
                    {
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
                          color: AppColors.kkPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () async
                    {
                       communityCubit.deleteComment(
                          commentId: commentData!.id!);
                       await communityCubit.getCommentsForPost(postId: postId);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40.h,
                      decoration: const BoxDecoration(),
                      child: const Center(
                        child: ResuableText(
                          text: 'Delete',
                          fontSize: 15,
                          fontWeight: FontWeightHelper.regular,
                          color: AppColors.c141619,
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
