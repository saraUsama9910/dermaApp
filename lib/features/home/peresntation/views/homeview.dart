import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/home/peresntation/views/widgets/hi_home.dart';
import 'package:graduation/features/home/peresntation/views/widgets/list_view_items.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/image_constants.dart';

class HomeView extends StatefulWidget {
   HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String>imagesList=[
   ImageConstants.homeNavigationIcon,
    ImageConstants.diagnosisNavigationIcon,
    ImageConstants.communityNavigationIcon,
    ImageConstants.profileNavigationIcon,

  ];


  getIconName(int index)
  {
    switch(index)
    {
      case 0:
        return 'Home';
      case 1:
        return 'Diagnosis';
      case 2:
        return 'Forum';
      case 3:
        return 'Profile';

    }
  }

  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Stack(
          children: [
            HiHome(),
            ListViewItems(),
          ],
        ),

      bottomNavigationBar:AnimatedBottomNavigationBar.builder(
        tabBuilder: (index, isSelected)
        {
          return GestureDetector(
            onTap: ()
            {
                switch(index)
                {
                  case 0:
                    break;
                  case 1:
                    navigate(context: context, route: Routes.kUploadImageView);
                    break;
                  case 2:
                    navigate(context: context, route: Routes.allPostsScreen);
                    break;
                  case 3:
                    navigate(context: context, route: Routes.mainProfileScreen);

                }

            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsetsDirectional.only(top: 5.h),
                  child: SvgPicture.asset(imagesList[index], color: isSelected?AppColors.white:Colors.grey.withOpacity(.8),),
                ),
                SizedBox(height: 8.h,),
                ResuableText(text: '${getIconName(index)}', fontSize: 10.sp, color: isSelected?AppColors.white:Colors.grey.withOpacity(.8),),

              ],
            ),
          );
        },
      itemCount: imagesList.length,
      gapWidth: 5.w,
        height: 60.h,
        splashSpeedInMilliseconds: 300,
        activeIndex: currentIndex,
      gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 32,
      rightCornerRadius: 32,
      backgroundColor: AppColors.kkPrimaryColor,
      elevation: 0,

      onTap: (index) => setState(() => currentIndex = index),
      //other params
    ),
    );
  }
}

