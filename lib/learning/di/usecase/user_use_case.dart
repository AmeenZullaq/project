import 'package:injectable/injectable.dart';
import 'package:qr_flutter/features/di/repos/user_repo.dart';

@LazySingleton()
class UserUseCase {
  final UserRepo userRepo;

  UserUseCase({required this.userRepo});

  Future<String> call() async {
    return userRepo.getUserInfo();
  }
}
