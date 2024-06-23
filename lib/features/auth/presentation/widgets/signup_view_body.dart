import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/constants.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/custom_image_picker.dart';
import 'package:graduation/core/widgets/custom_underline_text_field.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/core/widgets/shared_button.dart';
import 'package:graduation/features/auth/cubits/signup_cubit/signup_cubit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/utils/app_colors.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupCubitState>(
      listener: (context, state) {
        if (state is SignupSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
          navigate(context: context, route: Routes.kLoginView, replace: true);
        }
        if (state is SignupFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final signupCubit = BlocProvider.of<SignupCubit>(context);
        return Form(
          key: signupCubit.signUpFormKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 180.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: AppColors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 15.w),
                child: ListView(
                  padding: EdgeInsetsDirectional.zero,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    signupCubit.updateProfilePic == null
                        ? Center(
                            child: CustomImagePickerAvatar(
                              fitState: BoxFit.contain,
                              hasBottom: true,
                              hasEnd: true,
                              image: const AssetImage(
                                  ImageConstants.userProfileDefaultImage),
                              cameraOnTap: () {
                                imagePick(imageSource: ImageSource.camera).then(
                                  (value) {
                                    signupCubit.addProfilePic(
                                        profilePic: value!);
                                  },
                                );
                                Navigator.pop(context);
                              },
                              galleryOnTap: () async {
                                imagePick(imageSource: ImageSource.gallery)
                                    .then(
                                  (value) {
                                    signupCubit.addProfilePic(
                                        profilePic: value!);
                                  },
                                );
                                Navigator.pop(context);
                              },
                            ),
                          )
                        : Center(
                            child: CustomImagePickerAvatar(
                              fitState: BoxFit.cover,
                              hasBottom: true,
                              hasEnd: true,
                              image: FileImage(
                                  File(signupCubit.updateProfilePic!.path)),
                              cameraOnTap: () {
                                imagePick(imageSource: ImageSource.camera).then(
                                  (value) {
                                    signupCubit.addProfilePic(
                                        profilePic: value!);
                                  },
                                );
                                Navigator.pop(context);
                              },
                              galleryOnTap: () async {
                                imagePick(imageSource: ImageSource.gallery)
                                    .then(
                                  (value) {
                                    signupCubit.addProfilePic(
                                        profilePic: value!);
                                  },
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ),
                    CustomUnderlineTextField(
                      controller: signupCubit.nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      hasLabelText: true,
                      labelText: 'Name',
                      hasSuffixIcon: true,
                    ),
                    CustomUnderlineTextField(
                      controller: signupCubit.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                      hasLabelText: true,
                      labelText: 'Gmail',
                      hasSuffixIcon: true,
                    ),
                    CustomUnderlineTextField(
                      controller: signupCubit.displayNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter display name';
                        }
                        return null;
                      },
                      hasLabelText: true,
                      labelText: 'Display Name',
                      hasSuffixIcon: true,
                    ),
                    CustomUnderlineTextField(
                      obscureText: signupCubit.passwordObsecureTextIsActive,
                      controller: signupCubit.passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      hasLabelText: true,
                      labelText: 'Password',
                      hasSuffixIcon: true,
                      suffixIcon: signupCubit.signUpPasswordIcon,
                      suffixOnTap: signupCubit.cahangePasswordEye,
                    ),
                    CustomUnderlineTextField(
                      obscureText:
                          signupCubit.passwordConfirmObsecureTextIsActive,
                      controller: signupCubit.passwordConfirmationController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password confirmation';
                        }
                        if (signupCubit.passwordController.text !=
                            signupCubit.passwordConfirmationController.text) {
                          return 'passwords don\'t match';
                        }
                        return null;
                      },
                      hasLabelText: true,
                      labelText: 'Password Confirmation',
                      hasSuffixIcon: true,
                      suffixIcon: signupCubit.signUpConfirmPasswordIcon,
                      suffixOnTap: signupCubit.changeConfirmPasswordEye,
                    ),
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select gender';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      value: signupCubit.genderSelectedValue,
                      hint: Text('Select Your Gender',
                          style: AppStyles.textStyle(
                            weight: FontWeight.bold,
                            color: AppColors.kBlueColor,
                          )),
                      items: signupCubit.genderItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: AppStyles.textStyle(
                                    weight: FontWeight.bold,
                                    color: AppColors.kBlueColor,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        signupCubit.genderSelectedValue = value!;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select account type';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      value: signupCubit.userTpeSelectedValue,
                      hint: Text('Select Your Account Type',
                          style: AppStyles.textStyle(
                            weight: FontWeight.bold,
                            color: AppColors.kBlueColor,
                          )),
                      items: signupCubit.usersTypes
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: AppStyles.textStyle(
                                    weight: FontWeight.bold,
                                    color: AppColors.kBlueColor,
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {
                        signupCubit.userTpeSelectedValue = value!;
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    AppConstants.isPatient == false
                        ? signupCubit.uploadedMedicalLisencePhoto == null
                            ? DottedBorder(
                                color: AppColors.cCACACA,
                                strokeWidth: 1,
                                dashPattern: const [12, 5],
                                padding: EdgeInsets.only(
                                  top: 20.h,
                                  bottom: 35.h,
                                ),
                                child: GestureDetector(
                                  onTap: () async {
                                    await imagePick(
                                            imageSource: ImageSource.gallery)
                                        .then((value) => signupCubit
                                            .uploadMedicalLisencePhoto(
                                                uploadedPhoto: value!));
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 55.w,
                                        height: 55.h,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.cF5F5F5,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.upload_file_outlined,
                                            color: AppColors.kBlueColor,
                                            size: 25.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Click to Upload',
                                            style: AppStyles.textStyle(
                                              weight: FontWeight.bold,
                                              color: AppColors.kBlueColor,
                                            ),
                                          ),
                                          Text(
                                            ' medical lisence',
                                            style: AppStyles.textStyle(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                            : Column(
                                children: [
                                  Container(
                                    height: 150.h,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(File(signupCubit
                                              .uploadedMedicalLisencePhoto!
                                              .path)),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  SharedButton(
                                    onPressed: () {
                                      signupCubit.deleteMedicalLisencePhoto();
                                    },
                                    btnText: 'Remove',
                                    width: double.infinity,
                                    height: 50,
                                    borderRadiusValue: 6,
                                    hasBorderRadius: true,
                                    btnTextStyle: AppStyles.textStyle(
                                      color: AppColors.white,
                                      size: 16,
                                      weight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              )
                        : const SizedBox.shrink(),
                    SizedBox(
                      height: 80.h,
                    ),
                    state is SignupLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ))
                        : GestureDetector(
                            onTap: () {
                              if (signupCubit.signUpFormKey.currentState!
                                  .validate()) {
                                signupCubit.signUp(
                                    name: signupCubit.nameController.text,
                                    email: signupCubit.emailController.text,
                                    displayName:
                                        signupCubit.displayNameController.text,
                                    password:
                                        signupCubit.passwordController.text,
                                    passwordConfirmation: signupCubit
                                        .passwordConfirmationController.text,
                                    gender: signupCubit.genderSelectedValue,
                                    type: signupCubit.userTpeSelectedValue,
                                    profilePic: signupCubit.updateProfilePic,
                                    medicalLisence: signupCubit
                                        .uploadedMedicalLisencePhoto);
                              }
                            },
                            child: Container(
                              height: 55.h,
                              width: 300.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(colors: [
                                  AppColors.primaryColor,
                                  AppColors.kkPrimaryColor
                                ]),
                              ),
                              child: Center(
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp,
                                      color: AppColors.white),
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ResuableText(
                            text: 'Already have an account?',
                            color: AppColors.kGreyColor,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              navigate(
                                  context: context, route: Routes.kLoginView);
                            },
                            child: Text(
                              "Sign in",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                                color: AppColors.kBlueColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
