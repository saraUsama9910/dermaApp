import 'package:flutter/material.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/diagnosis/peresntation/widgets/upload_image_button.dart';
import 'package:graduation/features/home/peresntation/views/widgets/line.dart';
import 'package:graduation/features/home/peresntation/views/widgets/quick_icons.dart';

import '../../../../core/utils/app_colors.dart';

class UploadImageView extends StatelessWidget {
  const UploadImageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.kkPrimaryColor,
          ),
        ),
        title: ResuableText(
          text: 'Skin Detection',
          color: AppColors.kkPrimaryColor,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          UploadImageButton(),


        ],
      ),
    );
  }
}
