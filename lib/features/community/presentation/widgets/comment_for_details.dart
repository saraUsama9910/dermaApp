import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/data/models/get_all_posts_model/Comments.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';

import '../../../../core/utils/fontweight_helper.dart';

class CommentContainerForDetails extends StatelessWidget {
  const CommentContainerForDetails(
      {super.key, this.commentData, required this.postId});

  final AllPostsComments? commentData;

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
                                commentData!.user!.profilePicture!),
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
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.kkPrimaryColor,
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
                                              editCommentDialouge(
                                                  context, communityCubit);
                                            },
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Container(
                                                    width: 30.w,
                                                    height: 30.h,
                                                    decoration:
                                                        const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors
                                                          .kkPrimaryColor,
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
                                          );
                                        }),
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
                                                  backgroundColor:
                                                      AppColors.white,
                                                  contentPadding:
                                                      const EdgeInsetsDirectional
                                                          .only(
                                                          start: 15,
                                                          end: 15,
                                                          top: 5,
                                                          bottom: 15),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r)),
                                                  actionsPadding:
                                                      EdgeInsetsDirectional
                                                          .zero,
                                                  title: const Center(
                                                    child: ResuableText(
                                                      text: 'Delete Comment',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                  content: const ResuableText(
                                                    fontSize: 14,
                                                    text:
                                                        'Are you sure you want to permanently remove this comment from App?',
                                                  ),
                                                  actions: [
                                                    Column(
                                                      children: [
                                                        const LineWidget(
                                                          color:
                                                              AppColors.c808080,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40.h,
                                                                  decoration: BoxDecoration(
                                                                      border: Border(
                                                                          right: BorderSide(
                                                                    color: AppColors
                                                                        .c808080,
                                                                    width: 1.w,
                                                                  ))),
                                                                  child:
                                                                      const Center(
                                                                    child:
                                                                        ResuableText(
                                                                      text:
                                                                          'Cancel',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: AppColors
                                                                          .kkPrimaryColor,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await communityCubit.deleteComment(
                                                                      commentId:
                                                                          commentData!
                                                                              .id!);
                                                                  await communityCubit
                                                                      .getCommentsForPost(
                                                                          postId:
                                                                              postId);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: 40.h,
                                                                  decoration:
                                                                      const BoxDecoration(),
                                                                  child:
                                                                      const Center(
                                                                    child:
                                                                        ResuableText(
                                                                      text:
                                                                          'Delete',
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
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors
                                                        .kkPrimaryColor,
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
                                },
                              );
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

  Future<dynamic> editCommentDialouge(
      BuildContext context, GlobalCommunityCubit communityCubit) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            contentPadding: EdgeInsetsDirectional.only(bottom: 25.h),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
            actionsPadding: EdgeInsetsDirectional.zero,
            content: Padding(
              padding: EdgeInsetsDirectional.only(top: 10.h, start: 10.h),
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
                      color: AppColors.c6A6A70,
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 10.w),
                      child: TextFormField(
                        controller: communityCubit
                            .updateCommentControllerForPostDetailsScreen,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsetsDirectional.zero,
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.cA98AB0,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.cA98AB0,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.kkPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ResuableText(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            text: 'Cancel',
                            fontSize: 13,
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
                              await communityCubit.getCommentsForPost(
                                  postId: postId);
                              Navigator.pop(context);
                            },
                            text: 'Update',
                            color: AppColors.kkPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ],
                      ),
                    )
                  ]),
            ));
      },
    );
  }
}
