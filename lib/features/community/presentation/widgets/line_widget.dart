

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/utils/app_colors.dart';


class LineWidget extends StatelessWidget {
  const LineWidget({super.key, this.color, this.height});

  final Color? color;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height??1).h,
      color: color?? AppColors.cF1F1F0,
    );
  }
}
