import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogInWithEmailAndPassword
    implements FutureUseCase<UserCredential?, LogInWithEmailAndPasswordParams> {
  final AuthRepository authRepository;
  const LogInWithEmailAndPassword(this.authRepository);

  @override
  Future<Either<Failure, UserCredential?>> call(
      LogInWithEmailAndPasswordParams params) async {
    return await authRepository.logInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LogInWithEmailAndPasswordParams {
  final String email;
  final String password;
  const LogInWithEmailAndPasswordParams({
    required this.email,
    required this.password,
  });
}
