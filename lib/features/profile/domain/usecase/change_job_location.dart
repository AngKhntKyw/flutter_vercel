import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeJobLocation
    implements FutureUseCase<Null, ChangeJobLocationParams> {
  final UserRepository userRepository;
  const ChangeJobLocation(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeJobLocationParams params) async {
    return await userRepository.changeJobLocation(
        workExperience_id: params.workExperience_id,
        job_location: params.job_location);
  }
}

class ChangeJobLocationParams {
  final String workExperience_id;
  final String job_location;
  const ChangeJobLocationParams({
    required this.workExperience_id,
    required this.job_location,
  });
}
