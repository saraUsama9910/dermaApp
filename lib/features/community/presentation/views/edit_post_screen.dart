import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/global_community_cubit/global_community_cubit.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/default_app_bar.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/presentation/widgets/edit_post_item.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:image_picker/image_picker.dart';

class EditPostScreen extends StatelessWidget {
  const EditPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GlobalCommunityCubit, GlobalCommunityState>(
      listener: (context, state) {
        if (state is UpdatePostSuccessState) {
          showToast(
              msg: state.successMessage, toastStates: ToastStates.success);
          BlocProvider.of<GlobalCommunityCubit>(context).getAllPosts();
          navigate(context: context, route: Routes.allPostsScreen);
        }
        if (state is UpdatePostFailureState) {
          showToast(msg: state.errorMessage, toastStates: ToastStates.error);
        }
      },
      builder: (context, state) {
        final communityCubit = BlocProvider.of<GlobalCommunityCubit>(context);
        var postId = ModalRoute.of(context)!.settings.arguments as num;
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                state is UpdatePostLoadingState
                    ? SliverToBoxAdapter(
                        child: DefaultAppBar(
                          hasTitle: true,
                          hasLeading: true,
                          hasActions: true,
                          leading: Icon(
                            FontAwesomeIcons.close,
                            color: AppColors.kkPrimaryColor,
                            size: 20.sp,
                          ),
                          title: const ResuableText(
                            text: 'Edit Post',
                            color: AppColors.kkPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(end: 10.w),
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
                    : SliverToBoxAdapter(
                        child: DefaultAppBar(
                          hasTitle: true,
                          hasLeading: true,
                          hasActions: true,
                          leading: GestureDetector(
                              onTap: () async {
                                await communityCubit.getAllPosts();
                                Navigator.pop(context);
                              },
                              child: Icon(
                                FontAwesomeIcons.close,
                                color: AppColors.kkPrimaryColor,
                                size: 20.sp,
                              )),
                          title: const ResuableText(
                            text: 'Edit Post',
                            color: AppColors.kkPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsetsDirectional.only(end: 10.w),
                              child: GestureDetector(
                                onTap: () {
                                  communityCubit.updatePost(
                                      postId: postId,
                                      attachment:
                                          communityCubit.updatedPostImage,
                                      postText: communityCubit
                                          .textFieldForUpdatedTextController
                                          .text);
                                  communityCubit
                                      .textFieldForUpdatedTextController
                                      .clear();
                                  communityCubit.updatedPostImage = null;
                                },
                                child: Container(
                                    width: 55.w,
                                    height: 30.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.kkPrimaryColor,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                    child: const Center(
                                        child: ResuableText(
                                      text: 'Save',
                                      color: AppColors.white,
                                    ))),
                              ),
                            ),
                          ],
                        ),
                      ),
                const SliverToBoxAdapter(
                  child: LineWidget(
                    height: 2,
                  ),
                ),
                SliverFillRemaining(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                start: 10.w, top: 10.h),
                            child: Container(
                                width: 50.w,
                                height: 50.h,
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
                                            fit: BoxFit.fill))),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sara Osama',
                                  style: AppStyles.textStyle(
                                    color: AppColors.c141619,
                                    weight: FontWeight.w700,
                                    size: 13,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Text(
                                    '${CacheHelper().getData(key: ApiKeys.type)}',
                                    style: AppStyles.textStyle(
                                      color: AppColors.black,
                                      weight: FontWeight.w500,
                                      size: 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                          child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 10.w,
                        ),
                        child: TextFormField(
                          controller:
                              communityCubit.textFieldForUpdatedTextController,
                          onFieldSubmitted: (value) {
                            communityCubit.updatePost(
                                postId: postId,
                                attachment: communityCubit.updatedPostImage,
                                postText: communityCubit
                                    .textFieldForUpdatedTextController.text);
                            communityCubit.textFieldForUpdatedTextController
                                .clear();
                            communityCubit.updatedPostImage = null;
                          },
                          decoration: InputDecoration(
                            hintText: 'What\'s on your mind?',
                            hintStyle: AppStyles.textStyle(
                                color: AppColors.cC4C4C4,
                                size: 15,
                                weight: FontWeight.w400),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                          ),
                        ),
                      )),
                      SizedBox(
                        height: 10.h,
                      ),
                      communityCubit.updatedPostImage != null
                          ? Expanded(
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.file(
                                    File(communityCubit.updatedPostImage!.path),
                                    fit: BoxFit.fill,
                                  )),
                            )
                          : const Spacer(),
                      Column(
                        children: [
                          EditPostItem(
                            onTap: () {
                              imagePick(imageSource: ImageSource.gallery).then(
                                (value) {
                                  communityCubit.updateNewImageForPost(
                                      image: value!);
                                },
                              );
                            },
                            postItemImage: Icons.photo_library_outlined,
                            postItemText: 'Photo/video',
                          ),
                          EditPostItem(
                            onTap: () {
                              imagePick(imageSource: ImageSource.camera).then(
                                (value) {
                                  communityCubit.updateNewImageForPost(
                                      image: value!);
                                },
                              );
                            },
                            postItemImage: Icons.camera_alt_outlined,
                            postItemText: 'Camera',
                          ),
                          EditPostItem(
                            onTap: () {
                              communityCubit.deleteUpdatePostImage();
                            },
                            postItemImage: Icons.delete_outline,
                            postItemText: 'Delete Updated Photo',
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
