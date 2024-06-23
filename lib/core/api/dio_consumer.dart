import 'package:dio/dio.dart';

import '../errors/handle_error.dart';
import 'api_consumer.dart';
import 'api_endPoints.dart';
import 'api_interceptors.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptors());
    dio.interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        responseHeader: true,
        requestHeader: true,
        requestBody: true,
        error: true));
  }

  @override
  Future post(String path,
      {dynamic data,
      Map<String, dynamic>? queryParams,
      bool isFormData = false}) async {
    try {
      final response = await dio.post(path,
          data: isFormData ? FormData.fromMap(data) : data,
          queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      HandleDioException(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParams}) async {
    try {
      final response =
          await dio.get(path, data: data, queryParameters: queryParams);
      return response.data;
    } on DioException catch (e) {
      HandleDioException(e);
    }
  }

  @override
  Future<dynamic> delete(String pathName, {dynamic data, Map<String, dynamic>? queryParams,bool formData=false}) async {
    try{
      final response=await dio.delete(pathName,data :formData? FormData.fromMap(data):data,queryParameters: queryParams);
      return response.data;
    }on DioException catch(e)
    {
      HandleDioException(e);
    }
  }

  @override
  Future patch(String path, {Object? data, Map<String, dynamic>? queryParams}) {
    // TODO: implement patch
    throw UnimplementedError();
  }
}
