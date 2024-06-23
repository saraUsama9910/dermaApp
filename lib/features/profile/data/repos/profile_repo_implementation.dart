


import 'package:dartz/dartz.dart';
import 'package:dio/src/multipart_file.dart';
import 'package:graduation/core/api/api_consumer.dart';
import 'package:graduation/core/api/api_endPoints.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/errors/handle_error.dart';
import 'package:graduation/features/profile/data/models/get_user_data_model/user_all_data_model.dart';
import 'package:graduation/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImplementation implements ProfileRepo
{
  
  final ApiConsumer apiConsumer;
  ProfileRepoImplementation({required this.apiConsumer});@override
  Future<Either<String, String>> updateProfile(
      { required String name,
        required String email,
        required String display_name,
      MultipartFile? profilePhoto,
      required num userId}) async {
    try
    {
      Map<String, dynamic> data = {};
       data[ApiKeys.name] = name;
       data[ApiKeys.email] = email;
       data[ApiKeys.display_name] = display_name;
      if (profilePhoto != null)
        data[ApiKeys.profile_picture] = profilePhoto;

      final response = await apiConsumer.post(
          EndPoints.updateProfileEndPoint(userId: userId),
          data: data,
          isFormData: true);
      return Right(response[ApiKeys.message]);
    }
    on ServerException catch (e)
    {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> changePassword({required num userId, required String oldPassword, required String newPassword, required String confirmNewPassword}) async
  {
    try
    {
      final response=await apiConsumer.post(EndPoints.changePasswordEndPoint(userId: userId),
        data:
          {
            ApiKeys.current_password:oldPassword,
            ApiKeys.new_password:newPassword,
            ApiKeys.new_password_confirmation:confirmNewPassword
          },
        isFormData: true
      );
      return Right(response[ApiKeys.message]);
    }on ServerException catch(e)
    {
      
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, UserAllDataModel>> getUserData({required num userId}) async
  {
   try
   {
     final response=await apiConsumer.get(EndPoints.getUserDataEndPoint(userId: userId));
     final UserAllDataModel userAllDataModel=UserAllDataModel.fromJson(response);

     return Right(userAllDataModel);

   }on ServerException catch(e)
    {
       return Left(e.errorModel.errorMessage);
    }

  }

  @override
  Future<Either<String, String>> deleteUser({required num userId,required String token}) async
  {
    try
    {
      final response=await apiConsumer.delete(EndPoints.deleteUserEndPoint(userId: userId,token: token));
      return Right(response[ApiKeys.message]);
    }on ServerException catch(e)
    {
      return Left(e.errorModel.errorMessage);
    }

  }
}