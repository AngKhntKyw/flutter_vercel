// //import 'dart:io';
// import 'package:flutter_vercel/core/error/failure.dart';
// import 'package:flutter_vercel/core/usecase/usecase.dart';
// import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
// import 'package:fpdart/fpdart.dart';

// class ChangeProfileImage
//     implements FutureUseCase<Null, ChangeProfileImageParams> {
//   final UserRepository userRepository;
//   const ChangeProfileImage(this.userRepository);

//   @override
//   Future<Either<Failure, Null>> call(ChangeProfileImageParams params) async {
//     return await userRepository.changeProfileImage(
//         image_file: params.image_file);
//   }
// }

// class ChangeProfileImageParams {
//   final File image_file;
//   const ChangeProfileImageParams({
//     required this.image_file,
//   });
// }
