import 'package:dio/dio.dart';
import 'package:project/core/network/errors/error_model.dart';
import 'package:project/core/network/errors/status_codes.dart';

class ApiErrorHandler {
  ErrorModel handle(dynamic e) {
    if (e is DioException) {
      switch (e.type) {
        case DioExceptionType.connectionError:
          return ErrorModel(
            errorMessage:
                'A connection error occurred. Please check your network and try again.',
            statusCode: LocalStatusCodes.connectionError,
          );
        case DioExceptionType.connectionTimeout:
          return ErrorModel(
            errorMessage: 'Connection timeout occurred.',
            statusCode: LocalStatusCodes.connectionTomeout,
          );
        case DioExceptionType.sendTimeout:
          return ErrorModel(
            errorMessage: 'Send timeout occurred.',
            statusCode: LocalStatusCodes.sendTimeout,
          );
        case DioExceptionType.receiveTimeout:
          return ErrorModel(
            errorMessage: 'Receive timeout occurred.',
            statusCode: LocalStatusCodes.receiveTimeout,
          );
        case DioExceptionType.badCertificate:
          return ErrorModel(
            errorMessage:
                'Secure connection failed. Please check your internet settings.',
            statusCode: LocalStatusCodes.badCertificate,
          );
        case DioExceptionType.badResponse:
          return handleBadResponse(e.response);
        case DioExceptionType.cancel:
          return ErrorModel(
            errorMessage: 'Request was cancelled.',
            statusCode: LocalStatusCodes.cancel,
          );
        case DioExceptionType.unknown:
          return ErrorModel(
            errorMessage: 'Opps there was an error, pleas try again',
            statusCode: LocalStatusCodes.unKnown,
          );
      }
    }
    return ErrorModel(
      errorMessage: 'Opps, There was an error, Pleas try again.',
      statusCode: LocalStatusCodes.unKnown,
    );
  }

  ErrorModel handleBadResponse(Response<dynamic>? response) {
    switch (response!.statusCode) {
      case 400:
        return const ErrorModel(
          errorMessage: 'Bad request.',
          statusCode: RemoteStatusCodes.badReqest,
        );
      case 401:
        return const ErrorModel(
          errorMessage: 'Unauthorized request. Please check your credentials.',
          statusCode: RemoteStatusCodes.unAuthorized,
        );
      case 403:
        return const ErrorModel(
          errorMessage:
              'Forbidden. You do not have permission to access this resource.',
          statusCode: RemoteStatusCodes.forbidden,
        );
      case 404:
        return const ErrorModel(
          errorMessage: 'Resource not found.',
          statusCode: RemoteStatusCodes.notFound,
        );
      case 422:
        return const ErrorModel(
          errorMessage: 'Validation error. Please check your input.',
          statusCode: RemoteStatusCodes.notValidation,
        );
      case 500:
        return const ErrorModel(
          errorMessage: 'Internal server error. Please try again later.',
          statusCode: RemoteStatusCodes.internalServer,
        );
      case 502:
        return const ErrorModel(
          errorMessage: 'Bad gateway.',
          statusCode: RemoteStatusCodes.badGateway,
        );
      case 503:
        return const ErrorModel(
          errorMessage: 'Service unavailable. Please try again later.',
          statusCode: RemoteStatusCodes.serviceUnavailable,
        );
      default:
        return const ErrorModel(
          errorMessage: 'Opps, There was an error, Pleas try again',
        );
    }
  }
}
