import 'dart:developer';
//import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vercel/core/common/widget/loading.dart';
import 'package:flutter_vercel/core/common/widget/view_image_page.dart';
import 'package:flutter_vercel/core/theme/app_pallete.dart';
import 'package:flutter_vercel/core/util/change_date_format.dart';
import 'package:flutter_vercel/core/util/show_snack_bar.dart';
import 'package:flutter_vercel/features/profile/presentation/bloc/user_bloc.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/change_contacts.page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final user_id = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    log("PP Build");
    context.read<UserBloc>().add(UserGetUserInfo());
    super.initState();
  }

  // void changeProfileImage() async {
  //   XFile? pickedXFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedXFile != null) {
  //     File imageFile = File(pickedXFile.path);
  //     context.read<UserBloc>().add(UserChangeProfileImage(imageFile));
  //   }
  // }

  // void changeCoverImage() async {
  //   XFile? pickedXFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedXFile != null) {
  //     File imageFile = File(pickedXFile.path);
  //     context.read<UserBloc>().add(UserChangeCoverImage(imageFile));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFailure) {
          SnackBars.showToastification(
              context, state.message, ToastificationType.error);
        }
        if (state is UserChangeProfileImageSuccess) {
          SnackBars.showToastification(context, "Profile changed successfully.",
              ToastificationType.success);
          context.read<UserBloc>().add(UserGetUserInfo());
        }
        if (state is UserChangeCoverImageSuccess) {
          SnackBars.showToastification(context, "Cover changed successfully.",
              ToastificationType.success);
          context.read<UserBloc>().add(UserGetUserInfo());
        }
      },
      builder: (context, state) {
        if (state is UserLoading) {
          return const LoadingWidget(caption: "");
        }
        if (state is UserSuccess) {
          return StreamBuilder(
            stream: state.userInfo,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const LoadingWidget(caption: "");
              }
              final snapShotData = snapshot.data!.data();
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
                                  child: Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            ViewImagePage.routeName,
                                            arguments:
                                                snapShotData['cover_url'],
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                snapShotData!['cover_url'],
                                            fit: BoxFit.cover,
                                            width: size.width,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        // onPressed: changeCoverImage,
                                        onPressed: () {},
                                        icon: const Icon(
                                          Iconsax.camera_bold,
                                          color: AppPallete
                                              .elevatedButtonBackgroundColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: size.width,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapShotData['name'],
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                            snapShotData['professional_title']),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ViewImagePage.routeName,
                                        arguments: snapShotData['profile_url']);
                                  },
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundColor:
                                        AppPallete.scaffoldBackgroundColor,
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundColor:
                                          AppPallete.scaffoldBackgroundColor,
                                      foregroundImage:
                                          CachedNetworkImageProvider(
                                        snapShotData['profile_url'],
                                      ),
                                    ),
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      AppPallete.cardBackgroundColor,
                                  child: IconButton(
                                    // onPressed: changeProfileImage,
                                    onPressed: () {},
                                    icon: const Icon(
                                      Iconsax.refresh_circle_bold,
                                      color: AppPallete
                                          .elevatedButtonBackgroundColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                    ),
                  ),
                  ListTile(
                    title: const Text("Contacts"),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ChangeContactsPage.routeName,
                            arguments: snapShotData);
                      },
                      icon: const Icon(Iconsax.card_edit_bold),
                    ),
                    iconColor: AppPallete.white,
                  ),
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Iconsax.profile_circle_bold),
                          title: const Text("Gender"),
                          subtitle: Text(snapShotData['gender']),
                        ),
                        ListTile(
                          leading: const Icon(Iconsax.flag_bold),
                          title: const Text("Nationality"),
                          subtitle: Text(snapShotData['nationality']),
                        ),
                        ListTile(
                          leading: const Icon(Iconsax.calendar_1_bold),
                          title: const Text("Birth Date"),
                          subtitle: Text(
                              changeDateFormat(snapShotData['birth_date'])),
                        ),
                        ListTile(
                          leading: const Icon(Iconsax.message_2_bold),
                          title: const Text("Email"),
                          subtitle: Text(snapShotData['email']),
                        ),
                        ListTile(
                          leading: const Icon(Iconsax.call_bold),
                          title: const Text("Mobile Number"),
                          subtitle: Text(snapShotData['mobile_number']),
                        ),
                        ListTile(
                          leading: const Icon(Iconsax.house_bold),
                          title: const Text("Address"),
                          subtitle: Text(snapShotData['address']),
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          );
        }
        return IconButton(
          onPressed: () {
            context.read<UserBloc>().add(UserGetUserInfo());
          },
          icon: const Icon(Icons.refresh, size: 40),
        );
      },
    );
  }
}
