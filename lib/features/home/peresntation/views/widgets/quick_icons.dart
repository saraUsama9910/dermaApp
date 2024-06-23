import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/routes/routes.dart';

import 'navigation_bar_item.dart';

class QuickIcons extends StatefulWidget {
  const QuickIcons({super.key});

  @override
  State<QuickIcons> createState() => _QuickIconsState();
}

class _QuickIconsState extends State<QuickIcons> {
  List<bool> isSelected = [false, false, false, false];
  int currentIndex = 0;

  List<IconData> icons = [
    Icons.home,
    Icons.medical_services,
    Icons.domain_add_sharp,
    Icons.account_circle
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 15.w,top: 6.h,bottom: 8.h),
      child: SizedBox(
        height: 50.h,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
            padding: EdgeInsetsDirectional.zero,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    currentIndex = index;
                    setState(() {});
                    if (index == 0) {}
                    if (index == 2) {}
                    if(index==3)
                      {
                        navigate(context: context, route: Routes.mainProfileScreen);
                      }
                  },
                  child: NavigationBarItem(
                    isSelected: index == currentIndex,
                    icon: icons[index],
                  ),
                ),
            separatorBuilder: (context, index) => SizedBox(
                  width: 30.w,
                ),
            itemCount: 4),
      ),
    );
  }
}
