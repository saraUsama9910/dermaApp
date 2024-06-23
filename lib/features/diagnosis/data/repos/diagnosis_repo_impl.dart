// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:flutter/material.dart';
import 'package:graduation/core/api/api_consumer.dart';
import 'package:graduation/core/api/api_endPoints.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/errors/handle_error.dart';
import 'package:graduation/features/diagnosis/data/repos/diagnosis_repo.dart';

class DiagnosisRepoImplemntation implements DiagnosisRepo {
  ApiConsumer apiConsumer;
  DiagnosisRepoImplemntation({
    required this.apiConsumer,
  });

  @override
  Future<Either<String, String>> getDiagnosis(
      {required MultipartFile image}) async {
    try {
      final response = await apiConsumer.post(EndPoints.predict,
          data: {ApiKeys.file: image}, isFormData: true);
      return Right((response[ApiKeys.predicted_class_label]));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}
