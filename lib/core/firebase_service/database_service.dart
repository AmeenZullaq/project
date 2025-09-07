abstract class DatabaseService {
  Future<void> addData({
    required String path, // collection
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<dynamic> getData({
    required String path,
    String? documentId,
    Map<String, dynamic>? queryParameters,
  });

  Future<void> updateData({
    required String path,
    required String documentId,
    required Map<String, dynamic> data,
  });

  Future<bool> checkIfDataExists({
    required String path,
    required String docuementId,
  });
}
