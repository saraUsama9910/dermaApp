import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation/core/commons/global_cubits/change_language_cubit/change_language_cubit.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/auth/cubits/login_cubit/login_cubit.dart';
import 'package:graduation/features/profile/presentation/widgets/language_widget.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangeLanguageCubit, ChangeLanguageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final changeLanguageCubit = BlocProvider.of<ChangeLanguageCubit>(context);
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              slivers:
              [
                SliverToBoxAdapter(child: SizedBox(height: 16.h,)),
                SliverToBoxAdapter(
                  child:Row(
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
                        text: 'Language',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.c242424,
                      )

                    ],
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 10.h,)),
                SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) =>
                        Padding(
                          padding: EdgeInsetsDirectional.symmetric(
                              vertical: 12.h, horizontal: 24.w),
                          child: LanguageWidget(
                            currentIndex: index,
                            languagesList: changeLanguageCubit.languagesList,
                             changeLanguageModel: changeLanguageCubit.languagesList[index],
                              maxWidth: MediaQuery
                                  .of(context)
                                  .size
                                  .width),
                        ),
                        childCount: changeLanguageCubit.languagesList.length
                    ))


              ],
            ),
          ),
        );
      },
    );
  }
}
