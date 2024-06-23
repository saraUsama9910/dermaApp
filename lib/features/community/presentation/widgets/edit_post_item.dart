

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';

class EditPostItem extends StatelessWidget {
  const EditPostItem({super.key, required this.postItemText, required this.postItemImage, this.onTap});

  final String postItemText;
  final IconData postItemImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return  Container(

      child: Column(
        children:
        [
           const LineWidget(),
           SizedBox(height: 10.h,),
           GestureDetector(
             onTap: onTap,
             child: Row(
              children:
              [
                SizedBox(width: 10.w,),
               Icon(postItemImage,color: AppColors.kkPrimaryColor,),
               SizedBox(width: 10.w,),
               ResuableText(
                   text: postItemText,
                   color: AppColors.black,
               )
              ],
                       ),
           ),
          SizedBox(height: 10.h,),
          const LineWidget(),

        ],
      ),
    );
  }
}
