import 'package:flutter/material.dart';
import 'package:flutter_vercel/pages/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
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
          title: const Text("First Web App"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Posts"),
              Tab(text: "Profile"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text("This is Posts"),
            ),
            ProfilePage(),
          ],
        ),
      ),
    );
  }
}
