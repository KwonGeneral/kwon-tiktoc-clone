import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_colors.dart';
import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_provider.dart';
import 'package:kwon_tiktoc_clone/presentation/feed/provider/feed_state.dart';

class TopTabBar extends ConsumerWidget {
  const TopTabBar({super.key});

  static const _tabs = [
    (AppStrings.feedTabFollowing, FeedTab.following),
    (AppStrings.feedTabRecommend, FeedTab.recommend),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab =
        ref.watch(feedNotifierProvider).valueOrNull?.selectedTab ??
            FeedTab.recommend;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var i = 0; i < _tabs.length; i++) ...[
              if (i > 0) const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  ref
                      .read(feedNotifierProvider.notifier)
                      .selectTab(_tabs[i].$2);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _tabs[i].$1,
                      style: selectedTab == _tabs[i].$2
                          ? AppTextStyles.tabActive
                          : AppTextStyles.tabInactive,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 24,
                      height: 2.5,
                      decoration: BoxDecoration(
                        color: selectedTab == _tabs[i].$2
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
