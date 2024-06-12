import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetWorkExperiences
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>, NoParams> {
  final UserRepository userRepository;
  const GetWorkExperiences(this.userRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      NoParams params) async {
    return await userRepository.getWorkExperiences();
  }
}
