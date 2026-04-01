import 'package:flutter/material.dart';

import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entity/user.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStat('${user.followingCount}', AppStrings.profileFollowing),
        const SizedBox(width: 24),
        _buildStat('${user.followerCount}', AppStrings.profileFollowers),
        const SizedBox(width: 24),
        _buildStat('${user.likeCount}', AppStrings.profileLikes),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: AppTextStyles.profileCount),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.profileLabel),
      ],
    );
  }
}
