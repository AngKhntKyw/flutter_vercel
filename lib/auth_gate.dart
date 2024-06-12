import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vercel/features/bottom_navigation_bar_page.dart';

import 'features/auth/presentation/pages/login_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    return fireAuth.currentUser == null
        ? const LoginPage()
        : const BottomNavigationBarPage();
  }
}
