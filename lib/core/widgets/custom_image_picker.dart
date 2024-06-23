import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/resuable_text.dart';

class CustomImagePickerAvatar extends StatelessWidget {
  const CustomImagePickerAvatar({
    super.key,
    this.cameraOnTap,
    this.galleryOnTap,
    this.pickerWidth,
    this.pickerHeight,
    this.smallContainerWidth,
    this.smallContainerHeight,
    this.smallContainerTopValue,
    this.smallContainerBottomValue,
    this.smallContainerStartValue,
    this.smallContainerEndValue,
    this.smallContainerIcon,
    this.hasBottom = false,
    this.hasTop = false,
    this.hasStart = false,
    this.hasEnd = false,
    required this.image,
    this.hasCustomChild = false,
    this.customChild,
    this.fitState,
    this.smallContainerIconSize,
  });

  final VoidCallback? cameraOnTap;
  final VoidCallback? galleryOnTap;
  final double? pickerWidth;
  final double? pickerHeight;
  final double? smallContainerWidth;
  final double? smallContainerHeight;
  final double? smallContainerTopValue;
  final double? smallContainerBottomValue;
  final double? smallContainerStartValue;
  final double? smallContainerEndValue;
  final IconData? smallContainerIcon;
  final bool hasBottom;
  final bool hasTop;
  final bool hasStart;
  final bool hasEnd;
  final bool hasCustomChild;
  final ImageProvider<Object> image;
  final Widget? customChild;
  final BoxFit? fitState;
  final double? smallContainerIconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: (pickerWidth ?? 100).w,
        height: (pickerHeight ?? 100).h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.cE7ECF0,
            image: DecorationImage(
              image: image,

              fit: fitState ?? BoxFit.fill,
            )),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            PositionedDirectional(
              bottom: hasBottom ? (smallContainerBottomValue ?? -7).h : null,
              top: hasTop ? (smallContainerTopValue ?? 0).h : null,
              end: hasEnd ? (smallContainerEndValue ?? -2).w : null,
              start: hasStart ? (smallContainerStartValue ?? 0).w : null,
              child: hasCustomChild
                  ? GestureDetector(onTap: () async {}, child: customChild!)
                  : GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                backgroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 16.w, end: 16.w, top: 10.h),
                                      child: GestureDetector(
                                        onTap: cameraOnTap,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.camera_alt,
                                              size: 25.sp,
                                              color: AppColors.primaryColor,
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            const ResuableText(
                                              text: 'Camera',
                                              fontSize: 16,
                                              color: AppColors.cA98AB0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.only(
                                          start: 16.w, end: 16.w, bottom: 10.h),
                                      child: GestureDetector(
                                        onTap: galleryOnTap,
                                        child: Row(
                                          children: [
                                            Icon(Icons.photo,
                                                size: 25.sp,
                                                color: AppColors.primaryColor),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            const ResuableText(
                                              text: 'Gallery',
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        );
                      },
                      child: Container(
                        width: (smallContainerWidth ?? 35).w,
                        height: (smallContainerHeight ?? 35).h,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade300,
                        ),
                        child: Icon(
                          smallContainerIcon ?? Icons.camera_alt_outlined,
                          color: AppColors.kkPrimaryColor,
                          size: (smallContainerIconSize ?? 22).sp,
                        ),
                      ),
                    ),
            ),
          ],
        ));
  }
}
/*



 */
