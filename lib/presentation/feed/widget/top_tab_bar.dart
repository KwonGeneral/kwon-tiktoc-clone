import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';

class TopTabBar extends StatefulWidget {
  const TopTabBar({super.key});

  @override
  State<TopTabBar> createState() => _TopTabBarState();
}

class _TopTabBarState extends State<TopTabBar> {
  int _selectedIndex = 1; // 기본: 추천

  static const _tabs = [
    AppStrings.feedTabFollowing,
    AppStrings.feedTabRecommend,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 탭 목록
            for (var i = 0; i < _tabs.length; i++) ...[
              if (i > 0) const SizedBox(width: 20),
              GestureDetector(
                onTap: () => setState(() => _selectedIndex = i),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _tabs[i],
                      style: i == _selectedIndex
                          ? AppTextStyles.tabActive
                          : AppTextStyles.tabInactive,
                    ),
                    const SizedBox(height: 4),
                    // 활성 탭 밑줄
                    Container(
                      width: 24,
                      height: 2.5,
                      decoration: BoxDecoration(
                        color: i == _selectedIndex
                            ? AppColors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
