import 'package:dio/dio.dart';
import 'package:project/core/constants/app_endpoints.dart';
import 'package:project/core/constants/app_keys.dart';
import '../../storage/shared_preferences.dart';

class DioInterceptorWrapper implements InterceptorsWrapper {
  final Dio dio;

  DioInterceptorWrapper({required this.dio});
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    if (options.extra['isRequireToken'] == true) {
      if (SharedPrefs.getString(AppKeys.accessToken) != null) {
        options.headers['Authorization'] =
            'Bearer ${SharedPrefs.getString(AppKeys.accessToken)}';
      }
    }
    handler.next(options); // Pass the request to the next handler
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    handler.next(response); // Pass the response to the next handler
  }

  @override
  void onError(
    DioException ex,
    ErrorInterceptorHandler handler,
  ) async {
    if (ex.response?.statusCode == 401) {
      final isRefreshed = await _refreshAccessToken();
      if (isRefreshed) {
        // Retry the original request with the new access token
        final options = ex.requestOptions;
        options.headers['Authorization'] =
            'Bearer ${SharedPrefs.getString(AppKeys.accessToken)}';
        try {
          final response = await dio.fetch(options);
          handler.resolve(response);
        } catch (error) {
          handler.reject(
            error as DioException,
          );
        }
      }
    }
    handler.next(ex);
  }

  Future<bool> _refreshAccessToken() async {
    try {
      final response = await dio.post(
        AppEndpoints.refreshToken,
        data: {
          'refreshToken': SharedPrefs.getString(AppKeys.refreshToken),
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        await SharedPrefs.setString(
          AppKeys.accessToken,
          response.data['accessToken'],
        );
        await SharedPrefs.setString(
          AppKeys.refreshToken,
          response.data['refreshToken'],
        );
        return true; // Indicate that the refresh was successful
      } else {
        return false; // Indicate that the refresh failed
      }
    } catch (e) {
      return false; // Indicate that the refresh failed
    }
  }
}

///****************** handler.next() *******************///
// handler.next() tells Dio to continue processing the request, response, or error
// after your interceptor has done its job.
// It ensures that Dio moves to the next step in its internal logic
// or the next interceptor (if any) to complete the request-response cycle.

///******************* final response = await dio.fetch(options);  *******************///
//Why we use it: In the context of retrying a request, we use fetch because
//it allows us to directly resend the original request using the updated
//options (e.g., with a new access token). This way, we don't have to know
//whether the original request was a GET, POST, PUT, etc.—we just retry it as it was.

/// ******************************** ///
//1. handler.next(error):
// Purpose: Passes the error to the next interceptor in the chain or to the final error handler if there are no more interceptors.
// When to use: You should use handler.next when you want to continue processing the error as is, without modifying or retrying the request.
// Limitations: handler.next doesn't allow you to change the state of the error into a success response. It simply propagates the error to be handled downstream.

//2. handler.resolve(response):
// Purpose: Converts the error state into a success state by providing a valid response. It effectively stops the error handling and passes the successful response to the original request handler.
// When to use: Use handler.resolve when you have successfully retried the request (after refreshing a token, for example) and want to treat the new response as if it was the original response.

//3. handler.reject(error):
// Purpose: Passes the error to the next interceptor or error handler in the chain, indicating that the request has failed.
// When to use: Use handler.reject when the retry of the request has also failed, and you want to make sure that the error state is maintained and passed back to the caller.
