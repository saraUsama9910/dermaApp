import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/profile/cubit/faq_screen_cubit/faq_screen_cubit.dart';
import 'package:graduation/features/profile/presentation/widgets/faq_item_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FaqScreenCubit, FaqScreenState>(
      builder: (context, state) {
        final faqCubit = BlocProvider.of<FaqScreenCubit>(context);
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 16.h,
                )),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 16.w),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: AppColors.cF1F1F0,
                                    width: 1.4.w,
                                  )),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: SvgPicture.asset(
                                  ImageConstants.arrowBackProfileIcon,
                                  color: AppColors.black,
                                  width: 6.w,
                                  height: 12.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )),
                      ),
                      const SizedBox(
                        width: 113.5,
                      ),
                      const ResuableText(
                        text: 'FAQ',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.c242424,
                      )
                    ],
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 15.w, end: 10.w, top: 20.h),
                    child: FaqItemWidget(
                      faqModel: faqCubit.faqDataList[index],
                    ),
                  ),
                  childCount: faqCubit.faqDataList.length,
                )),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 30.h,
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
