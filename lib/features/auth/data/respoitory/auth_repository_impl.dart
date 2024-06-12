import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vercel/core/error/exception.dart';
import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_vercel/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserCredential?>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return getUser(() async => await authRemoteDataSource
        .signUpWithEmailPassword(name: name, email: email, password: password));
  }

  Future<Either<Failure, UserCredential?>> getUser(
      Future<UserCredential?> Function() fn) async {
    try {
      final user = await fn();
      return right(user!);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    return getUser(() async => await authRemoteDataSource
        .logInWithEmailPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, String>> logOut() async {
    try {
      await authRemoteDataSource.logOut();
      return right("Logout Success");
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
