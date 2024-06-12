// ignore_for_file: non_constant_identifier_names

//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vercel/core/common/constant/constant.dart';
import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/features/profile/data/model/work_experience.dart';
import 'package:fpdart/fpdart.dart';
import '../../domain/repository/user_repository.dart';
import '../datasource/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>>
      getUserInfo() async {
    try {
      return right(userRemoteDataSource.getUserInfo());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getWorkExperiences() async {
    try {
      return right(userRemoteDataSource.getWorkExperiences());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addWorkExperience(
      {required WorkExperience workExperience}) async {
    try {
      return right(await userRemoteDataSource.addWorkExperience(
          workExperience: workExperience));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeCompanyName(
      {required String workExperience_id, required String company_name}) async {
    try {
      return right(await userRemoteDataSource.changeCompanyName(
          workExperience_id: workExperience_id, company_name: company_name));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeJobLocation(
      {required String workExperience_id, required String job_location}) async {
    try {
      return right(await userRemoteDataSource.changeJobLocation(
          workExperience_id: workExperience_id, job_location: job_location));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeJobPosition(
      {required String workExperience_id, required String job_position}) async {
    try {
      return right(await userRemoteDataSource.changeJobPosition(
          workExperience_id: workExperience_id, job_position: job_position));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeJobType(
      {required String workExperience_id, required String job_type}) async {
    try {
      return right(await userRemoteDataSource.changeJobType(
          workExperience_id: workExperience_id, job_type: job_type));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeWorkExperiencesDates(
      {required String workExperience_id,
      required String start_date,
      required String stop_date,
      required bool still_working}) async {
    try {
      return right(await userRemoteDataSource.changeWorkExperiencesDates(
        workExperience_id: workExperience_id,
        start_date: start_date,
        stop_date: stop_date,
        still_working: still_working,
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeAddress({required String address}) async {
    try {
      return right(await userRemoteDataSource.changeAddress(address: address));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeBirthDate(
      {required String birth_date}) async {
    try {
      return right(
          await userRemoteDataSource.changeBirthDate(birthDate: birth_date));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeGender({required String gender}) async {
    try {
      return right(await userRemoteDataSource.changeGender(gender: gender));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeMobileNumber(
      {required String mobile_number}) async {
    try {
      return right(await userRemoteDataSource.changeMobileNumber(
          mobileNumber: mobile_number));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeName({required String name}) async {
    try {
      return right(await userRemoteDataSource.changeName(name: name));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeNationality(
      {required String nationality}) async {
    try {
      return right(await userRemoteDataSource.changeNationality(
          nationality: nationality));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> changeProfessionalTitle(
      {required String professional_titlte}) async {
    try {
      return right(await userRemoteDataSource.changeProfessioonalTitle(
          professionalTitle: professional_titlte));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // @override
  // Future<Either<Failure, Null>> changeProfileImage(
  //     {required File image_file}) async {
  //   try {
  //     if (!await connectionChecker.hasConnection) {
  //       return left(const Failure(Constant.networkErrorMessage));
  //     }
  //     return right(
  //         await userRemoteDataSource.changeProfileImage(imageFile: image_file));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }

  // @override
  // Future<Either<Failure, Null>> changeCoverImage(
  //     {required File image_file}) async {
  //   try {
  //     if (!await connectionChecker.hasConnection) {
  //       return left(const Failure(Constant.networkErrorMessage));
  //     }
  //     return right(
  //         await userRemoteDataSource.changeCoverImage(imageFile: image_file));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }
}
