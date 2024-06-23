import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/profile/data/models/settings_data_model.dart';
import 'package:graduation/features/profile/presentation/widgets/settings_item_widget.dart';

class SettingsScreen extends StatefulWidget {

  @override
  State<SettingsScreen> createState() => SettingsScreenState();
}
   final List<SettingsDataModel> settingsDataList=[
     SettingsDataModel(settingName: 'Change Password', iconForm: Icons.lock_outlined),
     SettingsDataModel(settingName: 'Delete Account', iconForm: Icons.cancel_outlined),
     SettingsDataModel(settingName: 'Dark Mode', iconForm:FontAwesomeIcons.moon)


   ];
class SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {


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
                  SizedBox(width: 100.w,),
                  ResuableText(
                    text: 'Settings',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.c242424,
                  )

                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h,)),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding:  EdgeInsetsDirectional.only(start: 20.w,end: 20.w,top: 10.h),
                        child: SettingsItemWidget(
                          currentIndex: index,
                          settingsDataModel: settingsDataList[index],
                        ),
                      ),
                  childCount: settingsDataList.length,
                )),

          ],
        ),
      ),
    );
  }

}






