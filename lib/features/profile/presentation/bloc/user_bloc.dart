//import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vercel/core/usecase/usecase.dart';
import 'package:flutter_vercel/features/profile/data/model/work_experience.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/add_work_experience.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_address.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_birth_date.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_company_name.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_cover_image.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_gender.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_job_location.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_job_position.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_job_type.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_mobile_number.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_name.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_nationality.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_professional_title.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_profile_image.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_work_experiences_dates.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/get_user_info.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/get_work_experiences.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserInfo _getUserInfo;
  final GetWorkExperiences _getWorkExperiences;
  final AddWorkExperience _addWorkExperience;
  final ChangeCompanyName _changeCompanyName;
  final ChangeJobPosition _changeJobPosition;
  final ChangeJobLocation _changeJobLocation;
  final ChangeJobType _changeJobType;
  final ChangeWorkExperiencesDates _changeWorkExperiencesDates;
  final ChangeName _changeName;
  final ChangeGender _changeGender;
  final ChangeNationality _changeNationality;
  final ChangeMobileNumber _changeMobileNumber;
  final ChangeAddress _changeAddress;
  final ChangeBirthDate _changeBirthDate;
  final ChangeProfessionalTitle _changeProfessionalTitle;
  // final ChangeProfileImage _changeProfileImage;
  // final ChangeCoverImage _changeCoverImage;

  UserBloc({
    required GetUserInfo getUserInfo,
    required GetWorkExperiences getWorkExperiences,
    required AddWorkExperience addWorkExperience,
    required ChangeCompanyName changeCompanyName,
    required ChangeJobPosition changeJobPosition,
    required ChangeJobLocation changeJobLocation,
    required ChangeJobType changeJobType,
    required ChangeWorkExperiencesDates changeWorkExperiencesDates,
    required ChangeName changeName,
    required ChangeGender changeGender,
    required ChangeNationality changeNationality,
    required ChangeMobileNumber changeMobileNumber,
    required ChangeAddress changeAddress,
    required ChangeBirthDate changeBirthDate,
    required ChangeProfessionalTitle changeProfessionalTitle,
    // required ChangeProfileImage changeProfileImage,
    // required ChangeCoverImage changeCoverImage,
  })  : _getUserInfo = getUserInfo,
        _getWorkExperiences = getWorkExperiences,
        _addWorkExperience = addWorkExperience,
        _changeCompanyName = changeCompanyName,
        _changeJobPosition = changeJobPosition,
        _changeJobLocation = changeJobLocation,
        _changeJobType = changeJobType,
        _changeWorkExperiencesDates = changeWorkExperiencesDates,
        _changeName = changeName,
        _changeGender = changeGender,
        _changeMobileNumber = changeMobileNumber,
        _changeNationality = changeNationality,
        _changeBirthDate = changeBirthDate,
        _changeAddress = changeAddress,
        _changeProfessionalTitle = changeProfessionalTitle,
        // _changeProfileImage = changeProfileImage,
        // _changeCoverImage = changeCoverImage,
        super(UserInitial()) {
    on<UserEvent>((_, emit) => emit(UserLoading()));
    on<UserGetUserInfo>(onUserGetUserInfo);
    on<UserGetWorkExperience>(onUserGetWorkExperiences);
    on<UserAddWorkExperience>(onUserAddWorkExperience);
    on<UserChangeCompanyName>(onUserChangeCompanyName);
    on<UserChangeJobPosition>(onUserChangeJobPosition);
    on<UserChangeJobLocation>(onUserChangeJobLocation);
    on<UserChangeJobType>(onUserChangeJobType);
    on<UserChangeWorkExperiencesDates>(onUserChangeWorkExperiencesDates);
    on<UserChangeName>(onUserChangeName);
    on<UserChangeGender>(onUserChangeGender);
    on<UserChangeNationality>(onUserChangeNationality);
    on<UserChangeMobileNumber>(onUserChangeMobileNumber);
    on<UserChangeAddress>(onUserChangeAddress);
    on<UserChangeBirthDate>(onUserChangeBirthDate);
    on<UserChangeProfessionalTitle>(onUserChangeProfessionalTitle);
    // on<UserChangeProfileImage>(onUserChangeProfileImage);
    // on<UserChangeCoverImage>(onUserChangeCoverImage);
  }

  void onUserGetUserInfo(UserGetUserInfo event, Emitter<UserState> emit) async {
    final response = await _getUserInfo.call(NoParams());

    response.fold((failure) => emit(UserFailure(failure.message)),
        (user) => emit(UserSuccess(user)));
  }

  void onUserGetWorkExperiences(
      UserGetWorkExperience event, Emitter<UserState> emit) async {
    final response = await _getWorkExperiences.call(NoParams());

    response.fold(
        (failure) => emit(UserFailure(failure.message)),
        (workExperiences) =>
            emit(UserGetWorkExperienceSuccess(workExperiences)));
  }

  void onUserAddWorkExperience(
      UserAddWorkExperience event, Emitter<UserState> emit) async {
    final response = await _addWorkExperience
        .call(AddWorkExperienceParams(workExperience: event.workExperience));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserAddWorkExperienceSuccess()));
  }

  void onUserChangeCompanyName(
      UserChangeCompanyName event, Emitter<UserState> emit) async {
    final response = await _changeCompanyName.call(ChangeCompanyNameParams(
        workExperience_id: event.workExperience_id,
        company_name: event.company_name));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeCompanyNameSuccess()));
  }

  void onUserChangeJobPosition(
      UserChangeJobPosition event, Emitter<UserState> emit) async {
    final response = await _changeJobPosition.call(ChangeJobPositionParams(
        workExperience_id: event.workExperience_id,
        job_position: event.job_position));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeJobPositionSuccess()));
  }

  void onUserChangeJobLocation(
      UserChangeJobLocation event, Emitter<UserState> emit) async {
    final response = await _changeJobLocation.call(ChangeJobLocationParams(
        workExperience_id: event.workExperience_id,
        job_location: event.job_location));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeJobLocationSuccess()));
  }

  void onUserChangeJobType(
      UserChangeJobType event, Emitter<UserState> emit) async {
    final response = await _changeJobType.call(ChangeJobTypeParams(
        workExperience_id: event.workExperience_id, job_type: event.job_type));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeJobTypeSuccess()));
  }

  void onUserChangeWorkExperiencesDates(
      UserChangeWorkExperiencesDates event, Emitter<UserState> emit) async {
    final response = await _changeWorkExperiencesDates.call(
        ChangeWorkExperiencesDatesParams(
            workExperience_id: event.workExperience_id,
            start_date: event.start_date,
            stop_date: event.stop_date,
            still_working: event.still_working));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeWorkExperiencesDatesSuccess()));
  }

  void onUserChangeName(UserChangeName event, Emitter<UserState> emit) async {
    final response = await _changeName.call(ChangeNameParams(name: event.name));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeNameSuccess()));
  }

  void onUserChangeGender(
      UserChangeGender event, Emitter<UserState> emit) async {
    final response =
        await _changeGender.call(ChangeGenderParams(gender: event.gender));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeGenderSuccess()));
  }

  void onUserChangeNationality(
      UserChangeNationality event, Emitter<UserState> emit) async {
    final response = await _changeNationality
        .call(ChangeNationalityParams(nationality: event.nationality));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeNationalitySuccess()));
  }

  void onUserChangeMobileNumber(
      UserChangeMobileNumber event, Emitter<UserState> emit) async {
    final response = await _changeMobileNumber
        .call(ChangeMobileNumberParams(mobileNumber: event.mobile_number));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeMobileNumberSuccess()));
  }

  void onUserChangeAddress(
      UserChangeAddress event, Emitter<UserState> emit) async {
    final response =
        await _changeAddress.call(ChangeAddressParams(address: event.address));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeAddressSuccess()));
  }

  void onUserChangeBirthDate(
      UserChangeBirthDate event, Emitter<UserState> emit) async {
    final response = await _changeBirthDate
        .call(ChangeBirthDateParams(birthDate: event.birth_date));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeBirthDateSuccess()));
  }

  void onUserChangeProfessionalTitle(
      UserChangeProfessionalTitle event, Emitter<UserState> emit) async {
    final response = await _changeProfessionalTitle.call(
        ChangeProfessionalTitleParams(
            professional_title: event.prefessional_title));

    response.fold((failure) => emit(UserFailure(failure.message)),
        (_) => emit(UserChangeProfessionalTitleSuccess()));
  }

  // void onUserChangeProfileImage(
  //     UserChangeProfileImage event, Emitter<UserState> emit) async {
  //   final response = await _changeProfileImage
  //       .call(ChangeProfileImageParams(image_file: event.image_file));

  //   response.fold((failure) => emit(UserFailure(failure.message)),
  //       (_) => emit(UserChangeProfileImageSuccess()));
  // }

  // void onUserChangeCoverImage(
  //     UserChangeCoverImage event, Emitter<UserState> emit) async {
  //   final response = await _changeCoverImage
  //       .call(ChangeCoverImageParams(image_file: event.image_file));

  //   response.fold((failure) => emit(UserFailure(failure.message)),
  //       (_) => emit(UserChangeCoverImageSuccess()));
  // }
}
