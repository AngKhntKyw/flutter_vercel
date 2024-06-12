import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_vercel/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential?>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failure, UserCredential?>> logInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, String>> logOut();
}
