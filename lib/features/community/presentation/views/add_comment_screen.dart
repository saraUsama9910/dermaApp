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
import 'package:graduation/features/community/presentation/widgets/No_posts_widget.dart';
import 'package:graduation/features/community/presentation/widgets/comment_widget.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';

class AddCommentScreen extends StatelessWidget {
  const AddCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCommunityCubit, GlobalCommunityState>(
      listener: (context, state) {
        if (state is GetAllPostsSuccessState) {
          showToast(
              msg: 'Comments Loaded Successfully',
              toastStates: ToastStates.success);
          BlocProvider.of<GlobalCommunityCubit>(context).getAllPosts();
          Navigator.pop(context);
        }
        if (state is GetAllPostsFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final communityCubit = BlocProvider.of<GlobalCommunityCubit>(context);
        final postId = ModalRoute.of(context)!.settings.arguments as num;
        return Scaffold(
            body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 15.w),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            communityCubit.getAllPosts();
                          },
                          child: Icon(
                            FontAwesomeIcons.arrowLeftLong,
                            color: AppColors.kkPrimaryColor,
                            size: 25.sp,
                          )),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    const ResuableText(
                      text: 'Comments',
                      fontSize: 18,
                      color: AppColors.kkPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsetsDirectional.only(end: 14.w),
                      child: Icon(
                        Icons.report_outlined,
                        color: AppColors.kkPrimaryColor,
                        size: 25.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              const SliverToBoxAdapter(
                child: LineWidget(
                  color: AppColors.cF1F1F0,
                  height: 2,
                ),
              ),
              state is GetAllCommentsLoadingState
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(top: 20.h),
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.kkPrimaryColor,
                        )),
                      ),
                    )
                  : state is GetAllCommentsSuccessState
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                    padding: EdgeInsetsDirectional.only(
                                        start: 25.w,
                                        top: 9.h,
                                        end: 12.w,
                                        bottom: 12.h),
                                    child: CommentContainer(
                                      postId: postId,
                                      commentData:
                                          state.commentsModel.data![index],
                                    ),
                                  ),
                              childCount: state.commentsModel.data!.length))
                      : state is GetAllCommentsFailureState
                          ? const SliverToBoxAdapter(
                              child: NoPostsWidget(
                                widgetTitle: 'No Comments Yet',
                              ),
                            )
                          : const SliverFillRemaining(),
              const SliverFillRemaining(),
              const SliverToBoxAdapter(
                child: LineWidget(
                  color: AppColors.cF1F1F0,
                  height: 2,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50.h,
                  child: Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: 5.h),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                          width: 45.w,
                          height: 45.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: CacheHelper().getData(
                                          key: ApiKeys.profile_picture) ==
                                      null
                                  ? const DecorationImage(
                                      image: AssetImage(ImageConstants
                                          .userProfileDefaultImage),
                                      fit: BoxFit.fill)
                                  : DecorationImage(
                                      image: NetworkImage(
                                        '${CacheHelper().getData(key: ApiKeys.profile_picture)}',
                                      ),
                                      fit: BoxFit.fill)),
                        ),
                        const Spacer(),
                        Container(
                            height: 35.h,
                            width: MediaQuery.of(context).size.width * .65,
                            decoration: BoxDecoration(
                              color: AppColors.cDADADA,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                                controller: communityCubit
                                    .addCommentControllerForAddScreen,
                                cursorHeight: 20.h,
                                onSubmitted: (value) async {
                                  await communityCubit.addCommentForPost(
                                      postId: postId,
                                      comment: communityCubit
                                          .addCommentControllerForAddScreen
                                          .text);
                                  communityCubit.getCommentsForPost(
                                      postId: postId);
                                  communityCubit
                                      .addCommentControllerForAddScreen
                                      .clear();
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsetsDirectional.only(
                                        start: 10, bottom: 5.h),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintText: 'Add Your Comment',
                                    hintStyle: AppStyles.textStyle(
                                      color: AppColors.c747474,
                                    )))),
                        const Spacer(),
                        GestureDetector(
                          onTap: () async {
                            await communityCubit.addCommentForPost(
                                postId: postId,
                                comment: communityCubit
                                    .addCommentControllerForAddScreen.text);
                            communityCubit.getCommentsForPost(postId: postId);
                            communityCubit.addCommentControllerForAddScreen
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
              )
            ],
          ),
        ));
      },
    );
  }
}
