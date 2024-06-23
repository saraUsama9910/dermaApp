import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/community/presentation/widgets/line_widget.dart';
import 'package:graduation/features/profile/data/models/settings_data_model.dart';
import 'package:graduation/features/profile/presentation/widgets/delete_account_widget.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    required this.settingsDataModel,
    required this.currentIndex,
  });

  final SettingsDataModel settingsDataModel;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (currentIndex) {
          case 0:
            navigate(context: context, route: Routes.changePasswordScreen);

          case 1:
            showModalBottomSheet(
                context: context,
                builder: (context) => const DeleteAccountwidget());

          case 2:
            navigate(context: context, route: Routes.screenModes);
        }
      },
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  settingsDataModel.iconForm,
                  color: AppColors.kkPrimaryColor,
                ),
                SizedBox(
                  width: 10.w,
                ),
                ResuableText(text: settingsDataModel.settingName),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.kkPrimaryColor,
                  size: 17.sp,
                ),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            LineWidget(
              height: 1,
              color: Colors.grey.withOpacity(.5),
            ),
          ],
        ),
      ),
    );
  }
}
