import 'package:injectable/injectable.dart';
import 'package:qr_flutter/features/di/data/remote_data.dart';
import 'package:qr_flutter/features/di/repos/user_repo.dart';

@LazySingleton(as: UserRepo)
class UserRepoImple extends UserRepo {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepoImple({required this.userRemoteDataSource});
  @override
  Future<String> getUserInfo() async {
    String user = await userRemoteDataSource.getUser();
    return user;
  }
}
