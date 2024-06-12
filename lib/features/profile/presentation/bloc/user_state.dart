part of 'user_bloc.dart';

@immutable
sealed class UserState {
  const UserState();
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserSuccess extends UserState {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> userInfo;
  const UserSuccess(this.userInfo);
}

final class UserFailure extends UserState {
  final String message;
  const UserFailure(this.message);
}

final class UserGetWorkExperienceSuccess extends UserState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> workExperiences;
  const UserGetWorkExperienceSuccess(this.workExperiences);
}

final class UserAddWorkExperienceSuccess extends UserState {}

final class UserChangeCompanyNameSuccess extends UserState {}

final class UserChangeJobPositionSuccess extends UserState {}

final class UserChangeJobLocationSuccess extends UserState {}

final class UserChangeJobTypeSuccess extends UserState {}

final class UserChangeWorkExperiencesDatesSuccess extends UserState {}

final class UserChangeNameSuccess extends UserState {}

final class UserChangeGenderSuccess extends UserState {}

final class UserChangeNationalitySuccess extends UserState {}

final class UserChangeMobileNumberSuccess extends UserState {}

final class UserChangeAddressSuccess extends UserState {}

final class UserChangeBirthDateSuccess extends UserState {}

final class UserChangeProfessionalTitleSuccess extends UserState {}

final class UserChangeProfileImageSuccess extends UserState {}

final class UserChangeCoverImageSuccess extends UserState {}
