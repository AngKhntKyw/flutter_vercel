import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeBirthDate implements FutureUseCase<Null, ChangeBirthDateParams> {
  final UserRepository userRepository;
  const ChangeBirthDate(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeBirthDateParams params) async {
    return await userRepository.changeBirthDate(
      birth_date: params.birthDate,
    );
  }
}

class ChangeBirthDateParams {
  final String birthDate;
  const ChangeBirthDateParams({
    required this.birthDate,
  });
}
