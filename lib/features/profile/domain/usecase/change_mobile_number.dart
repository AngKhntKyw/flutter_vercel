import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeMobileNumber
    implements FutureUseCase<Null, ChangeMobileNumberParams> {
  final UserRepository userRepository;
  const ChangeMobileNumber(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeMobileNumberParams params) async {
    return await userRepository.changeMobileNumber(
      mobile_number: params.mobileNumber,
    );
  }
}

class ChangeMobileNumberParams {
  final String mobileNumber;
  const ChangeMobileNumberParams({
    required this.mobileNumber,
  });
}
