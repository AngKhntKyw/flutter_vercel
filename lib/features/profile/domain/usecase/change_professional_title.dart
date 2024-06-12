import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeProfessionalTitle
    implements FutureUseCase<Null, ChangeProfessionalTitleParams> {
  final UserRepository userRepository;
  const ChangeProfessionalTitle(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(
      ChangeProfessionalTitleParams params) async {
    return await userRepository.changeProfessionalTitle(
        professional_titlte: params.professional_title);
  }
}

class ChangeProfessionalTitleParams {
  final String professional_title;
  const ChangeProfessionalTitleParams({
    required this.professional_title,
  });
}
