import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/custom_outlined_text_field.dart';
import 'package:graduation/core/widgets/shared_button.dart';
import 'package:graduation/features/profile/cubit/update_password_cubit/update_password__cubit.dart';
import '../../../../core/widgets/resuable_text.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdatePasswordCubit, UpdatePasswordCubitStates>(
      listener: (context, state) {
        if (state is UpdatePasswordSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
          Navigator.pop(context);
        }
        if (state is UpdatePasswordFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final updatePasswordCubit =
            BlocProvider.of<UpdatePasswordCubit>(context);
        return Scaffold(
          body: SafeArea(
            child: Form(
              key: updatePasswordCubit.updatePasswordFormKey,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
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
                            width: 60,
                          ),
                          const ResuableText(
                            text: 'Password Manager',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.c242424,
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, top: 30.h),
                        child: const ResuableText(
                          text: 'Current Password',
                          fontSize: 12,
                          color: AppColors.c353535,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, end: 14.w),
                        child: CustomOutlinedTextField(
                          obsecureText: updatePasswordCubit.oldPasswordObscure,
                          suffixIconOnTap: () {
                            updatePasswordCubit.updateOldPasswordIcon();
                          },
                          validator: (value) {
                            if (updatePasswordCubit
                                    .oldPasswordController.text ==
                                '') {
                              return 'Please Enter Your Old Password';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitte: (value) {
                            if (updatePasswordCubit
                                .updatePasswordFormKey.currentState!
                                .validate()) {
                              updatePasswordCubit.changePassword(
                                  oldPassword: updatePasswordCubit
                                      .oldPasswordController.text,
                                  newPassword: updatePasswordCubit
                                      .newPasswordController.text,
                                  confirmNewPassword: updatePasswordCubit
                                      .confirmPasswordController.text);
                            }
                          },
                          hasSuffixIcon: true,
                          suffixIcon: updatePasswordCubit.oldPasswordIcon,
                          controller: updatePasswordCubit.oldPasswordController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, top: 15.h),
                        child: const ResuableText(
                          textDecoration: TextDecoration.underline,
                          text: 'Forgot Password?',
                          fontSize: 12,
                          color: AppColors.kkPrimaryColor,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, top: 30.h),
                        child: const ResuableText(
                          text: 'New Password',
                          fontSize: 12,
                          color: AppColors.c353535,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, end: 14.w),
                        child: CustomOutlinedTextField(
                          obsecureText: updatePasswordCubit.newPasswordObscure,
                          suffixIconOnTap: () {
                            updatePasswordCubit.updateNewPasswordIcon();
                          },
                          validator: (value) {
                            if (updatePasswordCubit
                                    .newPasswordController.text !=
                                updatePasswordCubit
                                    .confirmPasswordController.text) {
                              return 'passwords don\'t match';
                            }
                            if (updatePasswordCubit
                                    .newPasswordController.text ==
                                '') {
                              return 'please enter your new password to continue';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitte: (value) {
                            if (updatePasswordCubit
                                .updatePasswordFormKey.currentState!
                                .validate()) {
                              updatePasswordCubit.changePassword(
                                  oldPassword: updatePasswordCubit
                                      .oldPasswordController.text,
                                  newPassword: updatePasswordCubit
                                      .newPasswordController.text,
                                  confirmNewPassword: updatePasswordCubit
                                      .confirmPasswordController.text);
                            }
                          },
                          hasSuffixIcon: true,
                          suffixIcon: updatePasswordCubit.newPasswordIcon,
                          controller: updatePasswordCubit.newPasswordController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, top: 20.h),
                        child: const ResuableText(
                          text: 'Confirm New Password',
                          fontSize: 12,
                          color: AppColors.c353535,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 16.w, end: 14.w),
                        child: CustomOutlinedTextField(
                          obsecureText:
                              updatePasswordCubit.confirmNewPasswordObscure,
                          suffixIconOnTap: () {
                            updatePasswordCubit.updateConfirmNewPasswordIcon();
                          },
                          validator: (value) {
                            if (updatePasswordCubit
                                    .newPasswordController.text !=
                                updatePasswordCubit
                                    .confirmPasswordController.text) {
                              return 'passwords don\'t match';
                            }
                            if (updatePasswordCubit
                                    .confirmPasswordController.text ==
                                '') {
                              return 'please confirm your new password to continue';
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitte: (value) {
                            if (updatePasswordCubit
                                .updatePasswordFormKey.currentState!
                                .validate()) {
                              updatePasswordCubit.changePassword(
                                  oldPassword: updatePasswordCubit
                                      .oldPasswordController.text,
                                  newPassword: updatePasswordCubit
                                      .newPasswordController.text,
                                  confirmNewPassword: updatePasswordCubit
                                      .confirmPasswordController.text);
                            }
                          },
                          hasSuffixIcon: true,
                          suffixIcon:
                              updatePasswordCubit.confirmNewPasswordIcon,
                          controller:
                              updatePasswordCubit.confirmPasswordController,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const Spacer(),
                      state is UpdatePasswordLoadingState
                          ? Padding(
                              padding: EdgeInsets.only(bottom: 25.h),
                              child: const Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.primaryColor,
                              )),
                            )
                          : Padding(
                              padding: EdgeInsetsDirectional.only(
                                  bottom: 25.h, start: 24, end: 24.w),
                              child: SharedButton(
                                  buttonColor: AppColors.kkPrimaryColor,
                                  width: MediaQuery.of(context).size.width,
                                  hasBorderRadius: true,
                                  borderRadiusValue: 16,
                                  height: 50,
                                  btnTextStyle: AppStyles.textStyle(
                                      color: AppColors.white, size: 16),
                                  btnText: 'Save',
                                  onPressed: () {
                                    if (updatePasswordCubit
                                        .updatePasswordFormKey.currentState!
                                        .validate()) {
                                      updatePasswordCubit.changePassword(
                                          oldPassword: updatePasswordCubit
                                              .oldPasswordController.text,
                                          newPassword: updatePasswordCubit
                                              .newPasswordController.text,
                                          confirmNewPassword:
                                              updatePasswordCubit
                                                  .confirmPasswordController
                                                  .text);
                                    }
                                  }),
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
