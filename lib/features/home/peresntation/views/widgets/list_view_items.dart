import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/features/home/peresntation/views/widgets/listviewitems/list_view_item.dart';
import 'package:graduation/features/home/peresntation/views/widgets/listviewitems/list_view_item2.dart';
import 'package:graduation/features/home/peresntation/views/widgets/listviewitems/list_view_item3.dart';
import 'package:graduation/features/home/peresntation/views/widgets/listviewitems/list_view_item4.dart';

class ListViewItems extends StatelessWidget {
  const ListViewItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: AppColors.white,
          ),
          child: SizedBox(
            height: 450.h,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    const ListViewItem(),
                    const ListViewItem2(),
                    const ListViewItem3(),
                    const ListViewItem4(),
                  ],
                ),
              ],
            ),
          ),
        ),

        // Container(
        //   color: AppColors.white,
        //   child: const QuickIcons(),
        // ),
      ],
    );
  }
}
