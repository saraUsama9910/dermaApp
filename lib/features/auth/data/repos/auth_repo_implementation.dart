
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/api/api_consumer.dart';
import 'package:graduation/core/api/api_endPoints.dart';
import 'package:graduation/core/api/api_keys.dart';
import 'package:graduation/core/cache/cache_helper.dart';
import 'package:graduation/core/errors/handle_error.dart';
import 'package:graduation/features/auth/data/models/login_model/LoginModel.dart';
import 'package:graduation/features/auth/data/repos/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoImplementation implements AuthRepo
{
  final ApiConsumer api;
  AuthRepoImplementation({required this.api});
  @override
  Future<Either<String,LoginModel>> login({required String email, required String password}) async
  {
    try
    {
      final response=await api.post(
        EndPoints.login,
        data: {
          ApiKeys.email:email,
          ApiKeys.password:password
        }
      );
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      LoginModel loginModel=LoginModel.fromJson(response);
      CacheHelper().saveData(key: ApiKeys.token, value: loginModel.user!.apiToken);
      CacheHelper().saveData(key: ApiKeys.id, value:  loginModel.user!.id);
      CacheHelper().saveData(key: ApiKeys.email, value: loginModel.user!.email!);
      CacheHelper().saveData(key: ApiKeys.display_name, value: loginModel.user!.displayName);
      CacheHelper().saveData(key: ApiKeys.name, value: loginModel.user!.name);
      CacheHelper().saveData(key: ApiKeys.gender, value: loginModel.user!.gender);
      CacheHelper().saveData(key: ApiKeys.type, value: loginModel.user!.type);
      CacheHelper().saveData(key: ApiKeys.profile_picture, value: loginModel.user!.profilePicture);



      return Right(loginModel);
    } on ServerException catch (e)
    {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> register({required String name, required String email, required String displayName, required String password, required String passwordConfirmation, required String gender, required String type, MultipartFile? profilePic, MultipartFile? medicalLisence}) async
  {
    try {
      Map<String, dynamic> data = {};
      data[ApiKeys.name] = name;
       data[ApiKeys.email] = email;
       data[ApiKeys.display_name] = displayName;
      data[ApiKeys.password] = password;
      data[ApiKeys.password_confirmation] = passwordConfirmation;
       data[ApiKeys.gender] = gender;
      data[ApiKeys.type] = type;
      if (profilePic != null) data[ApiKeys.profile_picture] = profilePic;
      if (medicalLisence != null) data[ApiKeys.medical_license] = medicalLisence;

      final response = await api.post(
        EndPoints.register,
        data: data,
        isFormData: true,
      );

      return Right(response[ApiKeys.message]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, String>> forgotPassword({required String email}) async
  {
    try
    {
      final response=await api.post(
        EndPoints.forgotPassword,
        data: {
          ApiKeys.email:email
        }
      );
      return Right(response[ApiKeys.message]);

    } on ServerException catch (e)
    {
      return Left(e.errorModel.errorMessage);
    }
  }





}