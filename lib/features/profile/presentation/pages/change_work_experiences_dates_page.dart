import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vercel/core/common/widget/loading.dart';
import 'package:flutter_vercel/core/util/change_date_format.dart';
import 'package:flutter_vercel/core/util/show_snack_bar.dart';
import 'package:flutter_vercel/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:flutter_vercel/features/profile/presentation/bloc/user_bloc.dart';
import 'package:flutter_vercel/features/profile/presentation/widgets/work_experiences_dates.dart';
import 'package:toastification/toastification.dart';

class ChangeWorkExperiencesDatesPage extends StatefulWidget {
  static const routeName = '/change-work-experiences-dates-page';
  final QueryDocumentSnapshot<Map<String, dynamic>> workExperience;

  const ChangeWorkExperiencesDatesPage(
      {super.key, required this.workExperience});

  @override
  State<ChangeWorkExperiencesDatesPage> createState() =>
      _ChangeWorkExperiencesDatesPageState();
}

class _ChangeWorkExperiencesDatesPageState
    extends State<ChangeWorkExperiencesDatesPage> {
  final formKey = GlobalKey<FormState>();
  final startDateController = TextEditingController();
  final stopDateController = TextEditingController();
  bool stillWorking = true;
  DateTime? startDate;
  DateTime? stopTime;

  @override
  void dispose() {
    startDateController.dispose();
    stopDateController.dispose();
    super.dispose();
  }

  void changeWorkExperiencesDates() {
    if (stillWorking) {
      stopDateController.text = DateTime.now().toString();
    }
    context.read<UserBloc>().add(UserChangeWorkExperiencesDates(
          widget.workExperience.id,
          startDateController.text,
          stopDateController.text,
          stillWorking,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start date & End date"),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is UserChangeWorkExperiencesDatesSuccess) {
            SnackBars.showToastification(
                context,
                "Changed Experiences Dates successfully.",
                ToastificationType.success);
            Navigator.pop(context);
            context.read<UserBloc>().add(UserGetWorkExperience());
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const LoadingWidget(caption: "");
          }
          return Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  ///
                  WorkExperienceDates(
                    dateController: startDateController,
                    hintText:
                        changeDateFormat(widget.workExperience['start_date']),
                  ),
                  //
                  SizedBox(height: size.height / 30),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Still working"),
                      Switch(
                        value: stillWorking,
                        onChanged: (value) {
                          setState(() {
                            stillWorking = value;
                          });
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: size.height / 30),

                  //
                  stillWorking
                      ? const SizedBox()
                      : WorkExperienceDates(
                          dateController: stopDateController,
                          hintText: changeDateFormat(
                              widget.workExperience['stop_date']),
                        ),

                  SizedBox(height: size.height / 30),
                  ElevatedButtons(
                    buttonName: "Change",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log("validted");
                        changeWorkExperiencesDates();
                      } else {
                        log("Not validated");
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
