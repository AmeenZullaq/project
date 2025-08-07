import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project/core/constants/app_endpoints.dart';
import 'package:project/core/network/dio/api_service.dart';
import 'package:project/core/network/dio/dio_interceptor.dart';

class ApiServiceImpl extends ApiService {
  final Dio dio;

  ApiServiceImpl({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: AppEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      sendTimeout: const Duration(seconds: 60),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    dio.interceptors.addAll([
      DioInterceptorWrapper(dio: dio),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        enabled: true,
        compact: true,
        maxWidth: 90,
      ),
    ]);
  }

  @override
  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    bool ieRequireToken = true,
  }) async {
    final response = await dio.get(
      endpoint,
      queryParameters: queryParameters,
      options: Options(
        extra: {'isRequireToken': ieRequireToken},
      ),
    );
    return response;
  }

  @override
  Future<dynamic> post({
    required String endpoint,
    dynamic data,
    bool ieRequireToken = true,
    // bool isMultipart = false,
  }) async {
    final response = await dio.post(
      endpoint,
      data: data,
      options: Options(
        extra: {'isRequireToken': ieRequireToken},
        // Dio automatically handle header when we use formdata , look on CHATGPT
        // headers: {
        //   'Content-Type':
        //       isMultipart ? 'multipart/form-data' : 'application/json',
        //   'Accept': 'application/json',
        // },
      ),
    );
    return response;
  }

  @override
  Future<dynamic> put({
    required String endpoint,
    dynamic data,
    bool ieRequireToken = true,
  }) async {
    final response = await dio.put(
      endpoint,
      data: data,
      options: Options(
        extra: {'isRequireToken': ieRequireToken},
      ),
    );
    return response;
  }

  @override
  Future<dynamic> delete({
    required String endpoint,
    dynamic data,
    bool ieRequireToken = true,
  }) async {
    final response = await dio.delete(
      endpoint,
      data: data,
      options: Options(
        extra: {'isRequireToken': ieRequireToken},
      ),
    );
    return response;
  }
}
