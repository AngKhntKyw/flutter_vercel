import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeJobPosition
    implements FutureUseCase<Null, ChangeJobPositionParams> {
  final UserRepository userRepository;
  const ChangeJobPosition(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeJobPositionParams params) async {
    return await userRepository.changeJobPosition(
        workExperience_id: params.workExperience_id,
        job_position: params.job_position);
  }
}

class ChangeJobPositionParams {
  final String workExperience_id;
  final String job_position;
  const ChangeJobPositionParams({
    required this.workExperience_id,
    required this.job_position,
  });
}
