import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_text_styles.dart';
import '../../../core/constants/app_strings.dart';
import '../../../domain/entity/user.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({required this.user, super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        // 프로필 아바타
        _buildAvatar(),
        const SizedBox(height: 12),
        // 이름 + 편집 버튼
        _buildNameRow(),
        const SizedBox(height: 4),
        // @user_id
        Text('@${user.id}', style: AppTextStyles.profileId),
      ],
    );
  }

  Widget _buildAvatar() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        CircleAvatar(
          radius: 44,
          backgroundColor: AppColors.gray,
          backgroundImage: user.avatarUrl.isNotEmpty
              ? NetworkImage(user.avatarUrl)
              : null,
          child: user.avatarUrl.isEmpty
              ? const Icon(
                  Icons.person,
                  size: 44,
                  color: AppColors.whiteSecondary,
                )
              : null,
        ),
        Positioned(
          bottom: -6,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 16, color: AppColors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildNameRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.lock, size: 16, color: AppColors.white),
        const SizedBox(width: 4),
        Text(user.nickname, style: AppTextStyles.profileName),
        const SizedBox(width: 4),
        const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.white),
        const SizedBox(width: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            AppStrings.profileEdit,
            style: AppTextStyles.profileLabel.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
