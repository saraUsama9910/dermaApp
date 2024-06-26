import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';

class ListViewItem2 extends StatelessWidget {
  const ListViewItem2({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          height: 80.h,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(32)),
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.kkPrimaryColor],
              )),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 4 / 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 2, top: 5),
                  child: Container(
                    // height: MediaQuery.of(context).size.height * .3,
                    // width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(ImageConstants.hospital),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 20.w),
                child: Text(
                  'Appointment',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
