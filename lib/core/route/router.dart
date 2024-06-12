import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vercel/core/common/widget/view_image_page.dart';
import 'package:flutter_vercel/features/auth/presentation/pages/fill_information_page.dart';
import 'package:flutter_vercel/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_vercel/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_vercel/features/bottom_navigation_bar_page.dart';
import 'package:flutter_vercel/features/feed/presentation/pages/feed_page.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/add_work_experiences_page.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/change_contacts.page.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/change_work_experiences_dates_page.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/work_experience.detail_page.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    // Login Screen
    case LoginPage.routeName:
      return PageTransition(
        child: const LoginPage(),
        type: PageTransitionType.rightToLeft,
        fullscreenDialog: true,
        duration: const Duration(milliseconds: 200),
      );

    // Sign Up Screen
    case SignUpPage.routeName:
      return PageTransition(
          child: const SignUpPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Fill Information Screen=
    case FillInformationPage.routeName:
      final arguments = routeSettings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final email = arguments['email'];
      final mobileNumber = arguments['mobileNumber'];
      final password = arguments['password'];
      final country = arguments['country'];
      final professionalTitle = arguments['professionalTitle'];
      return PageTransition(
          child: FillInformationPage(
              name: name,
              email: email,
              mobileNumber: mobileNumber,
              password: password,
              country: country,
              professionalTitle: professionalTitle),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Bottom Navigation Bar Screen
    case BottomNavigationBarPage.routeName:
      return PageTransition(
          child: const BottomNavigationBarPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Feed Screen
    case FeedPage.routeName:
      return PageTransition(
          child: const FeedPage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Profile Screen
    case ProfilePage.routeName:
      return PageTransition(
          child: const ProfilePage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Add Work Experience Screen
    case AddWorkExperiencePage.routeName:
      return PageTransition(
          child: const AddWorkExperiencePage(),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Add Work Experience Detail Screen
    case WorkExperienceDetailPage.routeName:
      final workExperience = routeSettings.arguments
          as QueryDocumentSnapshot<Map<String, dynamic>>;
      return PageTransition(
          child: WorkExperienceDetailPage(workExperience: workExperience),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Change Work Experiences Dates Screen
    case ChangeWorkExperiencesDatesPage.routeName:
      final workExperience = routeSettings.arguments
          as QueryDocumentSnapshot<Map<String, dynamic>>;
      return PageTransition(
          child: ChangeWorkExperiencesDatesPage(workExperience: workExperience),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Change Contacts Screen
    case ChangeContactsPage.routeName:
      final contacts = routeSettings.arguments as Map<String, dynamic>;
      return PageTransition(
          child: ChangeContactsPage(contacts: contacts),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // View Image Screen
    case ViewImagePage.routeName:
      final image = routeSettings.arguments as String;
      return PageTransition(
          child: ViewImagePage(image: image),
          type: PageTransitionType.rightToLeft,
          fullscreenDialog: true,
          duration: const Duration(milliseconds: 200));

    // Defaut Screen
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(body: Text("Not Existed")));
  }
}
