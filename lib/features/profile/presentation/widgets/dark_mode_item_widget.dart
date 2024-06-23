import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/change_theme_cubit/change_theme_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import '../../data/models/dark_mode_data_model.dart';

class DarkModeItemWidget extends StatelessWidget {
  const DarkModeItemWidget({
    super.key,
    required this.currentIndex,
    required this.darkModeDataList,
  });

  final int currentIndex;

  final List<DarkModeDataModel> darkModeDataList;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeThemeCubit, ChangeThemeState>(
      listener: (context, state) {
        if (state is ChangeThemeSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
        }
      },
      builder: (context, state) {
        final changeThemeCubit = BlocProvider.of<ChangeThemeCubit>(context);
        return GestureDetector(
          onTap: () {
            if (currentIndex == 0) {
              changeThemeCubit.changeCircleActiveState(
                  currentIndex, darkModeDataList);
              changeThemeCubit.changeThemeToDark();
            }
            if (currentIndex == 1) {
              changeThemeCubit.changeCircleActiveState(
                  currentIndex, darkModeDataList);
              changeThemeCubit.changeThemeToLight();
            }
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(color: AppColors.cEBEBEB, width: 1.5.w),
            )),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Row(
                children: [
                  Text(
                    darkModeDataList[currentIndex].modeName,
                    style: AppStyles.textStyle(
                      weight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  darkModeDataList[currentIndex].modeIsSelected
                      ? Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.kkPrimaryColor, width: 2.w)),
                          child: Padding(
                            padding: EdgeInsetsDirectional.all(3.w),
                            child: Container(
                              width: 15.w,
                              height: 15.h,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.kkPrimaryColor),
                            ),
                          ),
                        )
                      : Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.c888888, width: 2.w)),
                        )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
