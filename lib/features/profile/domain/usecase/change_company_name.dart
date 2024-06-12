// ignore_for_file: non_constant_identifier_names

import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangeCompanyName
    implements FutureUseCase<Null, ChangeCompanyNameParams> {
  final UserRepository userRepository;
  const ChangeCompanyName(this.userRepository);

  @override
  Future<Either<Failure, Null>> call(ChangeCompanyNameParams params) async {
    return await userRepository.changeCompanyName(
      workExperience_id: params.workExperience_id,
      company_name: params.company_name,
    );
  }
}

class ChangeCompanyNameParams {
  final String workExperience_id;
  final String company_name;
  const ChangeCompanyNameParams({
    required this.workExperience_id,
    required this.company_name,
  });
}
