// ignore_for_file: non_constant_identifier_names

//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vercel/core/error/failure.dart';
import 'package:flutter_vercel/features/profile/data/model/work_experience.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>>
      getUserInfo();
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getWorkExperiences();
  Future<Either<Failure, void>> addWorkExperience({
    required WorkExperience workExperience,
  });
  Future<Either<Failure, Null>> changeCompanyName({
    required String workExperience_id,
    required String company_name,
  });
  Future<Either<Failure, Null>> changeJobPosition({
    required String workExperience_id,
    required String job_position,
  });
  Future<Either<Failure, Null>> changeJobLocation({
    required String workExperience_id,
    required String job_location,
  });
  Future<Either<Failure, Null>> changeJobType({
    required String workExperience_id,
    required String job_type,
  });
  Future<Either<Failure, Null>> changeWorkExperiencesDates({
    required String workExperience_id,
    required String start_date,
    required String stop_date,
    required bool still_working,
  });
  Future<Either<Failure, Null>> changeName({required String name});

  Future<Either<Failure, Null>> changeGender({required String gender});

  Future<Either<Failure, Null>> changeBirthDate({required String birth_date});

  Future<Either<Failure, Null>> changeNationality(
      {required String nationality});

  Future<Either<Failure, Null>> changeMobileNumber(
      {required String mobile_number});

  Future<Either<Failure, Null>> changeAddress({required String address});

  Future<Either<Failure, Null>> changeProfessionalTitle(
      {required String professional_titlte});

  // Future<Either<Failure, Null>> changeProfileImage({required File image_file});

  // Future<Either<Failure, Null>> changeCoverImage({required File image_file});
}
