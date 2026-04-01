import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../provider/profile_provider.dart';
import '../widget/profile_empty_state.dart';
import '../widget/profile_header.dart';
import '../widget/profile_stats.dart';
import '../widget/profile_tab_bar.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(user: user),
            const SizedBox(height: 16),
            ProfileStats(user: user),
            const SizedBox(height: 16),
            _buildBioRow(),
            const SizedBox(height: 16),
            ProfileTabBar(
              selectedIndex: _selectedTabIndex,
              onTap: (index) => setState(() => _selectedTabIndex = index),
            ),
            const ProfileEmptyState(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.black,
      elevation: 0,
      leadingWidth: 80,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          children: [
            const Icon(
              Icons.person_add_outlined,
              color: AppColors.white,
              size: 24,
            ),
            const SizedBox(width: 4),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Text(
                '2',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: const [
        Icon(Icons.more_horiz, color: AppColors.white, size: 24),
        SizedBox(width: 8),
        Icon(Icons.send_outlined, color: AppColors.white, size: 24),
        SizedBox(width: 8),
        Icon(Icons.menu, color: AppColors.white, size: 24),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildBioRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                AppStrings.profileAddBio,
                style: AppTextStyles.profileLabel.copyWith(
                  color: AppColors.whiteSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 14,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      AppStrings.profileInterests,
                      style: AppTextStyles.profileLabel.copyWith(
                        color: AppColors.whiteSecondary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
