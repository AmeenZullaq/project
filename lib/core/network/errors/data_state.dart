import 'package:project/core/network/errors/error_model.dart';
import 'package:project/core/network/dio/api_service.dart';

abstract class DataState<T> {}

class DataSuccess<T> extends DataState<T> {
  final T data;
  DataSuccess({required this.data});
}

class DataFailure<T> extends DataState<T> {
  final ErrorModel error;
  DataFailure({required this.error});
}

class RepoImpl {
  final ApiService apiService;

  RepoImpl({required this.apiService});

  Future<DataState<ProductEntity>> getProducts() async {
    try {
      final data = await apiService.get(endpoint: 'get products');
      ProductEntity finalData = ProductEntity.fromJson(data);
      return DataSuccess(data: finalData);
    } catch (e) {
      return DataFailure(
        error: ErrorModel(errorMessage: 'errorMessage'),
      );
    }
  }
}

class ProductEntity {
  final String name;

  ProductEntity({required this.name});
  factory ProductEntity.fromJson(dynamic json) {
    return ProductEntity(
      name: json['name'],
    );
  }
}
