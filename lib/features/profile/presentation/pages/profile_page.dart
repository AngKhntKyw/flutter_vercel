import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vercel/features/profile/presentation/widgets/profile_card.dart';
import 'package:flutter_vercel/features/profile/presentation/widgets/work_experiences.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile-page';

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              automaticIndicatorColorAdjustment: true,
              isScrollable: false,
              physics: const BouncingScrollPhysics(),
              tabs: const [
                Tab(text: 'User Profile'),
                Tab(text: 'Work Experience'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                dragStartBehavior: DragStartBehavior.down,
                children: const [
                  ProfileCard(),
                  WorkExperiences(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
