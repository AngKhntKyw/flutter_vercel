import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    log("Profile");
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("categories")
            .doc("tQX00uoMntVKNJNALx6e")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: RefreshProgressIndicator(),
            );
          }
          log("This works");
          final snapShotData = snapshot.data!['job_categories'] as List;
          return ListView.builder(
            itemCount: snapShotData.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapShotData[index]),
              );
            },
          );
        },
      ),
    );
  }
}
