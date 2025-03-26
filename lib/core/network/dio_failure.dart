import 'package:dio/dio.dart';
import 'package:project/core/network/failrue.dart';

class DioFailure extends Failrue {
  const DioFailure({required super.errMessage});

  factory DioFailure.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return const DioFailure(
          errMessage: 'Connection timeout occurred.',
        );
      case DioExceptionType.sendTimeout:
        return const DioFailure(
          errMessage: 'Send timeout occurred.',
        );
      case DioExceptionType.receiveTimeout:
        return const DioFailure(
          errMessage: 'Receive timeout occurred.',
        );
      case DioExceptionType.badCertificate:
        return const DioFailure(
          errMessage:
              'Secure connection failed. Please check your internet settings.',
        );
      case DioExceptionType.badResponse:
        return DioFailure.fromBadResponse(
          response: e.response,
        );
      case DioExceptionType.cancel:
        return const DioFailure(
          errMessage: 'Request was cancelled.',
        );
      case DioExceptionType.connectionError:
        return const DioFailure(
          errMessage:
              'A connection error occurred. Please check your network and try again.',
        );
      case DioExceptionType.unknown:
        return const DioFailure(
          errMessage: 'Opps there was an error, pleas try again',
        );
    }
  }

  factory DioFailure.fromBadResponse({
    Response<dynamic>? response,
  }) {
    switch (response!.statusCode) {
      case 400:
        return const DioFailure(
          errMessage: 'Bad request.',
        );
      case 401:
        return const DioFailure(
          errMessage: 'Unauthorized request. Please check your credentials.',
        );
      case 403:
        return const DioFailure(
          errMessage:
              'Forbidden. You do not have permission to access this resource.',
        );
      case 404:
        return const DioFailure(
          errMessage: 'Resource not found.',
        );
      case 422:
        return const DioFailure(
          errMessage: 'Validation error. Please check your input.',
        );
      case 500:
        return const DioFailure(
          errMessage: 'Internal server error. Please try again later.',
        );
      case 502:
        return const DioFailure(
          errMessage: 'Bad gateway.',
        );
      case 503:
        return const DioFailure(
          errMessage: 'Service unavailable. Please try again later.',
        );
      default:
        return const DioFailure(
          errMessage: 'Opps, there was an error, Pleas try again',
        );
    }
  }
}
