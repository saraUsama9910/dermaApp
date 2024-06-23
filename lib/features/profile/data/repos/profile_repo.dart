



import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation/features/profile/data/models/get_user_data_model/user_all_data_model.dart';

abstract class ProfileRepo
{

  Future<Either<String,String>>updateProfile({required String name,required String email,required String display_name,MultipartFile? profilePhoto,required num userId});
  Future<Either<String,String>>changePassword({required num userId,required String oldPassword,required String newPassword,required String confirmNewPassword});
  Future<Either<String,UserAllDataModel>>getUserData({required num userId});
  Future<Either<String,String>>deleteUser({required num userId,required String token});




}