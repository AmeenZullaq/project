import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:qr_flutter/features/di/usecase/user_use_case.dart';

part 'user_state.dart';
@Injectable()// make factory pattern
class UserCubit extends Cubit<UserState> {
  UserCubit(this.userUseCase) : super(UserInitial());

  final UserUseCase userUseCase;

  Future<String> getUser() async {
    String user = await userUseCase.call();
    return user;
  }
}
