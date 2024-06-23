import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/data/models/get_all_posts_model/Data.dart';
import 'package:graduation/features/community/presentation/widgets/comment_for_details.dart';
import 'package:graduation/features/community/presentation/widgets/comment_widget.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:graduation/features/community/presentation/widgets/post_container_widget.dart';

import '../../../../core/utils/fontweight_helper.dart';

class PostDetailsScreen extends StatelessWidget {
  const PostDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final recievedData =
        ModalRoute.of(context)!.settings.arguments as AllPostsData;
    return BlocConsumer<GlobalCommunityCubit, GlobalCommunityState>(
      listener: (context, state) {
        if (state is AddCommentSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
          BlocProvider.of<GlobalCommunityCubit>(context)
              .getCommentsForPost(postId: recievedData.id!);
        }
        if (state is AddCommentFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final communityCubit = BlocProvider.of<GlobalCommunityCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 10.h,
                    color: AppColors.white,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.white,
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              communityCubit.getAllPosts();
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(start: 15.w),
                              child: Icon(
                                FontAwesomeIcons.arrowLeftLong,
                                color: AppColors.kkPrimaryColor,
                                size: 20.sp,
                              ),
                            )),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .36,
                        ),
                        const ResuableText(
                          text: 'Post',
                          fontSize: 16,
                          color: AppColors.kkPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 10.h,
                    color: AppColors.white,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: LineWidget(),
                ),
                SliverToBoxAdapter(
                  child: PostContainerWidget(
                    isPostDetailsScreen: true,
                    hasSeparatedWidget: false,
                    hasDateTime: true,
                    getPostData: recievedData,
                  ),
                ),
                state is GetAllCommentsSuccessState
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                                padding: EdgeInsetsDirectional.only(
                                    start: 15.w,
                                    top: 9.h,
                                    end: 17.w,
                                    bottom: 12.h),
                                child: CommentContainer(
                                  postId: recievedData.id!,
                                  commentData: state.commentsModel.data![index],
                                )),
                            childCount: state.commentsModel.data!.length))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (context, index) => Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 15.w,
                                      top: 9.h,
                                      end: 17.w,
                                      bottom: 12.h),
                                  child: CommentContainerForDetails(
                                    postId: recievedData.id!,
                                    commentData: recievedData.comments![index],
                                  ),
                                ),
                            childCount: recievedData.comments!.length)),
                recievedData.comments!.isEmpty
                    ? SliverFillRemaining(
                        child: Container(
                        color: AppColors.white,
                      ))
                    : const SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      ),
                recievedData.comments!.length < 6
                    ? SliverFillRemaining(
                        child: Container(
                        color: AppColors.white,
                      ))
                    : const SliverToBoxAdapter(
                        child: SizedBox.shrink(),
                      ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(top: 10.h),
                    child: const LineWidget(
                      height: 1.7,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 50.h,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 5.h),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          Container(
                            width: 45.w,
                            height: 45.h,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: CacheHelper().getData(
                                            key: ApiKeys.profile_picture) !=
                                        null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            "${CacheHelper().getData(key: ApiKeys.profile_picture)}"),
                                        fit: BoxFit.fill)
                                    : const DecorationImage(
                                        image: AssetImage(ImageConstants
                                            .userProfileDefaultImage),
                                        fit: BoxFit.fill)),
                          ),
                          const Spacer(),
                          Container(
                            height: 35.h,
                            width: MediaQuery.of(context).size.width * .69,
                            decoration: BoxDecoration(
                              color: AppColors.cDADADA,
                              borderRadius: BorderRadius.circular(17.5.r),
                            ),
                            child: TextFormField(
                              onFieldSubmitted: (value) async {
                                await communityCubit.addCommentForPost(
                                    postId: recievedData.id!,
                                    comment: communityCubit
                                        .addCommentControllerForPostDetailsScreen
                                        .text);

                                communityCubit
                                    .addCommentControllerForPostDetailsScreen
                                    .clear();
                              },
                              cursorColor: AppColors.kkPrimaryColor,
                              controller: communityCubit
                                  .addCommentControllerForPostDetailsScreen,
                              decoration: InputDecoration(
                                hintText: 'Add your comment',
                                border: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: 10.w, bottom: 10.h),
                                hintStyle: AppStyles.textStyle(
                                  color: AppColors.cA3A3A3,
                                  weight: FontWeightHelper.regular,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () async {
                              await communityCubit.addCommentForPost(
                                  postId: recievedData.id!,
                                  comment: communityCubit
                                      .addCommentControllerForPostDetailsScreen
                                      .text);

                              communityCubit
                                  .addCommentControllerForPostDetailsScreen
                                  .clear();
                            },
                            child: SizedBox(
                                width: 22.w,
                                height: 22.h,
                                child: Image.asset(ImageConstants.sendImage,
                                    color: AppColors.kkPrimaryColor)),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
