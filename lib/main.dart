import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vercel/auth_gate.dart';
import 'package:flutter_vercel/core/route/router.dart';
import 'package:flutter_vercel/core/theme/theme.dart';
import 'package:flutter_vercel/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_vercel/features/profile/presentation/bloc/user_bloc.dart';
import 'package:flutter_vercel/init_dependencies_main.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYbiR4rHowX5nqVv8MY5SOkZmr2OL3Svo",
      authDomain: "together-3.firebaseapp.com",
      projectId: "together-3",
      storageBucket: "together-3.appspot.com",
      messagingSenderId: "561074479638",
      appId: "1:561074479638:web:2ccfea337644c9d2b24b37",
      measurementId: "G-VP67QXFNT7",
    ),
  );
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => serviceLocator<UserBloc>(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vercel',
      theme: AppTheme.darkTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const AuthGate(),
    );
  }
}
