import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/widgets/custom_outlined_text_field.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/core/widgets/shared_button.dart';
import 'package:graduation/features/auth/cubits/forgot_pass_cubit/forgot_pass_cubit.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPassCubit, ForgotPassCubitState>(
      listener: (context, state) {
        if (state is ForgotPassSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
        }
        if (state is ForgotPassFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final forgotPassCubit = BlocProvider.of<ForgotPassCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.primaryColor,
                )),
            backgroundColor: AppColors.white,
            elevation: 0,
          ),
          body: Form(
            key: forgotPassCubit.forgetPassFormKey,
            child: Padding(
              padding:
                  EdgeInsetsDirectional.only(start: 20.w, top: 10.h, end: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find your account',
                    style: AppStyles.textStyle(
                        color: AppColors.kkPrimaryColor,
                        size: 20,
                        weight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const ResuableText(
                    text: 'Enter your email address',
                    color: AppColors.kGreyColor,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomOutlinedTextField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your email to continue';
                      }
                      return null;
                    },
                    hintText: 'Email address',
                    hintStyle: AppStyles.textStyle(
                        color: AppColors.kGreyColor, size: 16),
                    contentBottomPadding: 20,
                    controller: forgotPassCubit.forgetPassEmailController,
                    keyboardType: TextInputType.emailAddress,
                    borderSideColor: AppColors.c9099A1,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  state is ForgotPassLoadingState
                      ? Center(
                          child: SizedBox(
                            width: 25.w,
                            height: 25.h,
                            child: const CircularProgressIndicator(
                              color: AppColors.cA98AB0,
                              strokeWidth: 2,
                            ),
                          ),
                        )
                      : SharedButton(
                          height: 50,
                          width: double.infinity,
                          btnTextStyle: AppStyles.textStyle(
                              color: AppColors.white, size: 16),
                          hasBorderRadius: true,
                          borderRadiusValue: 25,
                          btnText: 'Continue',
                          onPressed: () {
                            if (forgotPassCubit.forgetPassFormKey.currentState!
                                .validate()) {
                              forgotPassCubit.forgotPass(
                                  email: forgotPassCubit
                                      .forgetPassEmailController.text);
                            }
                          })
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
