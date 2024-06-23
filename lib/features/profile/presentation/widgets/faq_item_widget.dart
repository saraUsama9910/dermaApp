import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/localization/app_localization.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:graduation/features/profile/cubit/faq_screen_cubit/faq_screen_cubit.dart';
import 'package:graduation/features/profile/data/models/faq_model.dart';

class FaqItemWidget extends StatelessWidget {
  const FaqItemWidget({
    super.key,
    required this.faqModel,
  });

  final FaQModel faqModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FaqScreenCubit(),
      child: BlocBuilder<FaqScreenCubit, FaqScreenState>(
        builder: (context, state) {
          final faqScreenCubit = BlocProvider.of<FaqScreenCubit>(context);
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  faqScreenCubit.changeContainerShape();
                },
                child: Container(
                  height: faqScreenCubit.containerISOpen ? 145.h : 40.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                          color: Colors.grey.withOpacity(.5), width: 2.w)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 8.w,
                          ),
                          ResuableText(
                            text: faqModel.questionText.tr(context),
                            fontSize: 12,
                          ),
                          const Spacer(),
                          faqScreenCubit.containerISOpen == false
                              ? const Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: AppColors.kkPrimaryColor,
                                )
                              : const Icon(
                                  Icons.keyboard_arrow_up,
                                  color: AppColors.kkPrimaryColor,
                                ),
                          SizedBox(
                            width: 8.w,
                          ),
                        ],
                      ),
                      if (faqScreenCubit.containerISOpen == true)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                    top: 5.h, start: 8.w, end: 23.w),
                                child: LineWidget(
                                  color: Colors.grey.withOpacity(.5),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                    top: 5.h,
                                    start: 10.w,
                                  ),
                                  child: Text(faqModel.answerText.tr(context),
                                      style: AppStyles.textStyle(
                                          size: 14, weight: FontWeight.normal)),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
