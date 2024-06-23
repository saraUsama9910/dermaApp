import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar(
      {super.key,
      this.leading,
      this.title,
      this.actions,
      required this.hasLeading,
      required this.hasTitle,
      required this.hasActions,
      this.startPAddingValue,
      this.spaceAfterLeading,
      this.spaceAfterActions});

  final bool hasLeading;
  final bool hasTitle;
  final bool hasActions;
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;
  final double? startPAddingValue;
  final double? spaceAfterLeading;
  final double? spaceAfterActions;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50.h,
      child: Row(children: [
        if (hasLeading)
          Padding(
            padding:
                EdgeInsetsDirectional.only(start: (startPAddingValue ?? 15).w),
            child: leading!,
          ),
        spaceAfterLeading != null
            ? SizedBox(
                width: spaceAfterLeading!,
              )
            : const Spacer(),
        if (hasTitle) title!,
        const Spacer(),
        if (hasActions) ...actions!,
        spaceAfterActions != null
            ? SizedBox(
                width: spaceAfterActions!,
              )
            : const SizedBox.shrink(),
      ]),
    );
  }
}
