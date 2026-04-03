import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';

class TopTabBar extends StatelessWidget {
  const TopTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(AppStrings.feedTabRecommend, style: AppTextStyles.tabActive),
              SizedBox(height: 4),
              SizedBox(
                width: 24,
                height: 2.5,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
