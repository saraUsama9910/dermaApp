import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/cubits/change_dislike_shape_cubit/change_dislike_shape_cubit.dart';
import 'package:graduation/features/community/data/models/get_all_posts_model/Data.dart';
import 'package:graduation/features/community/presentation/widgets/delete_post_widget.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/fontweight_helper.dart';
import '../../cubits/change_like_shape_cubit/change_like_shape_cubit.dart';

class PostContainerWidget extends StatelessWidget {
  const PostContainerWidget(
      {super.key,
      this.hasSeparatedWidget = true,
      this.hasDateTime = false,
      required this.isPostDetailsScreen,
      this.getPostData});

  final AllPostsData? getPostData;

  final bool hasSeparatedWidget;

  final bool hasDateTime;

  final bool isPostDetailsScreen;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChangeLikeShapeCubit(),
        ),
        BlocProvider(
          create: (context) => ChangeDislikeShapeCubit(),
        ),
      ],
      child: BlocConsumer<ChangeDislikeShapeCubit, ChangeDislikeShapeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final changeDislikeShapeCubit =
              BlocProvider.of<ChangeDislikeShapeCubit>(context);
          return BlocConsumer<ChangeLikeShapeCubit, ChangeLikeShapeState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              final changeLikeShapeCubit =
                  BlocProvider.of<ChangeLikeShapeCubit>(context);
              return BlocBuilder<GlobalCommunityCubit, GlobalCommunityState>(
                builder: (context, state) {
                  final communityCubit =
                      BlocProvider.of<GlobalCommunityCubit>(context);

                  return GestureDetector(
                    onTap: () {
                      navigate(
                          context: context,
                          route: Routes.postDetailsScreen,
                          arg: getPostData);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(top: 7.h),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    start: 10.w,
                                  ),
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: getPostData!
                                                    .user!.profilePicture !=
                                                null
                                            ? DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        getPostData!.user!
                                                            .profilePictureUrl!),
                                                fit: BoxFit.contain)
                                            : const DecorationImage(
                                                image: AssetImage(ImageConstants
                                                    .userProfileDefaultImage),
                                                fit: BoxFit.contain)),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            getPostData!.user!.displayName!,
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
                                                      getPostData!.createdAt!)),
                                              style: AppStyles.textStyle(
                                                color: AppColors.black,
                                                weight: FontWeight.w500,
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      CacheHelper().getData(key: ApiKeys.id) ==
                                              getPostData!.user!.id
                                          ? GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return performActionsOnPostFun(
                                                        context,
                                                        communityCubit);
                                                  },
                                                );
                                              },
                                              child: SizedBox(
                                                  width: 15.w,
                                                  height: 15.h,
                                                  child: SvgPicture.asset(
                                                    ImageConstants.elipsisIcon,
                                                    color: AppColors
                                                        .kkPrimaryColor,
                                                  )),
                                            )
                                          : const SizedBox.shrink(),
                                      SizedBox(
                                        width: 20.w,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isPostDetailsScreen == false
                              ? Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 15.w, top: 10.h),
                                  child: ResuableText(
                                    text: getPostData!.postText!,
                                    color: AppColors.c141619,
                                    fontSize: 14,
                                    fontWeight: FontWeightHelper.regular,
                                  ))
                              : Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 15.w, top: 10.h, end: 25.w),
                                  child: Text(
                                    getPostData!.postText!,
                                    style: AppStyles.textStyle(
                                      color: AppColors.c141619,
                                      size: 14,
                                      weight: FontWeightHelper.regular,
                                    ),
                                  ),
                                ),
                          getPostData!.imageUrl != null
                              ? Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 15.w, end: 25.h, top: 8.h),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: CachedNetworkImage(
                                      imageUrl: getPostData!.imageUrl!,
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          hasDateTime
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15.w, end: 25, top: 20.h),
                                      child: const LineWidget(
                                        height: 1.7,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15.w, top: 10.h),
                                      child: Row(
                                        children: [
                                          Text(
                                            formatTime(getPostData!.createdAt),
                                            style: AppStyles.textStyle(
                                              color: AppColors.c687684,
                                              weight: FontWeightHelper.regular,
                                              size: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 5.h),
                                            child: const ResuableText(
                                              text: '.',
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            formatDate(getPostData!.createdAt),
                                            style: AppStyles.textStyle(
                                              color: AppColors.c687684,
                                              weight: FontWeightHelper.regular,
                                              size: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            'From ${getPostData!.user!.displayName!}',
                                            style: AppStyles.textStyle(
                                              color: AppColors.c687684,
                                              weight: FontWeightHelper.regular,
                                              size: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15.w, end: 25, top: 10.h),
                                      child: const LineWidget(
                                        height: 1.7,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 15.w, top: 10.h),
                                      child: Row(
                                        textBaseline: TextBaseline.alphabetic,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.baseline,
                                        children: [
                                          Text(
                                            '${getPostData!.upvotes!}',
                                            style: AppStyles.textStyle(
                                              color: AppColors.c141619,
                                              weight: FontWeight.bold,
                                              size: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 5.h),
                                            child: const ResuableText(
                                              text: 'Likes',
                                              color: AppColors.c687684,
                                              fontWeight:
                                                  FontWeightHelper.regular,
                                              fontSize: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            '${getPostData!.downvotes!}',
                                            style: AppStyles.textStyle(
                                              color: AppColors.c141619,
                                              weight: FontWeight.bold,
                                              size: 13,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 5.h),
                                            child: const ResuableText(
                                              text: 'Dislikes',
                                              color: AppColors.c687684,
                                              fontWeight:
                                                  FontWeightHelper.regular,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsetsDirectional.only(top: 10.h),
                                      child: const LineWidget(
                                        height: 1.7,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          hasDateTime == false
                              ? SizedBox(
                                  height: 20.h,
                                )
                              : SizedBox(
                                  height: 5.h,
                                ),
                          isPostDetailsScreen == true
                              ? const SizedBox.shrink()
                              : Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 15.w, end: 20.w),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          communityCubit.addLikeForPost(
                                            postId: getPostData!.id!,
                                          );
                                          changeLikeShapeCubit
                                              .changeLikeShape();
                                        },
                                        child: Container(
                                          width: 75.w,
                                          height: 27.h,
                                          decoration: BoxDecoration(
                                              color: AppColors.kkPrimaryColor
                                                  .withOpacity(.2),
                                              borderRadius:
                                                  BorderRadius.circular(14.r)),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              changeLikeShapeCubit
                                                          .likeIsActive ==
                                                      true
                                                  ? Icon(
                                                      FontAwesomeIcons
                                                          .solidThumbsUp,
                                                      color: AppColors
                                                          .kkPrimaryColor,
                                                      size: 20.sp,
                                                    )
                                                  : Icon(
                                                      FontAwesomeIcons.thumbsUp,
                                                      color: AppColors
                                                          .kkPrimaryColor,
                                                      size: 20.sp,
                                                    ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              changeLikeShapeCubit
                                                          .likeIsActive ==
                                                      true
                                                  ? Text(
                                                      '${getPostData!.upvotes! + 1}' ??
                                                          '201',
                                                      style:
                                                          AppStyles.textStyle(
                                                              color: AppColors
                                                                  .black,
                                                              weight: FontWeight
                                                                  .w400,
                                                              size: 12),
                                                    )
                                                  : Text(
                                                      '${getPostData!.upvotes}' ??
                                                          '201',
                                                      style:
                                                          AppStyles.textStyle(
                                                              color: AppColors
                                                                  .black,
                                                              weight: FontWeight
                                                                  .w400,
                                                              size: 12),
                                                    ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          changeDislikeShapeCubit
                                              .changeDislikeShape();
                                          communityCubit.addDislikeForPost(
                                              postId: getPostData!.id!);
                                        },
                                        child: Container(
                                          width: 75.w,
                                          height: 27.h,
                                          decoration: BoxDecoration(
                                              color: AppColors.kkPrimaryColor
                                                  .withOpacity(.2),
                                              borderRadius:
                                                  BorderRadius.circular(14.r)),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              changeDislikeShapeCubit
                                                          .dislikeIsActive ==
                                                      true
                                                  ? Icon(
                                                      FontAwesomeIcons
                                                          .solidThumbsDown,
                                                      color: AppColors
                                                          .kkPrimaryColor,
                                                      size: 20.sp,
                                                    )
                                                  : Icon(
                                                      FontAwesomeIcons
                                                          .thumbsDown,
                                                      color: AppColors
                                                          .kkPrimaryColor,
                                                      size: 20.sp,
                                                    ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              changeDislikeShapeCubit
                                                          .dislikeIsActive ==
                                                      true
                                                  ? Text(
                                                      '${getPostData!.upvotes! + 1}' ??
                                                          '201',
                                                      style:
                                                          AppStyles.textStyle(
                                                              color: AppColors
                                                                  .black,
                                                              weight: FontWeight
                                                                  .w400,
                                                              size: 12),
                                                    )
                                                  : Text(
                                                      '${getPostData!.upvotes}' ??
                                                          '201',
                                                      style:
                                                          AppStyles.textStyle(
                                                              color: AppColors
                                                                  .black,
                                                              weight: FontWeight
                                                                  .w400,
                                                              size: 12),
                                                    ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          communityCubit.getCommentsForPost(
                                              postId: getPostData!.id!);
                                          navigate(
                                              context: context,
                                              route: Routes.addCommentScreen,
                                              arg: getPostData!.id!);
                                        },
                                        child: Container(
                                          width: 75.w,
                                          height: 27.h,
                                          decoration: BoxDecoration(
                                              color: AppColors.kkPrimaryColor
                                                  .withOpacity(.2),
                                              borderRadius:
                                                  BorderRadius.circular(14.r)),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                              Icon(
                                                FontAwesomeIcons.comment,
                                                color: AppColors.kkPrimaryColor,
                                                size: 20.sp,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Text(
                                                '${getPostData!.commentsCount}' ??
                                                    '123',
                                                style: AppStyles.textStyle(
                                                    color: AppColors.black,
                                                    weight: FontWeight.w400,
                                                    size: 12),
                                              ),
                                              SizedBox(
                                                width: 12.w,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (context) => AlertDialog(
                                                          backgroundColor:
                                                              AppColors.white,
                                                          contentPadding:
                                                              EdgeInsetsDirectional
                                                                  .zero,
                                                          content: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SizedBox(
                                                                  height: 15.h,
                                                                ),
                                                                Builder(builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      if (getPostData!
                                                                              .postText ==
                                                                          '') {
                                                                        showToast(
                                                                            msg:
                                                                                'This post doesn\'t have text to share',
                                                                            toastStates:
                                                                                ToastStates.error);
                                                                      } else {
                                                                        Share.share(
                                                                            getPostData!.postText!);
                                                                        Navigator.pop(
                                                                            context);
                                                                      }
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              20.w,
                                                                        ),
                                                                        Container(
                                                                            width:
                                                                                30.w,
                                                                            height: 30.h,
                                                                            decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: AppColors.white,
                                                                            ),
                                                                            child: Center(
                                                                                child: Icon(
                                                                              Icons.share_outlined,
                                                                              color: AppColors.kkPrimaryColor,
                                                                              size: 25.sp,
                                                                            ))),
                                                                        SizedBox(
                                                                          width:
                                                                              10.w,
                                                                        ),
                                                                        const ResuableText(
                                                                          text:
                                                                              'Share Text',
                                                                          color:
                                                                              AppColors.kkPrimaryColor,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontSize:
                                                                              14,
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
                                                                    if (getPostData!
                                                                            .imageUrl ==
                                                                        null) {
                                                                      showToast(
                                                                          msg:
                                                                              'This post doesn\'t have image to share',
                                                                          toastStates:
                                                                              ToastStates.error);
                                                                    } else {
                                                                      Share.shareUri(
                                                                          Uri.parse(
                                                                              getPostData!.imageUrl!));
                                                                      Navigator.pop(
                                                                          context);
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            20.w,
                                                                      ),
                                                                      Container(
                                                                          width: 30
                                                                              .w,
                                                                          height: 30
                                                                              .h,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color:
                                                                                AppColors.white,
                                                                          ),
                                                                          child: Center(
                                                                              child: Icon(
                                                                            Icons.share_outlined,
                                                                            color:
                                                                                AppColors.kkPrimaryColor,
                                                                            size:
                                                                                25.sp,
                                                                          ))),
                                                                      SizedBox(
                                                                        width:
                                                                            10.w,
                                                                      ),
                                                                      const ResuableText(
                                                                        color: AppColors
                                                                            .kkPrimaryColor,
                                                                        text:
                                                                            'Share Image',
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 15.h,
                                                                )
                                                              ]),
                                                        ));
                                          },
                                          child: SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child: Image.asset(
                                                ImageConstants.shareImage,
                                                color:
                                                    AppColors.kkPrimaryColor),
                                          ))
                                    ],
                                  ),
                                ),
                          hasDateTime == false
                              ? SizedBox(
                                  height: 15.h,
                                )
                              : const SizedBox.shrink(),
                          hasSeparatedWidget
                              ? Container(
                                  width: double.infinity,
                                  height: 20.h,
                                  color: AppColors.cF1F1F0,
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  AlertDialog performActionsOnPostFun(
      BuildContext context, GlobalCommunityCubit communityCubit) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      contentPadding: EdgeInsetsDirectional.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              navigate(
                  context: context,
                  route: Routes.editPostScreen,
                  arg: getPostData!.id!);
            },
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Container(
                    width: 35.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kkPrimaryColor,
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
                  color: AppColors.kkPrimaryColor,
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
                    width: 35.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kkPrimaryColor,
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
                  color: AppColors.kkPrimaryColor,
                  text: 'Delete Post',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () async {},
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Container(
                    width: 35.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kkPrimaryColor,
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.photo_library_outlined,
                      color: AppColors.white,
                    ))),
                SizedBox(
                  width: 10.w,
                ),
                const ResuableText(
                  color: AppColors.kkPrimaryColor,
                  text: 'Delete Post Photo',
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                SizedBox(
                  width: 20.w,
                ),
                Container(
                    width: 35.w,
                    height: 30.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.kkPrimaryColor,
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.text_decrease,
                      color: AppColors.white,
                    ))),
                SizedBox(
                  width: 10.w,
                ),
                const ResuableText(
                  color: AppColors.kkPrimaryColor,
                  text: 'Delete Post Text',
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
        return DeletePostWidget(getPostData: getPostData);
      },
    );
  }
}
