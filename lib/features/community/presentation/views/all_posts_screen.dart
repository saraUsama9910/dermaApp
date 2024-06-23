import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/default_app_bar.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/presentation/widgets/No_posts_widget.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:graduation/features/community/presentation/widgets/post_container_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/routes/routes.dart';

class AllPostsScreen extends StatelessWidget {
  AllPostsScreen({super.key});

  GlobalKey refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCommunityCubit, GlobalCommunityState>(
      listener: (context, state) {
        if (state is GetAllPostsSuccessState) {
          showToast(
              msg: 'All Posts Loaded Successfully',
              toastStates: ToastStates.success);
        }
        if (state is GetAllPostsFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
        if (state is DeletePostSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
        }
        if (state is DeletePostFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final communityCubit = BlocProvider.of<GlobalCommunityCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: RefreshIndicator(
              key: refreshIndicatorKey,
              onRefresh: () async {
                communityCubit.getAllPosts();
              },
              edgeOffset: 1,
              color: AppColors.kkPrimaryColor,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      color: AppColors.white,
                      child: DefaultAppBar(
                        hasTitle: false,
                        hasLeading: true,
                        hasActions: true,
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: ResuableText(
                            text: 'Home',
                            fontSize: 16.sp,
                            color: AppColors.kkPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        actions: [
                          GestureDetector(
                            onTap: () {
                              navigate(
                                  context: context,
                                  route: Routes.addPostScreen);
                            },
                            child: Container(
                              width: 30.w,
                              height: 30.w,
                              decoration: BoxDecoration(
                                color: AppColors.kkPrimaryColor,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Icon(
                                size: 20.sp,
                                Icons.add,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(end: 10.w),
                            child: GestureDetector(
                              onTap: () {
                                navigate(
                                    context: context,
                                    route: Routes.searchScreen);
                              },
                              child: Container(
                                width: 30.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  color: AppColors.kkPrimaryColor,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Icon(
                                  Icons.search_rounded,
                                  size: 20.sp,
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: const LineWidget(
                        height: 2,
                      ),
                    ),
                  ),
                  state is GetAllPostsLoadingState
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                          (context, index) => Shimmer.fromColors(
                            baseColor: AppColors.white,
                            highlightColor: AppColors.kkPrimaryColor,
                            child: const PostContainerWidget(
                              isPostDetailsScreen: false,
                            ),
                          ),
                          childCount: 20,
                        ))
                      : state is GetAllPostsSuccessState
                          ? SliverList(
                              delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final listLength =
                                    state.getAllPostsModel.data!.length;
                                return PostContainerWidget(
                                  isPostDetailsScreen: false,
                                  getPostData: state.getAllPostsModel
                                      .data![listLength - 1 - index],
                                );
                              },
                              childCount: state.getAllPostsModel.data!.length,
                            ))
                          : state is GetAllPostsFailureState
                              ? const SliverToBoxAdapter(
                                  child: NoPostsWidget(),
                                )
                              : SliverFillRemaining(
                                  child: Container(
                                    color: AppColors.cF1F1F0,
                                  ),
                                ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
