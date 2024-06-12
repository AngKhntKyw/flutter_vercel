import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vercel/core/common/widget/loading.dart';
import 'package:flutter_vercel/core/util/get_current_location.dart';
import 'package:flutter_vercel/core/util/show_snack_bar.dart';
import 'package:flutter_vercel/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_vercel/features/auth/presentation/pages/login_page.dart';
import 'package:toastification/toastification.dart';

class FeedPage extends StatelessWidget {
  static const routeName = '/feed-page';
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;

    void logOUt() {
      context.read<AuthBloc>().add(AuthLogOut());
    }

    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              log("Logout fail");
            }
            if (state is AuthLogOutSuccess) {
              Navigator.pushReplacementNamed(context, LoginPage.routeName);
              SnackBars.showSuccessSnackBar(context, "Logout success.");
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const LoadingWidget(caption: "Logging out...");
            }

            if (state is AuthSuccess) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: CachedNetworkImageProvider(
                          fireAuth.currentUser!.photoURL!),
                    ),
                    const SizedBox(height: 10),
                    Text(fireAuth.currentUser!.displayName!),
                    ElevatedButton(
                        onPressed: logOUt, child: const Text("Log out")),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () async {
                          final position = await getCurrentLocation();
                          log(position.toString());
                        },
                        child: const Text("Location")),
                    ElevatedButton(
                        onPressed: () {
                          SnackBars.showSuccessSnackBar(context, "Show Noti");
                        },
                        child: const Text("Noti"))
                  ],
                ),
              );
            }
            return fireAuth.currentUser != null
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(
                              "https://${fireAuth.currentUser!.photoURL!}"),
                        ),
                        const SizedBox(height: 10),
                        Text(fireAuth.currentUser!.displayName!),
                        ElevatedButton(
                            onPressed: logOUt, child: const Text("Log out")),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () async {
                              final position = await getCurrentLocation();
                              log(position.toString());
                            },
                            child: const Text("Location")),
                        ElevatedButton(
                            onPressed: () {
                              SnackBars.showToastification(
                                  context, "Noti", ToastificationType.success);
                            },
                            child: const Text("Noti"))
                      ],
                    ),
                  )
                : const Text("User is logged out");
          },
        ),
      ),
    );
  }
}
