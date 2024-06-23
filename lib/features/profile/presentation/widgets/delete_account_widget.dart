import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/api/dio_consumer.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/core/widgets/shared_button.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:graduation/features/profile/cubit/delete_user_cubit/delete_user_cubit.dart';
import 'package:graduation/features/profile/data/repos/profile_repo_implementation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteAccountwidget extends StatelessWidget {
  const DeleteAccountwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteUserCubit(
          profileRepoImplementation:
              ProfileRepoImplementation(apiConsumer: DioConsumer(dio: Dio()))),
      child: BlocConsumer<DeleteUserCubit, DeleteUserState>(
        listener: (context, state) async {
          if (state is DeleteAccountSuccessState) {
            showToast(
                msg: state.successMessage, toastStates: ToastStates.error);
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            navigate(context: context, route: Routes.kLoginView);
          }
          if (state is DeleteAccountFailureState) {
            showToast(msg: state.errorMessage, toastStates: ToastStates.error);
          }
        },
        builder: (context, state) {
          final deleteCubit = BlocProvider.of<DeleteUserCubit>(context);
          return Container(
              height: 200.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.r),
                topRight: Radius.circular(8.r),
              )),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 15.h, start: 140.w, end: 140.w),
                      child: Center(
                        child: LineWidget(
                          color: AppColors.cE6E6E6.withOpacity(.3),
                          height: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(top: 25.h),
                      child: const ResuableText(
                        text: 'Delete Account',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 15.h, start: 30.w, end: 30.w),
                      child: const Center(
                        child: LineWidget(
                          color: AppColors.cE7E7E7,
                          height: 2,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const ResuableText(
                      text: 'Are You Sure You Want to Delete Account?',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        top: 20.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SharedButton(
                            btnText: 'Cancel',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            hasBorderRadius: true,
                            borderRadiusValue: 25.r,
                            hasBorder: true,
                            height: 50,
                            buttonColor: AppColors.white,
                            btnTextStyle: AppStyles.textStyle(
                                color: AppColors.kkPrimaryColor, size: 18),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          SharedButton(
                            btnText: 'Yes, Delete',
                            onPressed: () {
                              deleteCubit.deleteAccountFun();
                            },
                            hasBorderRadius: true,
                            borderRadiusValue: 25.r,
                            height: 50,
                            btnTextStyle: AppStyles.textStyle(
                                color: AppColors.white, size: 18),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ]));
        },
      ),
    );
  }
}
