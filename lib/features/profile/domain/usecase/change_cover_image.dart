// // ignore_for_file: non_constant_identifier_names

// //import 'dart:io';
// import 'package:flutter_vercel/core/error/failure.dart';
// import 'package:flutter_vercel/core/usecase/usecase.dart';
// import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
// import 'package:fpdart/fpdart.dart';

// class ChangeCoverImage implements FutureUseCase<Null, ChangeCoverImageParams> {
//   final UserRepository userRepository;
//   const ChangeCoverImage(this.userRepository);

//   @override
//   Future<Either<Failure, Null>> call(ChangeCoverImageParams params) async {
//     return await userRepository.changeCoverImage(image_file: params.image_file);
//   }
// }

// class ChangeCoverImageParams {
//   final File image_file;
//   const ChangeCoverImageParams({
//     required this.image_file,
//   });
// }
