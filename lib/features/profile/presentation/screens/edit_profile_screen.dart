import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/custom_image_picker.dart';
import 'package:graduation/core/widgets/custom_outlined_text_field.dart';
import 'package:graduation/core/widgets/default_app_bar.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/core/widgets/shared_button.dart';
import 'package:graduation/features/profile/cubit/update_profile_cubit/update_profile_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
      listener: (context, state) {
        if (state is UpdateProfileSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
          BlocProvider.of<GetUserInfoCubit>(context).getUserData();
          navigate(context: context, route: Routes.mainProfileScreen);
        }
        if (state is UpdateProfileFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final updateProfileCubit = BlocProvider.of<UpdateProfileCubit>(context);
        return Scaffold(
          body: Form(
            key: updateProfileCubit.updateProfileFormKey,
            child: SafeArea(
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
                        SizedBox(
                          width: 41.w,
                        ),
                        const ResuableText(
                          text: 'Personal information',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.c242424,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    updateProfileCubit.updateProfilePhoto == null
                        ? Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 120.w,
                                  height: 120.h,
                                  decoration: const BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage(ImageConstants
                                              .userProfileDefaultImage))),
                                ),
                                PositionedDirectional(
                                  bottom: 7.5.h,
                                  start: 90.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .symmetric(
                                                  vertical: 10.h,
                                                ),
                                                actionsPadding:
                                                    EdgeInsetsDirectional.zero,
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await imagePick(
                                                                imageSource:
                                                                    ImageSource
                                                                        .camera)
                                                            .then((value) {
                                                          updateProfileCubit
                                                              .updateProfilePhotoFun(
                                                                  image:
                                                                      value!);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 20.w,
                                                          ),
                                                          Container(
                                                              width: 35.w,
                                                              height: 35.h,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                              child: Center(
                                                                  child: Icon(
                                                                FontAwesomeIcons
                                                                    .cameraRetro,
                                                                color: AppColors
                                                                    .white,
                                                                size: 20.sp,
                                                              ))),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          const ResuableText(
                                                            text: 'Open Camera',
                                                            color:
                                                                AppColors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await imagePick(
                                                                imageSource:
                                                                    ImageSource
                                                                        .gallery)
                                                            .then((value) {
                                                          updateProfileCubit
                                                              .updateProfilePhotoFun(
                                                                  image:
                                                                      value!);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 20.w,
                                                          ),
                                                          Container(
                                                              width: 35.w,
                                                              height: 35.h,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                              child: Center(
                                                                  child: Icon(
                                                                FontAwesomeIcons
                                                                    .images,
                                                                color: AppColors
                                                                    .white,
                                                                size: 20.sp,
                                                              ))),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          const ResuableText(
                                                            color:
                                                                AppColors.white,
                                                            text:
                                                                'Open Gallery',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  ],
                                                ),
                                              ));
                                    },
                                    child: Container(
                                      width: 30.55.w,
                                      height: 30.55.h,
                                      padding: EdgeInsetsDirectional.only(
                                          start: 6.w, end: 4.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade300,
                                      ),
                                      child: SvgPicture.asset(
                                          ImageConstants.pencilProfileIcon,
                                          color: AppColors.kkPrimaryColor),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                    width: 120.w,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: FileImage(File(
                                                updateProfileCubit
                                                    .updateProfilePhoto!.path)),
                                            fit: BoxFit.fill))),
                                PositionedDirectional(
                                  bottom: 7.5.h,
                                  start: 90.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                contentPadding:
                                                    EdgeInsetsDirectional
                                                        .symmetric(
                                                  vertical: 10.h,
                                                ),
                                                actionsPadding:
                                                    EdgeInsetsDirectional.zero,
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await imagePick(
                                                                imageSource:
                                                                    ImageSource
                                                                        .camera)
                                                            .then((value) {
                                                          updateProfileCubit
                                                              .updateProfilePhotoFun(
                                                                  image:
                                                                      value!);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 20.w,
                                                          ),
                                                          Container(
                                                              width: 35.w,
                                                              height: 35.h,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                              child: Center(
                                                                  child: Icon(
                                                                FontAwesomeIcons
                                                                    .cameraRetro,
                                                                color: AppColors
                                                                    .white,
                                                                size: 20.sp,
                                                              ))),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          const ResuableText(
                                                            text: 'Open Camera',
                                                            color:
                                                                AppColors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.h,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await imagePick(
                                                                imageSource:
                                                                    ImageSource
                                                                        .gallery)
                                                            .then((value) {
                                                          updateProfileCubit
                                                              .updateProfilePhotoFun(
                                                                  image:
                                                                      value!);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 20.w,
                                                          ),
                                                          Container(
                                                              width: 35.w,
                                                              height: 35.h,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: AppColors
                                                                    .primaryColor,
                                                              ),
                                                              child: Center(
                                                                  child: Icon(
                                                                FontAwesomeIcons
                                                                    .images,
                                                                color: AppColors
                                                                    .white,
                                                                size: 20.sp,
                                                              ))),
                                                          SizedBox(
                                                            width: 10.w,
                                                          ),
                                                          const ResuableText(
                                                            color:
                                                                AppColors.white,
                                                            text:
                                                                'Open Gallery',
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                  ],
                                                ),
                                              ));
                                    },
                                    child: Container(
                                      width: 30.55.w,
                                      height: 30.55.h,
                                      padding: EdgeInsetsDirectional.all(4.w),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey.shade300,
                                      ),
                                      child: SvgPicture.asset(
                                        ImageConstants.pencilProfileIcon,
                                        color: AppColors.kkPrimaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 16.w,
                      ),
                      child: const ResuableText(
                        text: 'Name',
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your Name';
                            }
                            return null;
                          },
                          controller: updateProfileCubit.updateNameController,
                          keyboardType: TextInputType.text,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 16.w,
                      ),
                      child: const ResuableText(
                        text: 'Display Name',
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your display name';
                            }
                            return null;
                          },
                          controller:
                              updateProfileCubit.updateDisplayNameController,
                          keyboardType: TextInputType.text,
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 16.w),
                      child: const ResuableText(
                        text: 'Email',
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email';
                            }
                            return null;
                          },
                          controller: updateProfileCubit.updateEmailController,
                          keyboardType: TextInputType.text,
                        )),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                          top: 24.h, start: 16.w, end: 16.w),
                      child: const ResuableText(
                          text:
                              'When you set up your personal information settings, you should take care to provide accurate information.',
                          fontSize: 12,
                          color: AppColors.c757575,
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    state is UpdateProfileLoadingState
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                              bottom: 25.h,
                            ),
                            child: Center(
                              child: SizedBox(
                                width: 25.w,
                                height: 25.h,
                                child: const CircularProgressIndicator(
                                  color: AppColors.kkPrimaryColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsetsDirectional.only(
                                bottom: 25.h, start: 24.w, end: 24.w),
                            child: Center(
                              child: SharedButton(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  onPressed: () {
                                    if (updateProfileCubit
                                        .updateProfileFormKey.currentState!
                                        .validate()) {
                                      updateProfileCubit.updateProfile(
                                        name: updateProfileCubit
                                            .updateNameController.text,
                                        email: updateProfileCubit
                                            .updateEmailController.text,
                                        display_name: updateProfileCubit
                                            .updateDisplayNameController.text,
                                      );
                                    }
                                  },
                                  hasBorderRadius: true,
                                  borderRadiusValue: 16,
                                  btnText: 'Save',
                                  btnTextStyle: AppStyles.textStyle(
                                      color: AppColors.white,
                                      weight: FontWeight.bold,
                                      size: 16.sp),
                                  buttonColor: AppColors.kkPrimaryColor),
                            ),
                          ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            )),
          ),
        );
      },
    );
  }
}
