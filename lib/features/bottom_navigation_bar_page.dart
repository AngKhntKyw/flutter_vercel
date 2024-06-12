import 'package:flutter/material.dart';
import 'package:flutter_vercel/core/common/widget/bottom_navigation_bar_item_widget.dart';
import 'package:flutter_vercel/features/feed/presentation/pages/feed_page.dart';
import 'package:flutter_vercel/features/feed/presentation/provider/home_navigator_provider.dart';
import 'package:flutter_vercel/features/profile/presentation/pages/profile_page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarPage extends StatelessWidget {
  static const routeName = '/bottom-navigation-bar-page';
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const FeedPage(),
      const FeedPage(),
      const FeedPage(),
      const ProfilePage()
    ];

    return ChangeNotifierProvider(
      create: (context) => HomeNavigatorProvider(),
      builder: (context, child) {
        return Scaffold(
          body: pages[context.watch<HomeNavigatorProvider>().currentpageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:
                context.watch<HomeNavigatorProvider>().currentpageIndex,
            onTap: (value) =>
                context.read<HomeNavigatorProvider>().changePage(value),
            items: [
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Home",
                icon: const Icon(Iconsax.home_1_bulk),
              ),
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Favorite",
                icon: const Icon(Iconsax.heart_bold),
              ),
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Chat",
                icon: const Icon(Iconsax.message_2_bulk),
              ),
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Profile",
                icon: const Icon(Iconsax.profile_tick_bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
