import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeGender implements FutureUseCase<Null, ChangeGenderParams> {
  final UserRepository userRepository;
  const ChangeGender(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeGenderParams params) async {
    return await userRepository.changeGender(
      gender: params.gender,
    );
  }
}

class ChangeGenderParams {
  final String gender;
  const ChangeGenderParams({
    required this.gender,
  });
}
