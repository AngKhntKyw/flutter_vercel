import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vercel/core/common/widget/loading.dart';
import 'package:flutter_vercel/core/util/show_snack_bar.dart';
import 'package:flutter_vercel/features/profile/presentation/bloc/user_bloc.dart';
import 'package:flutter_vercel/features/profile/presentation/widgets/change_work_experience_text_fields.dart';
import 'package:toastification/toastification.dart';

class ChangeContactsPage extends StatefulWidget {
  static const routeName = '/change-contacts-page';

  final Map<String, dynamic> contacts;
  const ChangeContactsPage({super.key, required this.contacts});

  @override
  State<ChangeContactsPage> createState() => _ChangeContactsPageState();
}

class _ChangeContactsPageState extends State<ChangeContactsPage> {
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final nationalityController = TextEditingController();
  final birthdateController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final addressController = TextEditingController();
  final professionalTitleController = TextEditingController();

  @override
  void dispose() {
    genderController.dispose();
    nationalityController.dispose();
    birthdateController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    professionalTitleController.dispose();
    super.dispose();
  }

  void changeName() {
    context.read<UserBloc>().add(UserChangeName(nameController.text));
  }

  void changeGender() {
    context.read<UserBloc>().add(UserChangeGender(genderController.text));
  }

  void changeNationality() {
    context
        .read<UserBloc>()
        .add(UserChangeNationality(nationalityController.text));
  }

  void changeMobileNumeber() {
    context
        .read<UserBloc>()
        .add(UserChangeMobileNumber(mobileNumberController.text));
  }

  void changeAddress() {
    context.read<UserBloc>().add(UserChangeAddress(addressController.text));
  }

  void changeProfessionalTitle() {
    context
        .read<UserBloc>()
        .add(UserChangeProfessionalTitle(professionalTitleController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFailure) {
            SnackBars.showToastification(
                context, state.message, ToastificationType.error);
          }
          if (state is UserChangeNameSuccess) {
            SnackBars.showToastification(context, "Named changed successfully.",
                ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo());
          }
          if (state is UserChangeGenderSuccess) {
            SnackBars.showToastification(context,
                "Gender changed successfully.", ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo());
          }
          if (state is UserChangeNationalitySuccess) {
            SnackBars.showToastification(
                context,
                "Nationality changed successfully.",
                ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo());
          }
          if (state is UserChangeMobileNumberSuccess) {
            SnackBars.showToastification(
                context,
                "Mobile Number changed successfully.",
                ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo());
          }
          if (state is UserChangeAddressSuccess) {
            SnackBars.showToastification(context,
                "Address changed successfully.", ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo());
          }
          if (state is UserChangeBirthDateSuccess) {
            SnackBars.showToastification(context,
                "BirthDate changed successfully.", ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo());
          }
          if (state is UserChangeProfessionalTitleSuccess) {
            SnackBars.showToastification(
                context,
                "Professional Titlte changed successfully.",
                ToastificationType.success);
            context.read<UserBloc>().add(UserGetUserInfo());
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const LoadingWidget(caption: "");
          }
          return Card(
            child: ListView(
              children: [
                const ListTile(title: Text("Name")),
                ChangeWorkExperienceTextFields(
                  controller: nameController,
                  title: widget.contacts['name'],
                  onPressed: changeName,
                ),
                const ListTile(title: Text("Professional Title")),
                ChangeWorkExperienceTextFields(
                  controller: professionalTitleController,
                  title: widget.contacts["professional_title"],
                  onPressed: changeProfessionalTitle,
                ),
                const ListTile(title: Text("Gender")),
                ChangeWorkExperienceTextFields(
                  controller: genderController,
                  title: widget.contacts['gender'],
                  onPressed: changeGender,
                ),
                const ListTile(title: Text("Nationality")),
                ChangeWorkExperienceTextFields(
                  controller: nationalityController,
                  title: widget.contacts['nationality'],
                  onPressed: changeNationality,
                ),
                const ListTile(title: Text("Mobile Number")),
                ChangeWorkExperienceTextFields(
                  controller: mobileNumberController,
                  title: widget.contacts['mobile_number'],
                  onPressed: changeMobileNumeber,
                ),
                const ListTile(title: Text("Address")),
                ChangeWorkExperienceTextFields(
                  controller: addressController,
                  title: widget.contacts['address'],
                  onPressed: changeAddress,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
