

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation/features/auth/data/models/login_model/LoginModel.dart';

abstract class AuthRepo
{
  Future<Either<String,LoginModel>>login({required String email,required String password});
  Future<Either<String,String>>register({
    required String name,
    required String email,
    required String displayName,
    required String password,
    required String passwordConfirmation,
    required String gender,
    required String type,
    MultipartFile? profilePic,
    MultipartFile? medicalLisence,
  });

  Future<Either<String,String>>forgotPassword({required String email});
}