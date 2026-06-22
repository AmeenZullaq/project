// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:qr_flutter/features/di/cubits/cubit/user_cubit.dart' as _i1057;
import 'package:qr_flutter/features/di/data/remote_data.dart' as _i785;
import 'package:qr_flutter/features/di/repos/user_repo.dart' as _i75;
import 'package:qr_flutter/features/di/repos/user_repo_impl.dart' as _i902;
import 'package:qr_flutter/features/di/usecase/user_use_case.dart' as _i892;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i785.UserRemoteDataSource>(
        () => _i785.UserRemoteDataSourceImpl());
    gh.lazySingleton<_i75.UserRepo>(() => _i902.UserRepoImple(
        userRemoteDataSource: gh<_i785.UserRemoteDataSource>()));
    gh.lazySingleton<_i892.UserUseCase>(
        () => _i892.UserUseCase(userRepo: gh<_i75.UserRepo>()));
    gh.factory<_i1057.UserCubit>(
        () => _i1057.UserCubit(gh<_i892.UserUseCase>()));
    return this;
  }
}
