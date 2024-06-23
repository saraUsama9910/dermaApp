import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.kBlueColor),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.clear_all_outlined,
                color: AppColors.white,
                size: 30,
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: AppColors.white,
                size: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
