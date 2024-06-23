import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/default_app_bar.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/cubits/add_post_cubit/add_post_cubit.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/fontweight_helper.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state is AddPostSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
          BlocProvider.of<GlobalCommunityCubit>(context).getAllPosts();
          Navigator.pop(context);
        }
        if (state is AddPostFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final addPostCubit = BlocProvider.of<AddPostCubit>(context);
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: ListView(
              children: [
                state is AddPostLoadingState
                    ? Container(
                        height: 45.h,
                        color: AppColors.white,
                        child: DefaultAppBar(
                          hasTitle: true,
                          hasLeading: true,
                          hasActions: true,
                          startPAddingValue: 10,
                          leading: Icon(
                            FontAwesomeIcons.xmark,
                            color: AppColors.kkPrimaryColor,
                            size: 25.sp,
                          ),
                          title: const ResuableText(
                            text: 'New Post',
                            fontSize: 16,
                            color: AppColors.kkPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(end: 13.w),
                              child: SizedBox(
                                width: 25.w,
                                height: 25.h,
                                child: const CircularProgressIndicator(
                                  color: AppColors.kkPrimaryColor,
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 45.h,
                        color: AppColors.white,
                        child: DefaultAppBar(
                          hasTitle: true,
                          hasLeading: true,
                          hasActions: true,
                          startPAddingValue: 10,
                          leading: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                FontAwesomeIcons.xmark,
                                color: AppColors.kkPrimaryColor,
                                size: 25.sp,
                              )),
                          title: const ResuableText(
                            text: 'New Post',
                            fontSize: 16,
                            color: AppColors.kkPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(end: 10.w),
                              child: GestureDetector(
                                onTap: () {
                                  if (addPostCubit
                                          .addPostController.text.isEmpty &&
                                      addPostCubit.photoFromAddedPost == null) {
                                    showToast(
                                        msg:
                                            'Please write something or upload photo to add post',
                                        toastStates: ToastStates.success);
                                  } else {
                                    addPostCubit.addPost(
                                        postText:
                                            addPostCubit.addPostController.text,
                                        postImage:
                                            addPostCubit.photoFromAddedPost);
                                    addPostCubit.photoFromAddedPost = null;
                                    addPostCubit.addPostController.clear();
                                  }
                                },
                                child: Container(
                                    width: 60.w,
                                    height: 34.h,
                                    decoration: BoxDecoration(
                                      color: AppColors.kkPrimaryColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(3.r),
                                    ),
                                    child: const Center(
                                      child: ResuableText(
                                          text: 'Add',
                                          fontSize: 15,
                                          color: AppColors.white,
                                          fontWeight: FontWeightHelper.regular),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                Container(
                  decoration: const BoxDecoration(color: AppColors.white),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * .8,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(start: 10.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 45.w,
                              height: 45.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: CacheHelper().getData(
                                              key: ApiKeys.profile_picture) ==
                                          null
                                      ? const DecorationImage(
                                          image: AssetImage(ImageConstants
                                              .userProfileDefaultImage),
                                          fit: BoxFit.fill)
                                      : DecorationImage(
                                          image: NetworkImage(
                                            '${CacheHelper().getData(key: ApiKeys.profile_picture)}',
                                          ),
                                          fit: BoxFit.fill)),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextField(
                                    controller: addPostCubit.addPostController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      hintText: 'What is going on ?',
                                      hintStyle: AppStyles.textStyle(
                                        color: AppColors.c687684,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      addPostCubit.photoFromAddedPost != null
                          ? Image.file(
                              File(addPostCubit.photoFromAddedPost!.path),
                              fit: BoxFit.fill,
                              width: double.infinity,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                state is AddPostLoadingState
                    ? SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .08,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 10.w, bottom: 10.h),
                          child: Row(
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: AppColors.kkPrimaryColor,
                                size: 30.sp,
                              ),
                              const Spacer(),
                              Padding(
                                padding: EdgeInsetsDirectional.only(
                                  end: 10.w,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 25.w,
                                        height: 25.h,
                                        child: SvgPicture.asset(
                                          ImageConstants.earthIcon,
                                          color: AppColors.kkPrimaryColor,
                                        )),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    const ResuableText(
                                      text: 'Public',
                                      fontSize: 14,
                                      color: AppColors.kkPrimaryColor,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * .08,
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              start: 10.w, bottom: 10.h),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            backgroundColor: AppColors.white,
                                            contentPadding:
                                                EdgeInsetsDirectional.symmetric(
                                              vertical: 10.h,
                                            ),
                                            actionsPadding:
                                                EdgeInsetsDirectional.zero,
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
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
                                                      addPostCubit
                                                          .addPhotoForPost(
                                                              photo: value!);
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
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                          child: Center(
                                                              child: Icon(
                                                            FontAwesomeIcons
                                                                .cameraRetro,
                                                            color: AppColors
                                                                .kkPrimaryColor,
                                                            size: 20.sp,
                                                          ))),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      const ResuableText(
                                                        text: 'Open Camera',
                                                        color: AppColors
                                                            .kkPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                                      addPostCubit
                                                          .addPhotoForPost(
                                                              photo: value!);
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
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                          child: Center(
                                                              child: Icon(
                                                            FontAwesomeIcons
                                                                .images,
                                                            color: AppColors
                                                                .kkPrimaryColor,
                                                            size: 20.sp,
                                                          ))),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      const ResuableText(
                                                          color: AppColors
                                                              .kkPrimaryColor,
                                                          text: 'Open Gallery',
                                                          fontWeight: FontWeight
                                                              .normal),
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
                                child: Icon(
                                  Icons.image_outlined,
                                  color: AppColors.kkPrimaryColor,
                                  size: 30.sp,
                                ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    addPostCubit.deletorPhotoForPost();
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: AppColors.kkPrimaryColor,
                                    size: 30.sp,
                                  )),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
