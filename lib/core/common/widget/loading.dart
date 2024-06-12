import 'package:flutter/material.dart';
import 'package:flutter_vercel/core/theme/app_pallete.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final String caption;
  const LoadingWidget({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.discreteCircle(
            color: AppPallete.white,
            secondRingColor: AppPallete.elevatedButtonBackgroundColor,
            size: 30,
          ),
          const SizedBox(height: 50),
          Text(
            caption,
            style: Theme.of(context).primaryTextTheme.bodyMedium!.copyWith(
                color: AppPallete.elevatedButtonBackgroundColor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
