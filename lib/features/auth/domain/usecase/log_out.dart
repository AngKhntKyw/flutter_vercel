import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogOut implements FutureUseCase<String, LogOutParams> {
  final AuthRepository authRepository;
  const LogOut(this.authRepository);

  @override
  Future<Either<Failure, String>> call(LogOutParams params) async {
    return await authRepository.logOut();
  }
}

class LogOutParams {
  const LogOutParams();
}
