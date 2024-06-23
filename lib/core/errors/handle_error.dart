import 'package:dio/dio.dart';

import 'error_model.dart';

class ServerException implements Exception{

  final ErrorModel errorModel;
  ServerException(this.errorModel);

}

// ignore: non_constant_identifier_names
void HandleDioException(DioException e) {
  switch(e.type){

    case DioExceptionType.connectionTimeout:
      throw ServerException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch(e.response?.statusCode){
        case 400:
          throw ServerException(ErrorModel.fromJson(e.response!.data));
        case 401:
          throw ServerException(ErrorModel.fromJson(e.response!.data));
        case 403:
          throw ServerException(ErrorModel.fromJson(e.response!.data));
        case 404:
          throw ServerException(ErrorModel.fromJson(e.response!.data));
        case 409:
          throw ServerException(ErrorModel.fromJson(e.response!.data));
        case 422:
          throw ServerException(ErrorModel.fromJson(e.response!.data));
        case 502:
          throw ServerException(ErrorModel.fromJson(e.response!.data));


      }
  }
}