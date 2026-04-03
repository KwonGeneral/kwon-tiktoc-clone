import 'package:flutter/material.dart';

import 'package:kwon_tiktoc_clone/app/theme/app_text_styles.dart';
import 'package:kwon_tiktoc_clone/core/constants/app_strings.dart';
import 'package:kwon_tiktoc_clone/domain/entity/user.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({
    required this.user,
    this.onFollowingTap,
    this.onFollowersTap,
    super.key,
  });

  final User user;
  final VoidCallback? onFollowingTap;
  final VoidCallback? onFollowersTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildStat(
          '${user.followingCount}',
          AppStrings.profileFollowing,
          onTap: onFollowingTap,
        ),
        const SizedBox(width: 24),
        _buildStat(
          '${user.followerCount}',
          AppStrings.profileFollowers,
          onTap: onFollowersTap,
        ),
        const SizedBox(width: 24),
        _buildStat('${user.likeCount}', AppStrings.profileLikes),
      ],
    );
  }

  Widget _buildStat(String value, String label, {VoidCallback? onTap}) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: AppTextStyles.profileCount),
        const SizedBox(height: 2),
        Text(label, style: AppTextStyles.profileLabel),
      ],
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }
    return content;
  }
}
