import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/fontweight_helper.dart';
import 'package:graduation/features/community/cubits/search_for_posts_cubit/search_for_posts_cubit.dart';
import 'package:graduation/features/community/presentation/widgets/No_posts_widget.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:graduation/features/community/presentation/widgets/search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchForPostsCubit, SearchForPostsState>(
      listener: (context, state) {
        if (state is SerachForPostsSuccessState) {
          showToast(
              msg: state.searchModel.message!,
              toastStates: ToastStates.success);
        }
      },
      builder: (context, state) {
        final searhCubit = BlocProvider.of<SearchForPostsCubit>(context);
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.kkPrimaryColor,
                                  size: 23.sp,
                                )),
                          ),
                          const Spacer(),
                          Container(
                            height: 32.h,
                            width: MediaQuery.of(context).size.width * .75,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.3),
                                borderRadius: BorderRadius.circular(6.r)),
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                searhCubit.searchForPosts(
                                    query: searhCubit.searchController.text);
                              },
                              controller: searhCubit.searchController,
                              decoration: InputDecoration(
                                hintText: 'Search....',
                                contentPadding: EdgeInsetsDirectional.only(
                                    start: 10.w, bottom: 8.h),
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintStyle: AppStyles.textStyle(
                                    color: AppColors.cA3A3A3,
                                    weight: FontWeightHelper.regular,
                                    size: 17),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: 10.w, bottom: 5.h),
                            child: GestureDetector(
                              onTap: () {
                                searhCubit.searchForPosts(
                                    query: searhCubit.searchController.text);
                              },
                              child: Icon(
                                FontAwesomeIcons.magnifyingGlass,
                                color: AppColors.kkPrimaryColor,
                                size: 22.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: LineWidget(
                    color: AppColors.cF1F1F0,
                    height: 2,
                  ),
                ),
                state is SerachForPostsFailureState
                    ? SliverFillRemaining(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: const NoPostsWidget(
                            widgetTitle: 'No Matching Posts',
                          ),
                        ),
                      )
                    : state is SerachForPostsSuccessState
                        ? SliverList(
                            delegate: SliverChildBuilderDelegate(
                            (context, index) => SearchWidget(
                              maxwidth: MediaQuery.of(context).size.width,
                              getsearchData:
                                  state.searchModel.data!.posts![index],
                            ),
                            childCount: state.searchModel.data!.posts!.length,
                          ))
                        : state is SerachForPostsLoadingState
                            ? SliverToBoxAdapter(
                                child: Container(
                                  color: AppColors.cF1F1F0,
                                  child: Padding(
                                    padding:
                                        EdgeInsetsDirectional.only(top: 10.h),
                                    child: const Center(
                                        child: CircularProgressIndicator(
                                      color: AppColors.kkPrimaryColor,
                                      backgroundColor: AppColors.cF1F1F0,
                                    )),
                                  ),
                                ),
                              )
                            : SliverFillRemaining(
                                child: Container(
                                  color: AppColors.cF1F1F0,
                                ),
                              ),
                SliverFillRemaining(
                  child: Container(
                    color: AppColors.cF1F1F0,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
