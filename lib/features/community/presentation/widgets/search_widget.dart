import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/data/models/search_model/search_posts.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/fontweight_helper.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget(
      {super.key, required this.getsearchData, required this.maxwidth});

  final SearchPosts getsearchData;

  final double maxwidth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCommunityCubit, GlobalCommunityState>(
      builder: (context, state) {
        final communityCubit = BlocProvider.of<GlobalCommunityCubit>(context);
        return Container(
          width: maxwidth,
          decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(color: AppColors.cF1F1F0, width: 20.w),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                image:
                                    getsearchData.user!.profilePicture != null
                                        ? DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                getsearchData
                                                    .user!.profilePictureUrl!),
                                            fit: BoxFit.contain)
                                        : const DecorationImage(
                                            image: AssetImage(ImageConstants
                                                .userProfileDefaultImage),
                                            fit: BoxFit.contain)))),
                    SizedBox(
                      width: 10.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getsearchData.user!.displayName ?? 'Sara Osama',
                            style: AppStyles.textStyle(
                              color: AppColors.c141619,
                              weight: FontWeight.w700,
                              size: 13,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 2.h),
                            child: Text(
                              getTimeDifference(
                                      postDate: DateTime.parse(
                                          getsearchData.createdAt!)) ??
                                  '2m ago',
                              style: AppStyles.textStyle(
                                color: AppColors.black,
                                weight: FontWeight.w500,
                                size: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsetsDirectional.only(start: 15.w, top: 10.h),
                  child: RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: getsearchData.postText ??
                              'This text is an example of text that can be replaced in the same space, this text has been generated. This text is an example of text that can be replaced in the same space',
                          style: AppStyles.textStyle(
                            color: AppColors.c141619,
                            size: 14,
                            weight: FontWeightHelper.regular,
                          )),
                    ],
                  ))),
              getsearchData.imageUrl != null
                  ? Padding(
                      padding: EdgeInsetsDirectional.only(
                          start: 15.w, end: 15.h, top: 10.h),
                      child: Image.network(
                        getsearchData.imageUrl,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                height: 20.h,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(end: 25.w),
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                            onTap: () {
                              Share.share(getsearchData.postText!);
                            },
                            child: SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: Image.asset(ImageConstants.shareImage,
                                  color: AppColors.kkPrimaryColor),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  AlertDialog modifyPostDialogue(
      BuildContext context, GlobalCommunityCubit communityCubit) {
    return AlertDialog(
      backgroundColor: AppColors.cD4C4D7,
      contentPadding: EdgeInsetsDirectional.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              navigate(context: context, route: Routes.editPostScreen);
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
                  text: 'Modify Post',
                  color: AppColors.white,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              deletePostDialog(context, communityCubit);
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
                  text: 'Delete Post',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }

  Future<dynamic> deletePostDialog(
      BuildContext context, GlobalCommunityCubit communityCubit) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          actionsPadding: EdgeInsetsDirectional.zero,
          title: const Center(
            child: ResuableText(
              text: 'Delete this post?',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const ResuableText(
              text:
                  'Items that are deleted you will not be able to recover it.\nAre you sure you want to continue?'),
          actions: [
            Column(
              children: [
                const LineWidget(
                  color: AppColors.c808080,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await communityCubit.deletePost(
                            postId: getsearchData.id!);
                        communityCubit.getAllPosts();
                        navigate(
                            context: context, route: Routes.allPostsScreen);
                      },
                      child: SizedBox(
                        width: 140.w,
                        child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                            color: AppColors.c808080,
                            width: 1.w,
                          ))),
                          child: const Center(
                            child: ResuableText(text: 'Delete'),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        width: 140.w,
                        child: Container(
                          height: 40.h,
                          decoration: const BoxDecoration(),
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
                  ],
                )
              ],
            )
          ],
        );
      },
    );
  }
}
