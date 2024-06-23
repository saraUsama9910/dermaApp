import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/global_cubits/change_language_cubit/change_language_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/profile/data/models/change_language_model/change_language_model.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    super.key,
    required this.changeLanguageModel,
    required this.maxWidth,
    required this.languagesList,
    required this.currentIndex,
  });

  final ChangeLanguageModel changeLanguageModel;
  final double maxWidth;
  final List<ChangeLanguageModel> languagesList;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeLanguageCubit, ChangeLanguageState>(
      listener: (context, state) {},
      builder: (context, state) {
        final changeLanguageCubit =
            BlocProvider.of<ChangeLanguageCubit>(context);
        return GestureDetector(
          onTap: () {
            print(changeLanguageModel.languageSympol);
            changeLanguageCubit.onContainerTapped(
                changeLanguageList: languagesList, currentIndex: currentIndex);
            changeLanguageCubit
                .changeLanguage(changeLanguageModel.languageSympol);
          },
          child: Container(
            width: maxWidth,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey.withOpacity(.5), width: 1.5.w))),
            child: Column(
              children: [
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    ResuableText(
                        text: changeLanguageModel.languageName,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c242424),
                    const Spacer(),
                    Container(
                      width: 18.w,
                      height: 18.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9.r),
                          border: Border.all(
                            color: AppColors.c9E9E9E,
                            width: .75.w,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                            width: 9.w,
                            height: 9.h,
                            decoration: BoxDecoration(
                                color: changeLanguageModel.isSelected == false
                                    ? AppColors.white
                                    : AppColors.kkPrimaryColor,
                                borderRadius: BorderRadius.circular(4.5.r))),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
