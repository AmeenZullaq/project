import 'package:dio/dio.dart';
import 'package:project/core/network/api_error_model.dart';
import 'package:project/core/network/status_codes.dart';

class ApiErrorHandler {
  const ApiErrorHandler();

  ApiErrorModel handle(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          return ApiErrorModel(
            errorMessage:
                'A connection error occurred. Please check your network and try again.',
            statusCode: LocalStatusCodes.connectionError,
          );
        case DioExceptionType.connectionTimeout:
          return ApiErrorModel(
            errorMessage: 'Connection timeout occurred.',
            statusCode: LocalStatusCodes.connectionTomeout,
          );
        case DioExceptionType.sendTimeout:
          return ApiErrorModel(
            errorMessage: 'Send timeout occurred.',
            statusCode: LocalStatusCodes.sendTimeout,
          );
        case DioExceptionType.receiveTimeout:
          return ApiErrorModel(
            errorMessage: 'Receive timeout occurred.',
            statusCode: LocalStatusCodes.receiveTimeout,
          );
        case DioExceptionType.badCertificate:
          return ApiErrorModel(
            errorMessage:
                'Secure connection failed. Please check your internet settings.',
            statusCode: LocalStatusCodes.badCertificate,
          );
        case DioExceptionType.badResponse:
          return handleBadResponse(e.response);
        case DioExceptionType.cancel:
          return ApiErrorModel(
            errorMessage: 'Request was cancelled.',
            statusCode: LocalStatusCodes.cancel,
          );
        case DioExceptionType.unknown:
          return ApiErrorModel(
            errorMessage: 'Opps there was an error, pleas try again',
            statusCode: LocalStatusCodes.unKnown,
          );
      }
    }
    return ApiErrorModel(
      errorMessage: 'Opps, There was an error, Pleas try again.',
      statusCode: LocalStatusCodes.unKnown,
    );
  }

  ApiErrorModel handleBadResponse(Response<dynamic>? response) {
    switch (response!.statusCode) {
      case 400:
        return const ApiErrorModel(
          errorMessage: 'Bad request.',
          statusCode: RemoteStatusCodes.badReqest,
        );
      case 401:
        return const ApiErrorModel(
          errorMessage: 'Unauthorized request. Please check your credentials.',
          statusCode: RemoteStatusCodes.unAuthorized,
        );
      case 403:
        return const ApiErrorModel(
          errorMessage:
              'Forbidden. You do not have permission to access this resource.',
          statusCode: RemoteStatusCodes.forbidden,
        );
      case 404:
        return const ApiErrorModel(
          errorMessage: 'Resource not found.',
          statusCode: RemoteStatusCodes.notFound,
        );
      case 422:
        return const ApiErrorModel(
          errorMessage: 'Validation error. Please check your input.',
          statusCode: RemoteStatusCodes.notValidation,
        );
      case 500:
        return const ApiErrorModel(
          errorMessage: 'Internal server error. Please try again later.',
          statusCode: RemoteStatusCodes.internalServer,
        );
      case 502:
        return const ApiErrorModel(
          errorMessage: 'Bad gateway.',
          statusCode: RemoteStatusCodes.badGateway,
        );
      case 503:
        return const ApiErrorModel(
          errorMessage: 'Service unavailable. Please try again later.',
          statusCode: RemoteStatusCodes.serviceUnavailable,
        );
      default:
        return const ApiErrorModel(
          errorMessage: 'Opps, There was an error, Pleas try again',
        );
    }
  }
}
