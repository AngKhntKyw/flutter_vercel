import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vercel/core/common/widget/loading.dart';
import 'package:flutter_vercel/core/theme/app_pallete.dart';
import 'package:flutter_vercel/core/util/duration_different.dart';
import 'package:flutter_vercel/core/util/show_snack_bar.dart';
import 'package:flutter_vercel/features/profile/presentation/bloc/user_bloc.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/add_work_experiences_page.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/work_experience.detail_page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class WorkExperiences extends StatefulWidget {
  const WorkExperiences({super.key});

  @override
  State<WorkExperiences> createState() => _WorkExperiencesState();
}

class _WorkExperiencesState extends State<WorkExperiences> {
  final user_id = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    log("EXP Build");
    context.read<UserBloc>().add(UserGetWorkExperience());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("Work Experiences"),
            trailing: IconButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                      context, AddWorkExperiencePage.routeName);
                  result == true
                      ? context.read<UserBloc>().add(UserGetWorkExperience())
                      : null;
                },
                icon: const Icon(
                  Iconsax.add_bold,
                  color: AppPallete.white,
                )),
          ),
          BlocConsumer<UserBloc, UserState>(
            listener: (context, state) {
              if (state is UserFailure) {
                SnackBars.showToastification(
                    context, state.message, ToastificationType.error);
              }
            },
            builder: (context, state) {
              if (state is UserLoading) {
                return const LoadingWidget(caption: "");
              }
              if (state is UserGetWorkExperienceSuccess) {
                return StreamBuilder(
                  stream: state.workExperiences,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const LoadingWidget(caption: "");
                    }
                    final snapShotData = snapshot.data!.docs;
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapShotData.length,
                        itemBuilder: (context, index) {
                          final workExperience = snapShotData[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, WorkExperienceDetailPage.routeName,
                                  arguments: workExperience);
                            },
                            child: Card(
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                isThreeLine: true,
                                leading: const Icon(Iconsax.briefcase_bold),
                                title: Text(workExperience['job_position'],
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .bodyMedium),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workExperience['company_name'],
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodySmall,
                                    ),
                                    Text(
                                      workExperience['job_location'],
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodySmall,
                                    ),
                                  ],
                                ),
                                trailing: Text(workExperience['still_working']
                                    ? "Still working"
                                    : calculateDurationDifference(
                                            DateTime.parse(
                                                workExperience['start_date']),
                                            DateTime.parse(
                                                workExperience['stop_date']))
                                        .toString()),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
              return IconButton(
                onPressed: () {
                  context.read<UserBloc>().add(UserGetWorkExperience());
                },
                icon: const Icon(Icons.refresh, size: 40),
              );
            },
          ),
        ],
      ),
    );
  }
}
