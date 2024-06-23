import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation/core/commons/global_cubits/change_theme_cubit/change_theme_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/profile/presentation/widgets/dark_mode_item_widget.dart';

import '../../../community/presentation/widgets/line_widget.dart';

class ScreenModes extends StatelessWidget {
   ScreenModes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeThemeCubit, ChangeThemeState>(
      listener: (context, state)
      {
        // TODO: implement listener
      },
      builder: (context, state) {
        final changeThemeCubit = BlocProvider.of<ChangeThemeCubit>(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
              children:
              [

                SizedBox(height: 16.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Padding(
                      padding:  EdgeInsetsDirectional.only(start: 16.w),
                      child: GestureDetector(
                          onTap: ()
                          {
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
                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SvgPicture.asset(ImageConstants.arrowBackProfileIcon,
                                color: AppColors.black,width: 6.w,height: 12.h,

                                fit: BoxFit.contain,),
                            ),
                          )),

                    ),
                    SizedBox(width: 88.5,),
                    ResuableText(
                      text: 'Dark Mode',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.c242424,
                    )

                  ],
                ),
                SizedBox(height: 10.h,),
                LineWidget(
                  height: 1.5,
                  color: AppColors.cEBEBEB,
                ),
                Expanded(
                  child: ListView.separated(
                      padding:  EdgeInsetsDirectional.only(start: 15.w,end: 15.w,top: 10.h),
                      itemBuilder: (context, index) =>
                          DarkModeItemWidget(
                           currentIndex: index,
                            darkModeDataList: changeThemeCubit.darkModeDataList,
                          ),
                      separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                      itemCount:  changeThemeCubit.darkModeDataList.length),
                )


              ],
            ),
          ),
        );
      },
    );
  }
}
