

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/profile/data/models/profile_items_model/profile_item_model.dart';
import 'package:graduation/features/profile/presentation/widgets/logout_widget.dart';
import 'package:share_plus/share_plus.dart';

class MainprofileSettingsItem extends StatelessWidget {
  const MainprofileSettingsItem({super.key,required this.profileItem, required this.maxWidth, required this.currentIndex});

  final ProfileItemModel profileItem ;
  final int currentIndex;

  final double maxWidth;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async
      {
        switch(currentIndex)
        {
          case 0:
            navigate(context: context, route: Routes.editProfileScreen);
            break;
          case 1:
            navigate(context: context, route: Routes.languageScreen);
            break;
          case 2:
            break;
          case 3:
            try {
              final String message='Spread the word about our app!\n                com.example.graduation_project';
              await Share.share(message);
              print('Thank you for sharing my website!');
            } catch (e)
            {
              print('Error sharing: $e');
            }
            break;
          case 4:
            navigate(context: context, route: Routes.faqScreen);
            break;
          case 5:
            break;
          case 6:
            showDialog(context: context,
              builder: (context) => AlertDialog(
                content: LogoutWidget(),
                contentPadding: EdgeInsetsDirectional.zero,

              ),
            );
            break;




        }
      },
      child: Container(
        width: maxWidth,
        height: 50.h,
       decoration: BoxDecoration(
         border: Border(
           bottom: BorderSide(
              color: Colors.grey.withOpacity(.3),
           )
         )
       ),
       child: Row(
         children:
         [
          SizedBox(
              width: 18.w,
              height: 18.h,
              child: SvgPicture.asset(profileItem.image)),
          SizedBox(width: 10.w,),
         ResuableText(
           text: profileItem.title,
           color: AppColors.c242424,
           fontSize: 14,
           fontWeight: FontWeight.w400,),
           Spacer(),
           SvgPicture.asset(ImageConstants.arrowRightProfileIcon,color: AppColors.kkPrimaryColor,),
         ],
       ),
      ),
    );
  }
}
