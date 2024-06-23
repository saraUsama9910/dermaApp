


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/commons/global_cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/profile/presentation/widgets/mainprofile_settings_item.dart';

class MainProfileScreen extends StatelessWidget {
  const MainProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetUserInfoCubit, GetUserInfoState>(
  listener: (context, state)
  {


  },
  builder: (context, state) {
    final profileCubit = BlocProvider.of<GetUserInfoCubit>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children:
                [

                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: AppColors.kkPrimaryColor
                    ),
                  ),
                  PositionedDirectional(
                      top: 16.h,
                      child:  Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40.h,
                        child: Row(
                          children: [
                            SizedBox(width: 16.w,),
                            GestureDetector(
                              onTap: ()
                                {
                                  Navigator.pop(context);
                                },
                                child: SvgPicture.asset(ImageConstants.arrowBackProfileIcon)),
                            Spacer(),
                            ResuableText(
                              text: 'Profile',
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: ()
                                {
                                  navigate(context: context, route: Routes.settingsScreen);
                                },
                                child: SvgPicture.asset(ImageConstants.settingsForProfileIcon)),
                            SizedBox(width: 16.w,),
                          ],
                        ),
                      )),


                  PositionedDirectional(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.8,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24.w),
                              topRight: Radius.circular(24.w),
                            ),
                          ),
                      
                        ),
                        PositionedDirectional(
                          top: -60.h,
                          start: 125.w,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              state is GetUserDataSuccessState?
                              Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: CachedNetworkImageProvider('state.userAllDataModel.profilePictureUrl'),)
                                    ),
                                  ),
                                ),
                              ):
                              Container(
                                width: 120.w,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(ImageConstants.userProfileDefaultImage),)
                                    ),
                                  ),
                                ),
                              ),
                              PositionedDirectional(
                                bottom: 7.5.h,
                                start: 90.w,
                                child: Container(
                                  width: 30.55.w,
                                  height: 30.55.h,
                                  padding: EdgeInsetsDirectional.only(start: 6.w,end: 4.w),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade300,
                                  ),
                                  child: GestureDetector(
                                    onTap: ()
                                      {
                                        navigate(context: context, route: Routes.editProfileScreen);
                                      },
                                      child: SvgPicture.asset(ImageConstants.pencilProfileIcon,color: AppColors.kkPrimaryColor,)),
                                ),
                              )
                            ],
                          ),
                        ),
                        state is GetUserDataSuccessState?
                        PositionedDirectional(
                          top: 75.h,
                          start: 124.w,
                            child:  ResuableText(
                              text: state.userAllDataModel.displayName!,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.c121212,
                            ),):
                        PositionedDirectional(
                          top: 75.h,
                          start: 124.w,
                          child:  ResuableText(
                            text: CacheHelper().getData(key: ApiKeys.display_name),
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.c121212,
                          ),),

                        state is GetUserDataSuccessState?
                        PositionedDirectional(
                          top: 110.h,
                          start: MediaQuery.of(context).size.width * 0.3,
                          child:  ResuableText(
                            text: state.userAllDataModel.email!,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.cD3D3D3,
                          ),):
                        PositionedDirectional(
                          top: 110.h,
                          start: MediaQuery.of(context).size.width * 0.3,
                          child:  ResuableText(
                            text: CacheHelper().getData(key: ApiKeys.email),
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColors.cD3D3D3,
                          ),),

                        PositionedDirectional(
                          top: 135.h,
                            start: 15.w,
                            end: 15.w,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: profileCubit.profileItems.length,
                                  padding: EdgeInsetsDirectional.zero,
                                  separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                                  itemBuilder: (context, index) =>
                                      MainprofileSettingsItem(
                                    currentIndex: index,
                                    maxWidth: MediaQuery.of(context).size.width,
                                    profileItem: profileCubit.profileItems[index],
                                  ),
                              ),
                            ))
                      

                      ],
                            ),
                  ),
                      
                      
                  ]),
            ),
          ],
        )));
  },
);
  }
}

