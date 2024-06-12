part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class UserGetUserInfo extends UserEvent {
  UserGetUserInfo();
}

final class UserGetWorkExperience extends UserEvent {
  UserGetWorkExperience();
}

final class UserAddWorkExperience extends UserEvent {
  final WorkExperience workExperience;
  UserAddWorkExperience(this.workExperience);
}

final class UserChangeCompanyName extends UserEvent {
  final String workExperience_id;
  final String company_name;
  UserChangeCompanyName(this.workExperience_id, this.company_name);
}

final class UserChangeJobPosition extends UserEvent {
  final String workExperience_id;
  final String job_position;
  UserChangeJobPosition(this.workExperience_id, this.job_position);
}

final class UserChangeJobLocation extends UserEvent {
  final String workExperience_id;
  final String job_location;
  UserChangeJobLocation(this.workExperience_id, this.job_location);
}

final class UserChangeJobType extends UserEvent {
  final String workExperience_id;
  final String job_type;
  UserChangeJobType(this.workExperience_id, this.job_type);
}

final class UserChangeWorkExperiencesDates extends UserEvent {
  final String workExperience_id;
  final String start_date;
  final String stop_date;
  final bool still_working;
  UserChangeWorkExperiencesDates(
    this.workExperience_id,
    this.start_date,
    this.stop_date,
    this.still_working,
  );
}

final class UserChangeName extends UserEvent {
  final String name;
  UserChangeName(this.name);
}

final class UserChangeGender extends UserEvent {
  final String gender;
  UserChangeGender(this.gender);
}

final class UserChangeNationality extends UserEvent {
  final String nationality;
  UserChangeNationality(this.nationality);
}

final class UserChangeMobileNumber extends UserEvent {
  final String mobile_number;
  UserChangeMobileNumber(this.mobile_number);
}

final class UserChangeAddress extends UserEvent {
  final String address;
  UserChangeAddress(this.address);
}

final class UserChangeBirthDate extends UserEvent {
  final String birth_date;
  UserChangeBirthDate(this.birth_date);
}

final class UserChangeProfessionalTitle extends UserEvent {
  final String prefessional_title;
  UserChangeProfessionalTitle(this.prefessional_title);
}

// final class UserChangeProfileImage extends UserEvent {
//   final File image_file;
//   UserChangeProfileImage(this.image_file);
// }

// final class UserChangeCoverImage extends UserEvent {
//   final File image_file;
//   UserChangeCoverImage(this.image_file);
// }
