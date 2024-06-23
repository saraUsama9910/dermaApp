import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/features/onboarding/peresntation/views/widgets/content_model.dart';

import '../../../../core/utils/app_colors.dart';

class OnbordingView extends StatefulWidget {
  const OnbordingView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<OnbordingView> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80.h,
                      ),
                      Image.asset(
                        contents[i].image,
                        height: 330.h,
                        width: 300.w,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        contents[i].title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.kGreyColor,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              contents.length,
              (index) => buildDot(index, context),
            ),
          ),
          Container(
            height: 40.h,
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            child: FloatingActionButton(
              backgroundColor: AppColors.kBlueColor,
              onPressed: () {
                if (currentIndex == contents.length - 1) {
                  Navigator.pushNamed(context, Routes.kWelcomeView);
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.bounceIn,
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                currentIndex == contents.length - 1 ? "Continue" : "Next",
                style: const TextStyle(color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10.h,
      width: currentIndex == index ? 16 : 8,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
