import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class DiagnosisRepo {
  Future<Either<String, String>> getDiagnosis({required MultipartFile image});
}
