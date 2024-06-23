import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/api/api_endPoints.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/data/models/comments_model/comments_data.dart';
import 'package:graduation/features/community/presentation/widgets/delete_comment_widget.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:graduation/features/community/presentation/widgets/update_comment_widget.dart';

import '../../../../core/utils/fontweight_helper.dart';

class CommentContainer extends StatelessWidget {
  const CommentContainer({super.key, this.commentData, required this.postId});

  final CommentData? commentData;

  final num postId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCommunityCubit, GlobalCommunityState>(
      builder: (context, state) {
        final communityCubit = BlocProvider.of<GlobalCommunityCubit>(context);
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: commentData!.user!.profilePicture != null
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                commentData!.user!.profilePicture),
                            fit: BoxFit.contain)
                        : const DecorationImage(
                            image: AssetImage(
                                ImageConstants.userProfileDefaultImage),
                            fit: BoxFit.contain)),
              ),
              SizedBox(
                width: 8.w,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          commentData!.user!.displayName!,
                          style: AppStyles.textStyle(
                            color: AppColors.c141619,
                            weight: FontWeight.w700,
                            size: 13,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            top: 5.h,
                          ),
                          child: Text(
                            commentData!.commentContent!,
                            style: AppStyles.textStyle(
                              color: AppColors.c141619,
                              size: 14,
                              weight: FontWeightHelper.regular,
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsetsDirectional.only(top: 5.h),
                            child: ResuableText(
                              text:
                                  '${getTimeDifference(postDate: DateTime.parse(commentData!.createdAt!))}',
                              fontSize: 10,
                              color: AppColors.c677583,
                              fontWeight: FontWeightHelper.regular,
                            ))
                      ],
                    ),
                    const Spacer(),
                    CacheHelper().getData(key: ApiKeys.id) ==
                            commentData!.user!.id
                        ? GestureDetector(
                            onTap: () {
                              showCommentFirstDialouge(context, communityCubit);
                            },
                            child: SizedBox(
                                width: 15.w,
                                height: 15.h,
                                child: SvgPicture.asset(
                                  ImageConstants.elipsisIcon,
                                  color: AppColors.kkPrimaryColor,
                                )),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> showCommentFirstDialouge(
      BuildContext context, GlobalCommunityCubit communityCubit) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          contentPadding: EdgeInsetsDirectional.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15.h,
              ),
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    updateCommentFun(context, communityCubit);
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
                            color: AppColors.white,
                          ),
                          child: Center(
                              child: Icon(
                            Icons.update,
                            color: AppColors.kkPrimaryColor,
                            size: 25.sp,
                          ))),
                      SizedBox(
                        width: 10.w,
                      ),
                      const ResuableText(
                        text: 'Modify Comment',
                        color: AppColors.kkPrimaryColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: 10.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  deleteCommentFun(context, communityCubit);
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
                          color: AppColors.white,
                        ),
                        child: Center(
                            child: Icon(
                          Icons.delete_outline,
                          color: AppColors.kkPrimaryColor,
                          size: 25.sp,
                        ))),
                    SizedBox(
                      width: 10.w,
                    ),
                    const ResuableText(
                      color: AppColors.kkPrimaryColor,
                      text: 'Delete Comment',
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
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
      },
    );
  }

  Future<dynamic> deleteCommentFun(
      BuildContext context, GlobalCommunityCubit communityCubit) {
    return showDialog(
      context: context,
      builder: (context) {
        return DeleteCommentWidget(commentData: commentData, postId: postId);
      },
    );
  }

  Future<dynamic> updateCommentFun(
      BuildContext context, GlobalCommunityCubit communityCubit) {
    return showDialog(
      context: context,
      builder: (context) {
        return UpdateCommentWidget(commentData: commentData, postId: postId);
      },
    );
  }
}
