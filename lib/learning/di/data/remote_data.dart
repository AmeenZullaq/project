import 'package:injectable/injectable.dart';

/// @LazySingleto // we can not put it here, because abstract class can not inistanishiated
abstract class UserRemoteDataSource {
  Future<String> getUser();
}

@LazySingleton(as: UserRemoteDataSource)

/// we pute this parameter as: UserRemoteDataSource to generate
/// this getIt.registerSingleton<UserRemoteDataSource>(UserRemoteDataSourceImpl);
/// 
/// if we type only @LazySingleton()
/// getIt.registerSingleton<UserRemoteDataSourceImpl>(UserRemoteDataSourceImpl);
class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  @override
  Future<String> getUser() async {
    return "Ali";
  }
}
