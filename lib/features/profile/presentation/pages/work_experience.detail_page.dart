import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vercel/core/common/widget/loading.dart';
import 'package:flutter_vercel/core/theme/app_pallete.dart';
import 'package:flutter_vercel/core/util/change_date_format.dart';
import 'package:flutter_vercel/core/util/show_snack_bar.dart';
import 'package:flutter_vercel/features/profile/presentation/bloc/user_bloc.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/change_work_experiences_dates_page.dart';
import 'package:flutter_vercel/features/profile/presentation/widgets/change_work_experience_text_fields.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class WorkExperienceDetailPage extends StatelessWidget {
  static const routeName = '/work-experience-detail-page';

  final QueryDocumentSnapshot<Map<String, dynamic>> workExperience;

  const WorkExperienceDetailPage({super.key, required this.workExperience});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final companyNameController = TextEditingController();
    final jobPositionController = TextEditingController();
    final jobLocationController = TextEditingController();
    final jobTypeController = TextEditingController();

    void changeCompanyName() {
      context.read<UserBloc>().add(
          UserChangeCompanyName(workExperience.id, companyNameController.text));
    }

    void changeJobPosition() {
      context.read<UserBloc>().add(
          UserChangeJobPosition(workExperience.id, jobPositionController.text));
    }

    void changeJobLocation() {
      context.read<UserBloc>().add(
          UserChangeJobLocation(workExperience.id, jobLocationController.text));
    }

    void changeJobType() {
      context
          .read<UserBloc>()
          .add(UserChangeJobType(workExperience.id, jobTypeController.text));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(workExperience['job_position']),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is UserChangeCompanyNameSuccess) {
            SnackBars.showToastification(
                context,
                "Company Name changed successfully.",
                ToastificationType.success);
            context.read<UserBloc>().add(UserGetWorkExperience());
          }
          if (state is UserChangeJobPositionSuccess) {
            SnackBars.showToastification(
                context,
                "Job position changed successfully.",
                ToastificationType.success);
            context.read<UserBloc>().add(UserGetWorkExperience());
          }
          if (state is UserChangeJobLocationSuccess) {
            SnackBars.showToastification(
                context,
                "Job Location changed successfully.",
                ToastificationType.success);
            context.read<UserBloc>().add(UserGetWorkExperience());
          }
          if (state is UserChangeJobTypeSuccess) {
            SnackBars.showToastification(context,
                "Job Type changed successfully.", ToastificationType.success);
            context.read<UserBloc>().add(UserGetWorkExperience());
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const LoadingWidget(caption: "");
          }
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: SizedBox(
                  height: size.width,
                  width: size.width,
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://images.unsplash.com/photo-1516321497487-e288fb19713f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                                  fit: BoxFit.cover,
                                  width: size.width,
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                width: size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      workExperience['job_position'],
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyMedium,
                                    ),
                                    Text(workExperience['company_name']),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const CircleAvatar(
                          radius: 65,
                          backgroundColor: AppPallete.scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: AppPallete.scaffoldBackgroundColor,
                            child: Icon(
                              Iconsax.briefcase_bold,
                              size: 60,
                              color: AppPallete.elevatedButtonBackgroundColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
                ),
              ),
              const ListTile(
                title: Text("Details"),
              ),
              SizedBox(
                width: size.width,
                child: Card(
                  child: Column(
                    children: [
                      const ListTile(title: Text("Company")),
                      ChangeWorkExperienceTextFields(
                        controller: companyNameController,
                        title: workExperience['company_name'],
                        onPressed: changeCompanyName,
                      ),
                      const ListTile(title: Text("Position")),
                      ChangeWorkExperienceTextFields(
                        controller: jobPositionController,
                        title: workExperience['job_position'],
                        onPressed: changeJobPosition,
                      ),
                      const ListTile(title: Text("Location")),
                      ChangeWorkExperienceTextFields(
                        controller: jobLocationController,
                        title: workExperience['job_location'],
                        onPressed: changeJobLocation,
                      ),
                      const ListTile(title: Text("Type")),
                      ChangeWorkExperienceTextFields(
                        controller: jobTypeController,
                        title: workExperience['job_type'],
                        onPressed: changeJobType,
                      ),
                      ListTile(
                        title: const Text("Start Date & End Date"),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                ChangeWorkExperiencesDatesPage.routeName,
                                arguments: workExperience,
                              );
                            },
                            icon: const Icon(Iconsax.edit_2_bold)),
                      ),
                      ListTile(
                        leading: const Icon(Iconsax.calendar_2_bold),
                        title: const Text("Start Date"),
                        subtitle: Text(
                            changeDateFormat(workExperience['start_date'])),
                      ),
                      ListTile(
                        leading: const Icon(Iconsax.calendar_2_bold),
                        title: Text(
                          workExperience['still_working']
                              ? "Still working"
                              : "End Date",
                        ),
                        subtitle: Text(workExperience['still_working']
                            ? "Still working"
                            : changeDateFormat(workExperience['stop_date'])),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
