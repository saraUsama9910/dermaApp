import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/commons/constants.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/routes/routes.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/app_styles.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/onboarding/cubits/doctor_or_user_cubit/doctor_or_user_cubit.dart';

class DoctorOrUserScreen extends StatelessWidget {
  const DoctorOrUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DoctorOrUserCubit, DoctorOrUserCubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        final doctorOrUserCubit = BlocProvider.of<DoctorOrUserCubit>(context);
        return Scaffold(
            body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.cF7F8FC,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0, 0.3])),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    'Hello To Derma Scan',
                    style: AppStyles.textStyle(
                        color: AppColors.black,
                        weight: FontWeight.bold,
                        size: 18),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Center(
                  child: Text(
                    'Choose a way to login into the app',
                    style: AppStyles.textStyle(
                        color: AppColors.cA4ACAD,
                        weight: FontWeight.bold,
                        size: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 36.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        //doctor container
                        onTap: () {
                          doctorOrUserCubit.changeToDoctor();
                          CacheHelper().saveData(
                              key: AppConstants.isPatientKey,
                              value: doctorOrUserCubit.constantValue);
                          navigate(
                              context: context, route: Routes.kOnboardingView);
                          print(AppConstants.isPatient);
                        },
                        child: Container(
                          width: 140.w,
                          height: 145.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.black.withOpacity(.2),
                                width: 1.5.w),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Image.asset(
                                  ImageConstants.doctorContainerImage,
                                  fit: BoxFit.fill,
                                )),
                                SizedBox(
                                  height: 9.h,
                                ),
                                const ResuableText(
                                  text: 'Doctor',
                                  color: AppColors.c00243C,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 19.w,
                      ),
                      GestureDetector(
                        //patient container
                        onTap: () {
                          doctorOrUserCubit.changeToPatient();
                          CacheHelper().saveData(
                              key: AppConstants.isPatientKey,
                              value: doctorOrUserCubit.constantValue);
                          navigate(
                              context: context, route: Routes.kOnboardingView);
                          print(AppConstants.isPatient);
                        },
                        child: Container(
                          width: 140.w,
                          height: 145.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.black.withOpacity(.2),
                                  width: 1.5.w),
                              color: AppColors.white),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Column(
                              children: [
                                Expanded(
                                    child: Image.asset(
                                  ImageConstants.patientImage,
                                  fit: BoxFit.fill,
                                )),
                                SizedBox(
                                  height: 9.h,
                                ),
                                const ResuableText(
                                  text: 'Patinet',
                                  color: AppColors.c00243C,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: InkWell(
                    onTap: () {
                      navigate(context: context, route: Routes.kHomeView);
                    },
                    child: Container(
                      width: 100.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          color: AppColors.kBlueColor),
                      child: Center(
                        child: Text(
                          'Home',
                          style: AppStyles.textStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
      },
    );
  }
}


/*

*/