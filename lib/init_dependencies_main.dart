import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_vercel/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flutter_vercel/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_vercel/features/auth/domain/usecase/log_in_with_email_and_password.dart';
import 'package:flutter_vercel/features/auth/domain/usecase/log_out.dart';
import 'package:flutter_vercel/features/auth/domain/usecase/sign_up_with_email_and_password.dart';
import 'package:flutter_vercel/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_vercel/features/profile/data/datasource/user_remote_datasource.dart';
import 'package:flutter_vercel/features/profile/data/repository/user_repository_impl.dart';
import 'package:flutter_vercel/features/profile/domain/repository/user_repository.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/add_work_experience.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_address.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_birth_date.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_company_name.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_gender.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_job_location.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_job_position.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_job_type.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_mobile_number.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_name.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_nationality.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_professional_title.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/change_work_experiences_dates.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/get_user_info.dart';
import 'package:flutter_vercel/features/profile/domain/usecase/get_work_experiences.dart';
import 'package:flutter_vercel/features/profile/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'features/auth/data/respoitory/auth_repository_impl.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  initFirebase();
  initAuth();
  initUser();
}

void initFirebase() {
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final fireMessage = FirebaseMessaging.instance;
  final fireStorage = FirebaseStorage.instance;
  serviceLocator.registerLazySingleton(() => fireAuth);
  serviceLocator.registerLazySingleton(() => fireStore);
  serviceLocator.registerLazySingleton(() => fireMessage);
  serviceLocator.registerLazySingleton(() => fireStorage);
}

void initAuth() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(
          fireAuth: serviceLocator(),
          fireMessage: serviceLocator(),
          fireStore: serviceLocator(),
          fireStorage: serviceLocator(),
        ))

    //Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
          authRemoteDataSource: serviceLocator(),
        ))

    //Usecase
    ..registerFactory(() => SignUpWithEmailAndPassword(serviceLocator()))
    ..registerFactory(() => LogInWithEmailAndPassword(serviceLocator()))
    ..registerFactory(() => LogOut(serviceLocator()))

    //Bloc
    ..registerFactory(() => AuthBloc(
          signUpWithEmailAndPassword: serviceLocator(),
          logInWithEmailAndPassword: serviceLocator(),
          logOut: serviceLocator(),
        ));
}

void initUser() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(
          fireAuth: serviceLocator(),
          fireStore: serviceLocator(),
          fireMessage: serviceLocator(),
          firebaseStorage: serviceLocator(),
        ))

    //Repository
    ..registerFactory<UserRepository>(
      () => UserRepositoryImpl(
        userRemoteDataSource: serviceLocator(),
      ),
    )

    //Usecase
    ..registerFactory(() => GetUserInfo(serviceLocator()))
    ..registerFactory(() => GetWorkExperiences(serviceLocator()))
    ..registerFactory(() => AddWorkExperience(serviceLocator()))
    ..registerFactory(() => ChangeCompanyName(serviceLocator()))
    ..registerFactory(() => ChangeJobPosition(serviceLocator()))
    ..registerFactory(() => ChangeJobLocation(serviceLocator()))
    ..registerFactory(() => ChangeJobType(serviceLocator()))
    ..registerFactory(() => ChangeWorkExperiencesDates(serviceLocator()))
    ..registerFactory(() => ChangeName(serviceLocator()))
    ..registerFactory(() => ChangeGender(serviceLocator()))
    ..registerFactory(() => ChangeNationality(serviceLocator()))
    ..registerFactory(() => ChangeMobileNumber(serviceLocator()))
    ..registerFactory(() => ChangeAddress(serviceLocator()))
    ..registerFactory(() => ChangeBirthDate(serviceLocator()))
    ..registerFactory(() => ChangeProfessionalTitle(serviceLocator()))
    // ..registerFactory(() => ChangeProfileImage(serviceLocator()))
    // ..registerFactory(() => ChangeCoverImage(serviceLocator()))

    //Bloc
    ..registerFactory(() => UserBloc(
          getUserInfo: serviceLocator(),
          getWorkExperiences: serviceLocator(),
          addWorkExperience: serviceLocator(),
          changeCompanyName: serviceLocator(),
          changeJobPosition: serviceLocator(),
          changeJobLocation: serviceLocator(),
          changeJobType: serviceLocator(),
          changeWorkExperiencesDates: serviceLocator(),
          changeName: serviceLocator(),
          changeGender: serviceLocator(),
          changeNationality: serviceLocator(),
          changeMobileNumber: serviceLocator(),
          changeAddress: serviceLocator(),
          changeBirthDate: serviceLocator(),
          changeProfessionalTitle: serviceLocator(),
          // changeProfileImage: serviceLocator(),
          // changeCoverImage: serviceLocator(),
        ));
}
