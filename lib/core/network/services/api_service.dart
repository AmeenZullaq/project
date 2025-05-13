abstract class ApiService {
  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    bool ieRequireToken = true,
  });
  Future<dynamic> post({
    required String endpoint,
    dynamic data,
    bool ieRequireToken = true,
  });
  Future<dynamic> put({
    required String endpoint,
    dynamic data,
    bool ieRequireToken = true,
  });
  Future<dynamic> delete({
    required String endpoint,
    dynamic data,
    bool ieRequireToken = true,
  });
}
