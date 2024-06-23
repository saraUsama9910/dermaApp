import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/core/api/dio_consumer.dart';
import 'package:graduation/core/commons/functions.dart';
import 'package:graduation/core/utils/app_colors.dart';
import 'package:graduation/core/utils/image_constants.dart';
import 'package:graduation/core/widgets/resuable_text.dart';
import 'package:graduation/features/diagnosis/data/repos/diagnosis_repo_impl.dart';
import 'package:graduation/features/diagnosis/peresntation/cubits/dignosis_cubit/diagnosis_cubit_cubit.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageButton extends StatelessWidget {
  const UploadImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiagnosisCubitCubit(
          diagnosisRepoImplemntation:
              DiagnosisRepoImplemntation(apiConsumer: DioConsumer(dio: Dio()))),
      child: BlocConsumer<DiagnosisCubitCubit, DiagnosisCubitState>(
        listener: (context, state) {
          if (state is GetDiagnosisResultSuccessState) {
            showToast(
                msg: "Result returned Successfullt",
                toastStates: ToastStates.success);
          }
          if (state is GetDiagnosisResultFailureState) {
            showToast(
                msg: "Error ocuured With request",
                toastStates: ToastStates.success);
          }
        },
        builder: (context, state) {
          final diagnosisCubit = BlocProvider.of<DiagnosisCubitCubit>(context);
          return Center(
              child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Card(
                elevation: 20,
                clipBehavior: Clip.hardEdge,
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        diagnosisCubit.diagnosisPhoto == null
                            ? Container(
                                width: 290.w,
                                height: 280.h,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            ImageConstants.uploadIconn),
                                        fit: BoxFit.fill)))
                            : Container(
                                width: 290.w,
                                height: 280.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: FileImage(File(
                                          diagnosisCubit.diagnosisPhoto!.path)),
                                      fit: BoxFit.fill),
                                )),
                        const SizedBox(
                          height: 30,
                        ),
                        state is GetDiagnosisResultLoadingState
                            ? SizedBox(
                                width: 25.w,
                                height: 25.h,
                                child: const CircularProgressIndicator(
                                  color: AppColors.cA98AB0,
                                  strokeWidth: 1,
                                ))
                            : state is GetDiagnosisResultSuccessState
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Text(
                                          'The Result',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          state.disease,
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Label',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          'Error Ocuured',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Confidence',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: AppColors.cD4C4D7,
                        contentPadding: EdgeInsetsDirectional.zero,
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await imagePick(imageSource: ImageSource.camera)
                                    .then(
                                  (value) {
                                    diagnosisCubit.addDiagnosisPhoto(
                                        image: value!);
                                  },
                                );
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Container(
                                      width: 35.w,
                                      height: 30.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.cA98AB0,
                                      ),
                                      child: const Center(
                                          child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: AppColors.white,
                                      ))),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  const ResuableText(
                                    text: 'Take from camera',
                                    color: AppColors.white,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            GestureDetector(
                              onTap: () {
                                imagePick(imageSource: ImageSource.gallery)
                                    .then(
                                  (value) {
                                    diagnosisCubit.addDiagnosisPhoto(
                                        image: value!);
                                  },
                                );
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Container(
                                      width: 35.w,
                                      height: 30.h,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.cA98AB0,
                                      ),
                                      child: const Center(
                                          child: Icon(
                                        Icons.photo_size_select_actual_outlined,
                                        color: AppColors.white,
                                      ))),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  const ResuableText(
                                    color: AppColors.white,
                                    text: 'Take from gallery',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: AppColors.kkPrimaryColor,
                    foregroundColor: Colors.white),
                child: const Text(
                  "Take a photo",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  diagnosisCubit.addPhotoForDiagnosis(
                      image: diagnosisCubit.diagnosisPhoto!);
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: AppColors.kkPrimaryColor,
                    foregroundColor: Colors.white),
                child: const Text(
                  "Show the result",
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  diagnosisCubit.deleteTheCurrentPhoto();
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: AppColors.kkPrimaryColor,
                    foregroundColor: Colors.white),
                child: const Text(
                  "Delete the current photo",
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
